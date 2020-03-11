//
//  ForecastModel.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 08.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

struct ForecastModel: Decodable {
    var list: [List]
}

struct List: Decodable {
    var dt: Double
    var main: MainForecast
    var weather: [WeatherForecast]
}

struct MainForecast: Decodable {
    var temp: Double
    var humidity: Int
}

struct WeatherForecast: Decodable {
    var id: Int
    var icon: String
}
