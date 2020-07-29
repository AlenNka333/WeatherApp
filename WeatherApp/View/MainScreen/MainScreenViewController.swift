//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit
import CoreLocation

class MainScreenViewController: GradientScreenViewController, MainScreenViewDelegate, UITextFieldDelegate {
    
    private let mainViewPresenter = MainScreenPresenter(weatherService: WeatherService())
    var data: CurrentWeather? = nil
    var cityName = ""

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lastUpdateTimeLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var sunriseView: WeatherParamView!
    @IBOutlet weak var sunsetView: WeatherParamView!
    @IBOutlet weak var windView: WeatherParamView!
    @IBOutlet weak var humidityView: WeatherParamView!
    @IBOutlet weak var pressureView: WeatherParamView!
    @IBOutlet weak var secondScreenButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewPresenter.setViewDelegate(delegate: self)
        hideElements(with: true)
        cityNameTextField.delegate = self
        navigationController?.isNavigationBarHidden = true
        mainViewPresenter.checkCurrentLocation()
    }
    
    //MARK: - Protocol's methods
    
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: "Warning",
                                      message: "\(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayCurrentWeather(with data: CurrentWeather) {
        self.data = data
        if self.cityNameTextField.text?.isEmpty ?? true {
            self.cityNameTextField.text = self.data?.name ?? ""
            self.cityName = self.data?.name ?? ""
        }
        self.updateUI()
    }
    
    
    
//MARK: - Move to SecondScreen
    
    @IBAction func goToForecastAction(_ sender: UIButton) {
        let secondScreen = ForecastTableViewController()
        secondScreen.cityName = self.cityName
        self.navigationController?.pushViewController(secondScreen, animated: true)
    }
    
    @IBAction func updateDataAction(_ sender: UIButton) {
        mainViewPresenter.updateData(with: cityName)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField.isEmpty {
            showAlert(with: GeneralErrors.emptyTextField)
        } else {
            cityName = textField.text ?? ""
            mainViewPresenter.updateData(with: cityName)
        }
        return true
    }
    
}

//MARK: - MainScreenExtension

private extension MainScreenViewController {
    
    func updateUI() {
        let localDate = DateHelper.convertToDate(with: data?.dt ?? 0)
        let sunriseTime = DateHelper.convertToTime(with: Double(data?.sys.sunrise ?? 0))
        let sunsetTime = DateHelper.convertToTime(with: Double(data?.sys.sunset ?? 0))
        self.lastUpdateTimeLabel.text = "Updated at:\n\(localDate)"
        self.weatherDescriptionLabel.text = data?.weather[0].main
        self.temperatureLabel.text = "\(data?.main.temp ?? 0) °C"
        self.sunriseView.valueLabel.text = "\(sunriseTime)"
        self.sunsetView.valueLabel.text = "\(sunsetTime)"
        self.windView.valueLabel.text = "\(data?.wind.speed ?? 0)"
        self.pressureView.valueLabel.text = "\(data?.main.pressure ?? 0)"
        self.humidityView.valueLabel.text = "\(data?.main.humidity ?? 0)"
        hideElements(with: false)
        view.setNeedsDisplay()
    }
    
    func hideElements (with state: Bool) {
        self.weatherDescriptionLabel.isHidden = state
        self.temperatureLabel.isHidden = state
        self.stackView.isHidden = state
        self.secondScreenButton.isHidden = state
    }
    
}


