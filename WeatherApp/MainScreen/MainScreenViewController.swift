//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lastUpdateTimeLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var sunriseView: WeatherParamView!
    @IBOutlet weak var sunsetView: WeatherParamView!
    @IBOutlet weak var windView: WeatherParamView!
    @IBOutlet weak var humidityView: WeatherParamView!
    @IBOutlet weak var pressureView: WeatherParamView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeGradientBackground()
    
    }

    @IBAction func goToForecastAction(_ sender: Any) {
        
    }
}

extension MainScreenViewController {
    
    func makeGradientBackground() {
        let colorTop =  UIColor(red: 49.0/255.0, green: 27.0/255.0, blue: 160.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 179.0/255.0, green: 157.0/255.0, blue: 219.0/255.0, alpha: 1.0).cgColor

           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [colorTop, colorBottom]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = self.view.bounds

           self.view.layer.insertSublayer(gradientLayer, at:0)
           
       }
    
}
