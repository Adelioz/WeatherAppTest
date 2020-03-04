//
//  ViewController.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var chooseLocationButton: UIButton!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = String(format: "%@+%@", "Kazan", "8a335d2249676ad7e019ba340c5191e3")
        
        let formatted = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(formatted)
        
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


}

