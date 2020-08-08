//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainScreenView: class {
    func showAlert(with error: Error)
    func displayCurrentWeather(with data: CurrentWeather)
}

class MainScreenPresenter: NSObject {
   
    private weak var mainScreenView: MainScreenView?
    var service: WeatherService
    
    init (with service: WeatherService) {
        self.service = service
    }
    
    func attachView(view: MainScreenView) {
        self.mainScreenView = view
    }
    
    func updateData(with cityName: String) {
        self.service.getCurrentWeather(with: cityName, completion: loadDataCompletion)
    }
    
    func updateData(with location: CLLocationCoordinate2D) {
        self.service.getCurrentWeather(with: location, completion: loadDataCompletion)
    }
    
    func sendError(with error: Error) {
        self.mainScreenView?.showAlert(with: error)
    }
    
}

private extension MainScreenPresenter {
    var loadDataCompletion: ((Result<CurrentWeather, Error>) -> ()) {
        return { [weak self] in
            switch $0 {
            case .failure(let error):
                self?.mainScreenView?.showAlert(with: error)
            case .success(let result):
                self?.mainScreenView?.displayCurrentWeather(with: result)
            }
        }
    }
    
}
