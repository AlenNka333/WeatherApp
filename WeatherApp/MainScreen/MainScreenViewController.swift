//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenViewController: GradientScreenViewController, UITextFieldDelegate {
    
    var data: CurrentWeather? = nil
    let service = WeatherService()
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
        cityNameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideElements(with: true)
        
        //get weather according to current gps location
        // need to get permission for gps
    }
    
    
//MARK: - Move to SecondScreen
    
    @IBAction func goToForecastAction(_ sender: UIButton) {
        let secondScreen = ForecastTableViewController()
        let navigationController = UINavigationController(rootViewController: secondScreen)
        secondScreen.cityName = self.cityName
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField.isEmpty {
            showAlert(with: GeneralErrors.emptyTextField)
        } else {
            cityName = textField.text ?? ""
            service.getCurrentWeather(with: cityName, completion: loadDataCompletion)
        }
        return true
    }
    
//MARK: - UpdateUI( after url request )
    
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
}

//MARK: - MainScreenExtension

private extension MainScreenViewController {
    
    var loadDataCompletion: ((Result<CurrentWeather, Error>) -> ()) {
        return { [weak self] in
            switch $0{
            case .failure(let error):
                self?.showAlert(with: error)
            case .success(let result):
                self?.data = result
                self?.updateUI()
            }
        }
    }
    
    func hideElements (with state: Bool) {
        self.weatherDescriptionLabel.isHidden = state
        self.temperatureLabel.isHidden = state
        self.stackView.isHidden = state
        self.secondScreenButton.isHidden = state
    }
    
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: "Warning", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}


