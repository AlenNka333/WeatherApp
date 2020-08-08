//
//  ImageHelperErrors.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum ImageHelperErrors: Error {
    case invalidUrl
    case failedToLoad
    case failedToStoreImage
}
