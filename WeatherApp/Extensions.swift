//
//  Extensions.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/24/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
             return false
        }
        return true
    }
}

extension UILabel {
    
    func setSizeFont (sizeFont: Double) {
        self.font = UIFont(name: "Times New Roman", size: CGFloat(sizeFont))
    }
    
}
