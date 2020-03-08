//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 03.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

enum RequestResult {
    case noNetwork
    case noLocation
    case result(WeatherModel)
}

class NetworkService {
    

    var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func request(completion: @escaping (RequestResult) -> Void) {
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            var result: RequestResult
            
            if let error = error as NSError?, error.code == -999 {
                print(error)
                result = .noNetwork
            } else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200{
                    print(response)
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

    
//    func request(urlString: URL, completion: @escaping (WeatherModel?, Error?) -> Void) {
//        //guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
//
//
//                if let error = error {
//                    print("error")
//                    completion(nil, error)
//                }
//
//                guard let data = data else { return }
//
//                let result = self.parseJSON(data: data)
//
//                DispatchQueue.main.async {
//                    completion(result, nil)
//                }
//
//
////                do {
////                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
////                    completion(weather, nil)
////                } catch {
////                    print("failedJSON!!!!")
////                    completion(nil, error)
////                }
//
//
//
//
//        }.resume()
//    }
    
    
    func parseJSON(data: Data) -> WeatherModel {
        return try! JSONDecoder().decode(WeatherModel.self, from: data)
    }
    
}
