//
//  SecondViewController.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var perceivedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var currentWeather: WeatherModel!
    var city: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCurrentWeather()
        
    }
    
    func requestWeather() {
        
        
    }
    
    
    func setupCurrentWeather() {
        
        tempLabel.text = String(Int(currentWeather.main.temp - 273))
        print(currentWeather.name)
        
    }
    

   

}
