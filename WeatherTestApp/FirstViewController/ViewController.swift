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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let build = URLBuilder()
//        request.request(urlString: build.buildURL(city: "Kazan")!) { (weatherModel, error) in
//
//            if let error = error {
//                print(error)
//            }
//
//            guard let model = weatherModel else { print(error!); return }
//
//            print(model.name)
//
//        }
        
        setupDate()
        
    }
    
    func setupDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        todayLabel.text = "Сегодня " + dateFormatter.string(from: date)
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
        
        guard let url = URLBuilder().buildURL(city: city) else { return }
        let networkService = NetworkService(url: url)
        
        networkService.request { result in
            
            switch result {
            case .noNetwork:
                print("pizdec")
            case .noLocation:
                print("pizdec nahui")
            case .result(let model):
                print("aaaaaaa \(model.name)")
                self.performSegue(withIdentifier: "weatherSegue", sender: model)
                return
            }
            
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSegue" {
            let navController = segue.destination as! UINavigationController
            let secondViewController = navController.topViewController as! SecondViewController
            secondViewController.currentWeather = sender as! WeatherModel
            //secondViewController.city = cityTextField.text!
            //secondViewController.currentWeather = sender as? WeatherModel
            
            
        }
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
            
            // TODO: show Error / alert and how to check permissions
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
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
                    print(cityName)
                }
                
            }
            
        } else {
            print("xuilo")
        }



    }
    
}
