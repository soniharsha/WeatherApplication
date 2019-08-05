//
//  DailyContentTableViewCell.swift
//  WeatherApplication
//
//  Created by Harsha on 04/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import UIKit

class DetailContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentSelected: HourlyTemperatureDetail? {
        didSet {
            configure(with: currentSelected!)
        }
    }

    private func configure(with detail: HourlyTemperatureDetail) {
        locationLabel.text = "New Delhi, India"
        dayTimeLabel.text = "\(detail.weekday) \(detail.hour ) ・ \(detail.weather)"
        tempLabel.text = "\(detail.maxTemp) ºC"
        currentImageView.image = UIImage(named: detail.weather)
    }

}
