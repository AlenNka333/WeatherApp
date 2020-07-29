//
//  WeatherParamView.swift
//  WeatherApp
//
//  Created by Alena Nesterkina on 7/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

@IBDesignable class WeatherParamView: UIView {

    @IBInspectable var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    var contentView: UIView!
    
    private func commonInit() {
        let bundle = Bundle(for: WeatherParamView.self)
        let nib = UINib(nibName: "WeatherParamView", bundle: bundle)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
