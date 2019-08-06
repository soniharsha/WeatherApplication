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
    var previouslySelectedCellIndexPath: IndexPath?
    
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

extension HourlyTemperatureTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyTempDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyTemperature", for: indexPath)
        if let dailyTempCell = cell as? HourlyTemperatureCollectionViewCell {
            dailyTempCell.tempLabel.text = "\(hourlyTempDetail[indexPath.row].maxTemp) º"
            dailyTempCell.timeLabel.text = "\(hourlyTempDetail[indexPath.row].hour)"
        }
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        if indexPath == previouslySelectedCellIndexPath || previouslySelectedCellIndexPath == nil {
            cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            previouslySelectedCellIndexPath = indexPath
        }
        return cell
    }
}

extension HourlyTemperatureTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previouslySelected = previouslySelectedCellIndexPath, let cell = collectionView.cellForItem(at: previouslySelected) as? HourlyTemperatureCollectionViewCell{
            cell.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? HourlyTemperatureCollectionViewCell {
            cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            previouslySelectedCellIndexPath = indexPath
        }
        delegate?.didSelectTemperature(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80 , height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
