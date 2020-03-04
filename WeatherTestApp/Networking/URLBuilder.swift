//
//  URLBuilder.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 04.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation

class URLBuilder {
    
    let apiKey = "8a335d2249676ad7e019ba340c5191e3"
    
    func buildURL(city: String) -> URL? {
        
        var urlComp = URLComponents()
        
        urlComp.scheme = "https"
        urlComp.host = "api.openweathermap.org"
        urlComp.path = "/data/2.5/weather"
        urlComp.queryItems = [URLQueryItem(name: "q", value: city), URLQueryItem(name: "appid", value: apiKey)]
        
        return urlComp.url
        
    }
    
}
