//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func convertToDate (with dt: Double) -> String {
            let date = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
    }
    static func convertToTime (with dt: Double) -> String {
            let date = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
    }
}
