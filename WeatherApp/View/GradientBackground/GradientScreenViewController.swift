//
//  GradientScreenViewController.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

protocol Gradientable: UIViewController { }

extension Gradientable {
    private var gradientLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Asset.Color.picoteeBlue.color.cgColor,
                                Asset.Color.wisteria.color.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        return gradientLayer
    }
}

extension Gradientable {
    func makeGradientBackground() {
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension Gradientable where Self: UITableViewController {
    func makeGradientBackground() {
        let grLayer = gradientLayer
        grLayer.frame = UIScreen.main.bounds
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.layer.addSublayer(grLayer)
        self.tableView.backgroundView = backgroundView
    }
}
