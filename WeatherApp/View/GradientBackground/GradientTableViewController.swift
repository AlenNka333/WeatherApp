//
//  GradientTableViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/25/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class GradientTableViewController: UITableViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeGradientBackground()
    }
    
    func makeGradientBackground() {
       let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(named: "Picotee Blue")!.cgColor, UIColor.init(named: "Wisteria")!.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = UIScreen.main.bounds
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.layer.addSublayer(gradientLayer)
        self.tableView.backgroundView = backgroundView
    }
}
