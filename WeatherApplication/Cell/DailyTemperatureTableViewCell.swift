//
//  HourlyTemperatureTableViewCell.swift
//  WeatherApplication
//
//  Created by Harsha on 04/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import Foundation

import UIKit

class DailyTemperatureTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    var dailyTemperatureDetail: [DetailTemperatureHolder] = []
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
}

extension DailyTemperatureTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyTemperatureDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyTemperature", for: indexPath)
        if let dailyTempCell = cell as? DailyTemperatureCollectionViewCell {
            dailyTempCell.backgroundColor = UIColor.cyan
            dailyTempCell.dayLabel.text = dailyTemperatureDetail[indexPath.row].day
            dailyTempCell.maxTempLabel.text = "\(dailyTemperatureDetail[indexPath.row].maxTemp)"
            dailyTempCell.minTempLabel.text = "\(dailyTemperatureDetail[indexPath.row].minTemp)"
        }
        return cell
    }
    
}
