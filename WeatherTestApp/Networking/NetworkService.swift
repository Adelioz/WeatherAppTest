//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

enum RequestResult<T> {
    case noNetwork
    case noLocation
    case result(T)
}

class NetworkService<T> where T: Decodable {
    

    var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func request(completion: @escaping (RequestResult<T>) -> Void) {
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            var result: RequestResult<T>
            
            if let error = error as NSError?, error.code == -999 {
                print(error)
                result = .noNetwork
            } else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    result = .result(self.parseJSON(data: data!))
                } else {
                    result = .noLocation
                }
            } else {
                result = .noNetwork
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }).resume()
    }
    
    func parseJSON(data: Data) -> T {
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
}
