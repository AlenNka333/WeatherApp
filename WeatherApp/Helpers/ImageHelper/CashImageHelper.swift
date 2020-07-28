//
//  CashImageHelper.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class CashImageHelper {
    
    private let fileName = "images"
    
    static func checkData (forKey key: String) -> Bool {
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
            let _ = UIImage(data: imageData) {
            return true
        }
        return false
    }
    
    static func retrieve (forKey key: String) -> UIImage? {
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
            let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    static func store (image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        }
    }
    
}
