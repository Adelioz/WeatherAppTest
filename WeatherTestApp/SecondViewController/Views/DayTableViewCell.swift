//
//  DayTableViewCell.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 09.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {


    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var tempHumidLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    
    
    func setup(weather: ForecastModel, indexPath: Int) {
        
        let days = dates(model: weather)
        let time = NSDate(timeIntervalSince1970: days[indexPath].dt) as Date
        
        dayLabel.text = time.shortDayName
        descrLabel.text = DescriptionCodes.getDescription(weatherId: days[indexPath].weather.last!.id)
        
        tempHumidLabel.text = "\(Int(days[indexPath].main.temp - 273)) / \(days[indexPath].main.humidity)%"
        iconView.image = DescriptionCodes.getIcon(iconCode: days[indexPath].weather.last!.icon)
    }
    
    
    func dates(model: ForecastModel) -> [List] {
        var days: [List] = []
        for day in model.list {
            let time = NSDate(timeIntervalSince1970: day.dt) as Date
            let calendar = Calendar.current
            if calendar.component(.hour, from: time) == 15 {
                
                days.append(day)
            }
        }
        return days
    }
    
    
    
    
    


    
}
