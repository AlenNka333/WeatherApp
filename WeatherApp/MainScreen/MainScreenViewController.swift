//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenViewController: GradientScreenViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lastUpdateTimeLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var sunriseView: WeatherParamView!
    @IBOutlet weak var sunsetView: WeatherParamView!
    @IBOutlet weak var windView: WeatherParamView!
    @IBOutlet weak var humidityView: WeatherParamView!
    @IBOutlet weak var pressureView: WeatherParamView!
    

    @IBAction func goToForecastAction(_ sender: Any) {
        
    }
}

