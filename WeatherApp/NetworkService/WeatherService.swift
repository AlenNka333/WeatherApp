//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/22/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherService {
    
    private let manager = ApiDataManager()
    private let helper = LocationHelper()

    func getCurrentWeather(with location: CLLocationCoordinate2D, completion: @escaping ((Result<CurrentWeather, Error>) -> ())) {
            self.manager.getCurrentWeather(with: location) {
                    switch $0 {
                    case .failure(let error):
                        completion(.failure(error))
                        return
                    case .success(let weather):
                        completion (.success(weather))
                    }
            }
    }
    
    func getCurrentWeather(with city: String, completion: @escaping ((Result<CurrentWeather, Error>) -> ())) {
        getLocation(with: city) { [weak self] in
            switch $0 {
            case .failure(let error):
                completion(.failure(error))
                return
            case .success(let location):
                self?.manager.getCurrentWeather(with: location) {
                    switch $0 {
                    case .failure(let error):
                        completion(.failure(error))
                        return
                    case .success(let weather):
                        completion (.success(weather))
                    }
                }
            }
        }
        
    }
    
    func getForecastWeather(with city: String, completion: @escaping ((Result<ForecastWeather, Error>) -> ())) {
        getLocation(with: city) { [weak self] in
            switch $0 {
            case .failure(let error):
                completion(.failure(error))
                return
            case .success(let location):
                self?.manager.getForecastWeather(with: location) {
                    switch $0 {
                    case .failure(let error):
                        completion(.failure(error))
                        return
                    case .success(let weather):
                        completion (.success(weather))
                    }
                }
            }
        }
        
    }
    
}

private extension WeatherService {
       
    func getLocation(with city: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        helper.getCoordinates(with: city) {
            switch $0 {
            case .failure(let error):
                completion(.failure(error))
                return
            case .success(let location):
                completion(.success(location))
                return
            }
        }
    }
       
   }
