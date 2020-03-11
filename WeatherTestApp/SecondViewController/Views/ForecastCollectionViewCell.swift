//
//  ForecastCollectionViewCell.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 11.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    

    let reuseId = "forecastCell"
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var verticalLabel: UILabel!
    @IBOutlet weak var horizontalLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    
    func setup(weather: ForecastModel, indexPath: Int) {
        let days = dates(model: weather)
        let time = NSDate(timeIntervalSince1970: days[indexPath].dt) as Date
        let verticalIndicators = calculateVertical(weather: days)
        
        
        tempLabel.text = "\(Int(days[indexPath].main.temp - 273))°C"
        hourLabel.text = "\(time.hour)"
        iconImage.image = DescriptionCodes.getIcon(iconCode: days[indexPath].weather.last!.icon)
        
        if indexPath == 0 {
            horizontalLabel.text = "           _ _ _ _"
        } else if indexPath == 17 {
            horizontalLabel.textAlignment = .left
            horizontalLabel.text = "_ _ _ _           "
        } else {
            horizontalLabel.text = "_ _ _ _  _ _ _ _"
        }
        
        verticalLabel.text = buildVerticals(height: verticalIndicators[indexPath])
        
    }
    
    func dates(model: ForecastModel) -> [List] {
        var days: [List] = []
        for i in 0...17 {
            days.append(model.list[i])
        }
        return days
    }
    
    func calculateVertical(weather: [List]) -> [Int] {
        
        let absTemp = weather.map { abs(Int($0.main.temp - 273)) }
        let average = Float(absTemp.reduce(0, +)) / Float(absTemp.count)
        
        var result = [Float]()
        var resultInt = [Int]()
        for temp in absTemp {
            var value : Float = 0.5
            if average != 0 {
                value += (Float(temp) - average) / (3 * average)
                value = value > 1 ? 1 : value
                value = value < 0 ? 0 : value
            }
            result.append(value)
        }
        for i in 0...(result.count - 1) {
            resultInt.append(Int(result[i] * 10))
        }
        return resultInt
    }
    
    func buildVerticals(height: Int) -> String {
        var result = ""
        let lineBreaks = 9 - height
        let lines = height - 1
        
        if lineBreaks > 0 {
            for _ in 1...lineBreaks{
                result += "\n"
            }
        }
        
        if lines > 0 {
            result += "★\n"
            if lines - 1 > 0 {
                for _ in 1...lines - 1 {
                    result += "|\n"
                }
            }
            result += "|"
        } else {
            result += "★"
        }
        
        return result
    }
    
}
