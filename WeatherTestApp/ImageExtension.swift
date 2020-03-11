//
//  ImageExtension.swift
//  WeatherTestApp
//
//  Created by Адель Рахимов on 11.03.2020.
//  Copyright © 2020 Адель Рахимов. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func save(_ name: String) -> URL{
        let path: String = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true).first!
        let url = URL(fileURLWithPath: path).appendingPathComponent(name)
        try! self.jpegData(compressionQuality: 1)?.write(to: url)
        return url
    }
}
