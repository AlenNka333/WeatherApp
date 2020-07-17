//
//  CurrentWeather.swift
//  IOSWeather
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

struct ForecastWeather: Codable {
    let city: City
    let list: Array<Forecast>
}

struct City: Codable {
    let name: String
}

struct Forecast: Codable {
    let weather: Array<DetailWeather>
    let dtTxt: String
}

struct DetailWeather: Codable {
    let main: String
    let description: String
    let icon: String
}

