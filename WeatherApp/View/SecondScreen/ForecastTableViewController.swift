//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//


import UIKit
import SnapKit

class ForecastTableViewController: UITableViewController {
    
    private let forecastWeatherPresenter = SecondScreenViewPresenter(with: WeatherService())
    let cellId = "cellId"
    var data = [Forecast]()
    var cityName: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = 100
        self.forecastWeatherPresenter.attachView(view: self)
        self.forecastWeatherPresenter.getForecastWeather(in: cityName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeGradientBackground()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ForecastTableViewCell
        cell.configure(with: (data[indexPath.row]))
        cell.backgroundColor = UIColor.clear
        return cell
    }

}

extension ForecastTableViewController: ForecastWeatherView {
    //MARK: - Protocol's methods
    
    func displayForecastWeather(with weather: ForecastWeather) {
        self.data = weather.list
        self.tableView.reloadData()
    }
    
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: "Warning", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension ForecastTableViewController: Gradientable { }
