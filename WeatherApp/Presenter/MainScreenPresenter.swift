//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainScreenViewDelegate: class {
    
    func showAlert(with error: Error)
    func displayCurrentWeather(with data: CurrentWeather)
}

class MainScreenPresenter: NSObject, CLLocationManagerDelegate {
   
    private var mainScreenViewDelegate: MainScreenViewDelegate?
    let locationManager = CLLocationManager()
    var service = WeatherService()
    
    init (weatherService: WeatherService) {
        self.service = weatherService
    }
    
    
    func setViewDelegate(delegate: MainScreenViewDelegate?) {
        self.mainScreenViewDelegate = delegate
    }
    
    func checkCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func updateData(with cityName: String) {
        self.service.getCurrentWeather(with: cityName, completion: loadDataCompletion)
    }
    
    //MARK: - LocationManager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.service.getCurrentWeather(with: location.coordinate, completion: loadDataCompletion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.mainScreenViewDelegate?.showAlert(with: error)
    }
    
}

private extension MainScreenPresenter {
    
    var loadDataCompletion: ((Result<CurrentWeather, Error>) -> ()) {
        return { [weak self] in
            switch $0 {
            case .failure(let error):
                self?.mainScreenViewDelegate?.showAlert(with: error)
            case .success(let result):
                self?.mainScreenViewDelegate?.displayCurrentWeather(with: result)
            }
        }
    }
    
}
