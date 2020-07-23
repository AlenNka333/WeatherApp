//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//


import UIKit

class ForecastViewController: UITableViewController{
    
    let cellId = "cellId"
    let data = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(named: "Picotee Blue")!.cgColor, UIColor.init(named: "Wisteria")!.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ForecastTableViewCell
        cell.date.text = data[indexPath.row].dtTxt
        cell.weatherDescription.text = data[indexPath.row].weather[0].description
        cell.temperature.text = "\(data[indexPath.row].main.feelsLike) °C"
        
        return cell
    }



}
