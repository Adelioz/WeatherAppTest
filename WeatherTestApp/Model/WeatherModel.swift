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
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var humidity: Int
}


//class WeatherModel: Codable {
//    var temperature: Int
//    var humidity: Int
//    var name: String
//
//
//    enum CodingKeys: String, CodingKey {
//        case main
//        case name
//    }
//
//    enum MainCodingKeys: String, CodingKey{
//        case temp
//        case humidity
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        var mainContainer = container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
//
//        try mainContainer.encode(temperature, forKey: .temp)
//        try mainContainer.encode(humidity, forKey: .humidity)
//
//    }
//
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let mainContainer = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
//        let kelvin = try mainContainer.decode(Float.self, forKey: .temp)
//        let names = try container.decode(String.self, forKey: .name)
//
//        temperature = Int(kelvin)
//        humidity = Int(try mainContainer.decode(Float.self, forKey: .humidity))
//        name = names
//    }
//
//}





