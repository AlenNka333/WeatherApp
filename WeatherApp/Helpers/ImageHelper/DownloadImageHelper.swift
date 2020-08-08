//
//  DownloadImageHelper.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class DownLoadImageHelper {
    
    private static let imgPath = "https://openweathermap.org/img/w/"
    
    static func downloadImage(with iconCode: String) -> (UIImage?, Error?) {
        
        let check = CashImageHelper.checkData(forKey: iconCode)
        if check {
            let image = CashImageHelper.retrieve(forKey: iconCode)
            return (image, nil)
        } else {
            guard let iconURL = URL(string: imgPath + iconCode + ".png") else {
                return (nil, ImageHelperErrors.invalidUrl)
            }
            guard let data = try? Data(contentsOf: iconURL) else {
                return (nil, ImageHelperErrors.failedToLoad)
            }
            guard let image = UIImage(data: data) else {
                return (nil, ImageHelperErrors.failedToStoreImage)
            }
            CashImageHelper.store(image: image, forKey: iconCode)
            return (image, nil)
        }
    }
}
