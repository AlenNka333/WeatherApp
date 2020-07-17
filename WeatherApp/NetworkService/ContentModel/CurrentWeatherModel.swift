//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let name: String
    let dt: Int
    let sys: SunRS
    let wind: Wind
    let main: Main
    let weather: Array<Weather>
}

struct SunRS: Codable {
    let sunrise: Int
    let sunset: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
}

struct Weather: Codable {
    let main: String
    let description: String
}
