//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//


import UIKit
import SnapKit

class ForecastTableViewController: UITableViewController{
    
    let cellId = "cellId"
    var data: ForecastWeather? = nil
    var cityName: String = "Minsk"
    
    let service = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        self.tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(named: "Picotee Blue")!.cgColor, UIColor.init(named: "Wisteria")!.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at:0)
        //add progress animation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        service.getForecastWeather(with: cityName, completion: loadDataCompletion)
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.list.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ForecastTableViewCell
        cell.configure(with: (data?.list[indexPath.row])!) //!!!!!!!
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return cell
    }



}

private extension ForecastTableViewController {
    var loadDataCompletion: ((Result<ForecastWeather, Error>) -> ()) {
        return { [weak self] in
            switch $0{
            case .failure(let error):
                self?.showAlert(with: error)
            case .success(let result):
                self?.data = result
                self?.tableView.reloadData()
            }
        }
    }
    
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: "Warning", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
