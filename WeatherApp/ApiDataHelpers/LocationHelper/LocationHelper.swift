//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import CoreLocation

class LocationHelper {
    
    func getCoordinates (with city: String, completion: @escaping (_ location: Result<CLLocationCoordinate2D, LocationHelperErrors>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(.failure(.invalidAdress))
                return
            }
            completion(.success(location))
        }
        
    }
}
