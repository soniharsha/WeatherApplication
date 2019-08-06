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
            collectionView.backgroundColor = UIColor.clear
        }
    }
    
}

extension DailyTemperatureTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyTemperatureDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyTemperature", for: indexPath)
        if let dailyTempCell = cell as? DailyTemperatureCollectionViewCell {
            dailyTempCell.backgroundColor = UIColor.cyan
            dailyTempCell.dayLabel.text = dailyTemperatureDetail[indexPath.row].day
            dailyTempCell.maxTempLabel.text = "\(dailyTemperatureDetail[indexPath.row].maxTemp) ºC"
            dailyTempCell.minTempLabel.text = "\(dailyTemperatureDetail[indexPath.row].minTemp) ºC"
            dailyTempCell.weatherImage.image = UIImage(named: "\(dailyTemperatureDetail[indexPath.row].weather)")
        }
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
}
