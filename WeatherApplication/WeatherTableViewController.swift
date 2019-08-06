//
//  WeatherTableViewController.swift
//  WeatherApplication
//
//  Created by Harsha on 04/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    private var manager = TemperatureManager()
    
    var temperatureDetail: [HourlyTemperatureDetail] = []
    var dailyTemperatureDetail : [DetailTemperatureHolder] = []
    var currentSelectedTemperature: HourlyTemperatureDetail?
    
    var isLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetchTemperature() { temperature, error in
            if let temperature = temperature {
                DispatchQueue.main.async {
                    self.isLoaded = true
                    self.temperatureDetail = temperature
                    self.generateDailyDetail()
                    self.currentSelectedTemperature = self.temperatureDetail[0]
                    self.tableView.reloadData()
                }
            } else {
                print("Error: \(error!)")
            }
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        let imageView = UIImageView(frame: tableView.bounds)
        imageView.image = UIImage(named: "b")
        tableView.backgroundView = imageView
    }
    

    func generateDailyDetail() {
    
        var dictionaryDay: [String : DetailTemperatureHolder] = [:]
        
        for data in temperatureDetail{
            guard let day = dictionaryDay[data.weekday] else {
                let toInsert = DetailTemperatureHolder(minTemp: data.minTemp, maxTemp: data.maxTemp, day: data.weekday, weather: data.weather)
                dictionaryDay[data.weekday] = toInsert
                continue
            }
            
            dictionaryDay[data.weekday] = DetailTemperatureHolder(minTemp: min(day.minTemp, data.minTemp), maxTemp: max(day.maxTemp, data.maxTemp), day: data.weekday, weather: data.weather)
        }
        
        for (_,value) in dictionaryDay {
            self.dailyTemperatureDetail.append(value)
        }
        
    }
    // MARK:- Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return isLoaded ? 4 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailContent", for: indexPath)
            if let tableCell = cell as? DetailContentTableViewCell {
                tableCell.currentSelected = currentSelectedTemperature
                tableCell.backgroundColor = UIColor.clear
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTemperature", for: indexPath)
            if let tableCell = cell as? HourlyTemperatureTableViewCell {
                tableCell.hourlyTempDetail = temperatureDetail
                tableCell.delegate = self
                tableCell.backgroundColor = UIColor.clear
            }
            
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTemperature", for: indexPath)
            if let tableCell = cell as? DailyTemperatureTableViewCell {
                tableCell.dailyTemperatureDetail = dailyTemperatureDetail
            }
            cell.backgroundColor = UIColor.clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowMore", for: indexPath)
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.height
        if indexPath.section == 0 {
            return height * 0.3
        } else if indexPath.section == 1 {
            return height * 0.1
        } else if indexPath.section == 2 {
            return height * 0.1
        } else {
            return height * 0.4
        }
    }
}

extension WeatherTableViewController: HourlyTemperatureTableViewCellDelegate {
    func didSelectTemperature(at index: IndexPath) {
        currentSelectedTemperature = temperatureDetail[index.row]
        tableView.reloadSections([0], with: .fade)
    }
}
