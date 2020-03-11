//
//  ViewController.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var chooseLocationButton: UIButton!
    
    var secondViewController: SecondViewController!
    
    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    //let networkService = NetworkService()
    let urlBuilder = URLBuilder()
    var forecastResult: ForecastModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDate()
        nextButton.isHidden = true
        
    }
    
    func setupDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        todayLabel.text = "Сегодня " + dateFormatter.string(from: date) + ","
        print(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        print(dateFormatter.string(from: date))
    }
    
    

    
    @IBAction func chooseLocationPressed(_ sender: Any) {
        print("but check")
        getLocation()
        
    }
    
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let city = cityTextField.text else {
            print("no city")
            return
        }
        
        guard let urlCurr = URLBuilder().buildURL(city: city) else { return }
        guard let urlForecast = URLBuilder().buildForecastURL(city: city) else { return }
        let networkServiceWeather = NetworkService<WeatherModel>(url: urlCurr)
        let networkServiceForecast = NetworkService<ForecastModel>(url: urlForecast)
        
        networkServiceWeather.request { result in
            
            switch result {
            case .noNetwork:
                self.showAlert(code: 0)
            case .noLocation:
                self.showAlert(code: 1)
            case .result(let model):
                self.performSegue(withIdentifier: "weatherSegue", sender: model)
                return
            }
            
        }
        
        networkServiceForecast.request { (result) in
            switch result {
                
            case .noNetwork:
                self.showAlert(code: 0)
            case .noLocation:
                self.showAlert(code: 1)
            case .result(let model):
                self.forecastResult = model
            }
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSegue" {
            let navController = segue.destination as! UINavigationController
            let secondViewController = navController.topViewController as! SecondViewController
            secondViewController.currentWeather = sender as? WeatherModel
            secondViewController.forecastWeather = forecastResult
        }
    }
    
    func showAlert(code: Int) {
        
        var alert = UIAlertController()
        
        if code == 0 {
            alert = UIAlertController(title: "че-то не то", message: "интернет не работает!", preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "че-то не то", message: "а такого города нет!", preferredStyle: .alert)
        }
        let action = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
            showLocationAlert()
            // TODO: show Error / alert and how to check permissions
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            showLocationAlert()
            //TODO: Show Error / alert and how to turn on services
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func getLocation() {
        checkLocationServices()
        cityTextField.text = ""
        locationManager.requestLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                
                if let _ = error {
                    //TODO: error/alert
                }
                
                guard let placemark = placemarks?.first else {
                    //TODO: error/alert
                    return
                }
                
                guard let cityName = placemark.locality else {
                    //TODO: error/alert
                    return
                }
                
                DispatchQueue.main.async {
                    self.cityTextField.text = cityName
                    self.nextButton.isHidden = false
                    print(cityName)
                }
                
            }
            
        } else {
            print("xuilo")
        }



    }
    
    func showLocationAlert() {
        let alert = UIAlertController(title: "Гео выключены", message: "включите геолокации", preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    

    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nextButton.isHidden = textField.text == nil ? true : textField.text!.count == 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
