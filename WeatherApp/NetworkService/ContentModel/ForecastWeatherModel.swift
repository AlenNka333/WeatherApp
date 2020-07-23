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
    let sunrise: Int
    let sunset: Int
}

struct Forecast: Codable {
    let main: Temperature
    let weather: Array<Details>
    let dtTxt: String
}

struct Temperature: Codable {
    let temp: Double
    let feelsLike: Double
}

struct Details: Codable {
    let description: String
    let icon: String
}
