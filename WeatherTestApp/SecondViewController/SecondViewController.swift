//
//  SecondViewController.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var currentWeatherView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var perceivedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var currentWeather: WeatherModel!
    var forecastWeather: ForecastModel!
    var city: String!
    var style: AppStyleStruct!
    let titleText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        setupCurrentWeather()
        setupTableView()
        setupCollectionView()
        setupColor()
        if forecastWeather != nil {
            scrollView.delegate = nil
            print("chkhsgjjshg")
        }
    }

    
    func setupColor() {
        style = AppStyle.currentStyle
        let color = style.color.withAlphaComponent(0.7)
        currentWeatherView.backgroundColor = color
        forecastCollectionView.backgroundColor = color
        view.backgroundColor = color
        forecastTableView.backgroundColor = color
        backgroundImage.image = UIImage(named: "background_" + style.name)
        backgroundImage.contentMode = .scaleToFill
        navigationController?.navigationBar.barTintColor = AppStyle.navigationBarColor(style: style)
        
        titleText.textColor = .white
        titleText.text = currentWeather.name
        self.navigationItem.titleView = titleText
    }
    
    func createShareImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 375, height: 400))
        style = AppStyle.currentStyle
        let color = style.color.withAlphaComponent(0.7)
        let temp = "\(Int(currentWeather.main.temp - 273))"
        let celc = "°C"
        let descr = DescriptionCodes.getDescription(weatherId: currentWeather.weather.last!.id)
        let icon = DescriptionCodes.getIcon(iconCode: currentWeather.weather.last!.icon)
        let perc = "Ощущается: \(Int(currentWeather.main.feels_like - 273))° C"
        let humid = "Влажность: \(currentWeather.main.humidity)%"
        
        let image = renderer.image { ctx in
            backgroundImage.image!.draw(in: view.bounds, blendMode: .normal, alpha: 1)
            let bounds = CGRect(x: 0, y: 70, width: 375, height: 180)

            
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.fill(bounds)
            ctx.cgContext.addLine(to: CGPoint(x: 187, y: 230))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
            
            let tempPar = NSMutableParagraphStyle()
            tempPar.alignment = .right
            let tempBound = CGRect(x: 20, y: 90, width: 120, height: 100)
            let tempAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 80),
                             NSAttributedString.Key.foregroundColor: UIColor.white,
                             NSAttributedString.Key.paragraphStyle: tempPar]
            temp.draw(with: tempBound, options: .usesLineFragmentOrigin, attributes: tempAttrs as [NSAttributedString.Key : Any], context: nil)
        
            let celcBound = CGRect(x: 140, y: 110, width: 24, height: 24)
            let celcAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 20),
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            celc.draw(with: celcBound, options: .usesLineFragmentOrigin, attributes: celcAttrs as [NSAttributedString.Key : Any], context: nil)
            
            let iconBound = CGRect(x: 210, y: 90, width: 100, height: 100)
            icon.draw(in: iconBound)
            
            let descrBound = CGRect(x: 20, y: 180, width: 150, height: 60)
            let descrAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 22),
                              NSAttributedString.Key.foregroundColor: UIColor.white]
            descr.draw(with: descrBound, options: .usesLineFragmentOrigin, attributes: descrAttrs as [NSAttributedString.Key : Any], context: nil)
            
            let percBound = CGRect(x: 210, y: 190, width: 150, height: 20)
            let percAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 14),
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            perc.draw(with: percBound, options: .usesLineFragmentOrigin, attributes: percAttrs as [NSAttributedString.Key : Any], context: nil)
            
            let humidBound = CGRect(x: 210, y: 210, width: 150, height: 20)
            let humidAttrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 14),
                              NSAttributedString.Key.foregroundColor: UIColor.white]
            humid.draw(with: humidBound, options: .usesLineFragmentOrigin, attributes: humidAttrs as [NSAttributedString.Key : Any], context: nil)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let font = UIFont(name: "HelveticaNeue-Medium", size: 18)!
            let attrs = [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle,
                         NSAttributedString.Key.foregroundColor: UIColor.white]
            let strBounds = CGRect(x: 0, y: 35, width: 375, height: 400)
            titleText.text!.draw(with: strBounds, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        return image
    }
    
    func shareImage(with message: String) {
        let image = createShareImage()
        let url = image.save("share.jpeg")
        
        let objectsToShare = [message, url] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        shareImage(with: "Приветики")
    }
    
    func setupCurrentWeather() {
        if Int(currentWeather.main.temp - 273) > 0 {
            tempLabel.text = "+\(Int(currentWeather.main.temp - 273))"
        } else {
            tempLabel.text = "\(Int(currentWeather.main.temp - 273))"
        }
        descrLabel.text = DescriptionCodes.getDescription(weatherId: currentWeather.weather.last!.id)
        if Int(currentWeather.main.feels_like - 273) > 0 {
            perceivedLabel.text = "Ощущается: +\(Int(currentWeather.main.feels_like - 273))° C"
        } else {
            perceivedLabel.text = "Ощущается: \(Int(currentWeather.main.feels_like - 273))° C"
        }
        humidityLabel.text = "Влажность: \(currentWeather.main.humidity)%"
        tempLabel.sizeToFit()
        titleLabel.title = "\(currentWeather.name)"
        
    }
    

    @IBAction func cancelItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}


extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = forecastWeather {
            return 6
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOscarLox") as! DayTableViewCell
        guard let model = forecastWeather else { print("coooooooo \(indexPath.row)"); return cell }
        
        if indexPath.row == 0 {

            cell.dayLabel.text = "Сегодня"
            cell.descrLabel.text = DescriptionCodes.getDescription(weatherId: currentWeather.weather.last!.id)
            cell.iconView.image = DescriptionCodes.getIcon(iconCode: currentWeather.weather.last!.icon)
            cell.tempHumidLabel.text = "\(Int(currentWeather.main.temp - 273)) / \(currentWeather.main.humidity)%"
            cell.separatorInset = .zero
            return cell

        }
        
        cell.setup(weather: model, indexPath: indexPath.row - 1)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

        return cell
    }
    
    
    
    func setupTableView() {
        guard let _ = forecastWeather else { forecastTableView.isHidden = true; return }
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
    }
    
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForecastCollectionViewCell
        guard let model = forecastWeather else { print("coooooooo \(indexPath.row)"); return cell }
        cell.setup(weather: model, indexPath: indexPath.row)
        
        return cell
    }
    
    func setupCollectionView() {
        guard let _ = forecastWeather else { forecastCollectionView.isHidden = true; return }
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        let layout = forecastCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 60, height: 150)
    }
    
    
}
