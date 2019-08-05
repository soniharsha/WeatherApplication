//
//  DAilyTemperatureTableViewCell.swift
//  WeatherApplication
//
//  Created by Harsha on 04/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import UIKit

protocol HourlyTemperatureTableViewCellDelegate: class {
    func didSelectTemperature(at index: IndexPath)
}

class HourlyTemperatureTableViewCell: UITableViewCell {
    
    weak var delegate: HourlyTemperatureTableViewCellDelegate?
    
    var hourlyTempDetail = [HourlyTemperatureDetail]() 
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension HourlyTemperatureTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyTempDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyTemperature", for: indexPath)
        if let dailyTempCell = cell as? HourlyTemperatureCollectionViewCell {
            dailyTempCell.tempLabel.text = "\(hourlyTempDetail[indexPath.row].maxTemp) ºC"
            dailyTempCell.timeLabel.text = "\(hourlyTempDetail[indexPath.row].hour)"
        }
        cell.backgroundColor = UIColor.gray
        
        return cell
    }
}

extension HourlyTemperatureTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTemperature(at: indexPath)
    }
}
