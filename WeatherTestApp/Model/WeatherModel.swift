//
//  WeatherModel.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

struct WeatherModel: Decodable {
    var weather: [Weather]
    var main: Main
    var name: String
    var dt: Double
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var humidity: Int
}
