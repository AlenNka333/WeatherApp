//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let name: String
    let dt: Double
    let sys: SunRS
    let wind: Wind
    let main: Main
    let weather: Array<Weather>
}

struct SunRS: Decodable {
    let sunrise: Int
    let sunset: Int
}

struct Wind: Decodable {
    let speed: Double
}

struct Main: Decodable {
    let temp: Double
    let pressure: Double
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
}
