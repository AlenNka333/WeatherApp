//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    let weatherImageView = UIImageView()
    let date = UILabel()
    let weatherDescription = UILabel()
    let temperature = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        
        date.setSizeFont(sizeFont: 20)
        weatherDescription.setSizeFont(sizeFont: 18)
        temperature.setSizeFont(sizeFont: 30)
        
        contentView.addSubview(weatherImageView)
        contentView.addSubview(date)
        contentView.addSubview(weatherDescription)
        contentView.addSubview(temperature)
        
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        let views = [
            "image" : weatherImageView,
            "date" : date,
            "description" : weatherDescription,
            "temperature" : temperature
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[image(50)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:[temperature]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[date]-15-[description]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[image(50)]-[date]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[image(50)]-[description]-[temperature]-|",
            options: [],
            metrics: nil,
            views: views)
        
        NSLayoutConstraint.activate(allConstraints)
        
        
    }

}



