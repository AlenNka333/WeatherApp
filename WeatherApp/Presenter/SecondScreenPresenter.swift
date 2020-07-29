//
//  SecondScreenPresenter.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/29/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol ForecastWeatherDelegate {
    func displayForecastWeather(with weather: ForecastWeather)
    func showAlert(with error: Error)
}

class SecondScreenViewPresenter {
    
    private var delegate: ForecastWeatherDelegate?
    let service: WeatherService
    
    init(with weatherService: WeatherService) {
        self.service = weatherService
    }
    
    func setDelegate(forecastWeatherDelegate: ForecastWeatherDelegate?) {
        self.delegate = forecastWeatherDelegate
    }
    
    func getForecastWeather(in city: String){
        self.service.getForecastWeather(with: city, completion: loadDataCompletion)
    }
    
}

private extension SecondScreenViewPresenter {
   
    var loadDataCompletion: ((Result<ForecastWeather, Error>) -> ()) {
        return { [weak self] in
            switch $0{
            case .failure(let error):
                self?.delegate?.showAlert(with: error)
            case .success(let result):
                self?.delegate?.displayForecastWeather(with: result)
            }
        }
    }
    
}
