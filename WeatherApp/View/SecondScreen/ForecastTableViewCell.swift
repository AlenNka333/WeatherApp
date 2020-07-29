//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit
import SnapKit

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
    
    func configure(with weather: Forecast) {
        self.date.text = weather.dtTxt
        self.weatherDescription.text = weather.weather[0].description
        self.temperature.text = "\(weather.main.feelsLike) °C"
        self.weatherImageView.image = weather.weather[0].uiImage
    }
    
    func commonInit() {
    
        date.setSizeFont(sizeFont: 20)
        date.textColor = .white
        weatherDescription.setSizeFont(sizeFont: 18)
        weatherDescription.textColor = .white
        temperature.setSizeFont(sizeFont: 30)
        temperature.textColor = .white
        
        contentView.addSubview(weatherImageView)
        contentView.addSubview(date)
        contentView.addSubview(weatherDescription)
        contentView.addSubview(temperature)
        
        contentView.backgroundColor = .clear
        weatherImageView.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        temperature.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        date.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(weatherImageView.snp.right).offset(8)
        }
        
        weatherDescription.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalTo(weatherImageView.snp.right).offset(8)
        }
    }

}



