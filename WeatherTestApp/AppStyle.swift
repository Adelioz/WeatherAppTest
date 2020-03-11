//
//  AppStyle.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 11.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

struct AppStyleStruct {
    var name: String
    var description: String
    var color: UIColor
}

var appStyles: [String : AppStyleStruct] = {
    var result: [String : AppStyleStruct] = [:]
    result["winter"] = AppStyleStruct(name: "winter",
                                      description: "Зима",
                                      color: UIColor(red: 66/255.0, green: 78/255.0, blue: 198/255.0, alpha: 1))
    result["spring"] = AppStyleStruct(name: "spring",
                                      description: "Весна",
                                      color: UIColor(red: 255/255.0, green: 150/255.0, blue: 204/255.0, alpha: 1))
    result["summer"] = AppStyleStruct(name: "summer",
                                      description: "Лето",
                                      color: UIColor(red: 204/255.0, green: 197/255.0, blue: 109/255.0, alpha: 1))
    result["autumn"] = AppStyleStruct(name: "autumn",
                                      description: "Осень",
                                      color: UIColor(red: 212/255.0, green: 137/255.0, blue: 28/255.0, alpha: 1))
    return result
}()

class AppStyle {
    
    
    
    private static func getSeason() -> String{
        let now = Date()
        return now.season
    }
    
    private (set) static var currentStyle: AppStyleStruct = {
        return appStyles[getSeason()]!
    }()
    
    public static func navigationBarColor(style: AppStyleStruct) -> UIColor {
        switch style.name {
        case "winter":
            return UIColor(red: 48/255.0, green: 56/255.0, blue: 142/255.0, alpha: 1)
        case "spring":
            return UIColor(red: 154/255.0, green: 0/255.0, blue: 132/255.0, alpha: 1)
        case "summer":
            return UIColor(red: 161/255.0, green: 156/255.0, blue: 87/255.0, alpha: 1)
        case "autumn":
            return UIColor(red: 157/255.0, green: 102/255.0, blue: 21/255.0, alpha: 1)
        default:
            return .clear
        }
    }
    
}
