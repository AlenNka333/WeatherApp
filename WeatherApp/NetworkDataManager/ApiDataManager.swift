//
//  ApiDataManager.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import CoreLocation

class ApiDataManager {
    
    enum QueryParams {
        static let lat = "lat"
        static let lon = "lon"
        static let units = "units"
        static let api = "appid"
    }
    
    private let apiKey = "bf5296e547ae9dbee06ec80cda8f6ded"
    private let units = "metric"
    
    private let currentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let forecastWeatherUrl = "https://api.openweathermap.org/data/2.5/forecast"
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func getCurrentWeather (with location: CLLocationCoordinate2D, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
       getNetworkAnswer(with: location, url: currentWeatherUrl) { (result: Result<CurrentWeather, Error>) in
           switch result {
           case .failure:
               completion(.failure(ApiDataManagerErrors.decodeError))
               return
           case .success(let weather):
               completion(.success(weather))
               return
           }
       }
    }
    
    func getForecastWeather(with location: CLLocationCoordinate2D, completion: @escaping(Result<ForecastWeather, Error>) -> ()){
        getNetworkAnswer(with: location, url: forecastWeatherUrl) { (result: Result<ForecastWeather, Error>) in
            switch result {
            case .failure:
                completion(.failure(ApiDataManagerErrors.decodeError))
                return
            case .success(let weather):
                completion(.success(weather))
                return
            }
        }
    }
}

private extension ApiDataManager {
    func getNetworkAnswer<T: Codable>(with location: CLLocationCoordinate2D, url: String, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard var urlComponents = URLComponents(string: url) else {
            completion(.failure(ApiDataManagerErrors.invalidURL))
            return
        }
        let queryItems = [URLQueryItem(name: QueryParams.lat, value: String( location.latitude)),
                          URLQueryItem(name: QueryParams.lon, value: String(location.longitude)),
                          URLQueryItem(name: QueryParams.units, value: units),
                          URLQueryItem(name: QueryParams.api, value: apiKey)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(ApiDataManagerErrors.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(ApiDataManagerErrors.invalidResponse))
                    return
                }
                
                switch response.statusCode {
                case 200..<300:
                    break
                default:
                    completion(.failure(ApiDataManagerErrors.badResponse(statusCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(ApiDataManagerErrors.invalidData))
                    return
                }
                
                guard let result = try? self.decoder.decode(T.self, from: data) else {
                    completion(.failure(ApiDataManagerErrors.invalidData))
                    return
                }
                completion(.success(result))
        
            }
        }.resume()
    }
}
