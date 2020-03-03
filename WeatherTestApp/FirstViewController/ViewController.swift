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
        
        let url = URL(string: "https://api.darksky.net/forecast/6d86ccda003a203ff6664ea8df2861c1/37.8267,-122.4233")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { print("error"); return }
            
            print(data)
        }
        task.resume()
        
    }


}

