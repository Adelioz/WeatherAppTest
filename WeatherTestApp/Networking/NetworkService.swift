//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    

    
    func request(urlString: String, completion: @escaping (WeatherModel?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("error")
                    completion(nil, error)
                }
                
                guard let data = data else { return }
                
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(weather, nil)
                } catch {
                    print("failedJSON!!!!")
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
}
