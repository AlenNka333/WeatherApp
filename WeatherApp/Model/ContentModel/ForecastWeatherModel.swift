//
//  CurrentWeather.swift
//  IOSWeather
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeather: Decodable {
    let city: City
    let list: Array<Forecast>
}

struct City: Decodable {
    let name: String
    let sunrise: Int
    let sunset: Int
}

struct Forecast: Decodable {
    let main: Temperature
    let weather: Array<Details>
    let dtTxt: String
}

struct Temperature: Decodable {
    let temp: Double
    let feelsLike: Double
}

class Details: Decodable {
    var description: String
    var icon: String
    var uiImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case description
        case icon
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.description = try values.decode(String.self, forKey: .description)
        let name = try values.decode(String.self, forKey: .icon)
        self.icon = name
        
        let (img, error) = DownLoadImageHelper.downloadImage(with: name)
        
        if error != nil {
            throw error.unsafelyUnwrapped
            
        }
        else {
            self.uiImage = img
        }
    }
    
}
