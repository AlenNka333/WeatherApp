//
//  ApiDataManagerErrors.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/18/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum ApiDataManagerErrors: Error {
    case invalidURL
    case invalidResponse
    case badResponse(statusCode: Int)
    case invalidData
    case decodeError
}
