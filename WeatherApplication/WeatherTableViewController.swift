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
        return isLoaded ? 3 : 0
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
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTemperature", for: indexPath)
            if let tableCell = cell as? DailyTemperatureTableViewCell {
                tableCell.dailyTemperatureDetail = dailyTemperatureDetail
            }
            cell.backgroundColor = UIColor.orange
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else if indexPath.section == 1 {
            return 150
        } else {
            return 250
        }
    }
}

extension WeatherTableViewController: HourlyTemperatureTableViewCellDelegate {
    func didSelectTemperature(at index: IndexPath) {
        currentSelectedTemperature = temperatureDetail[index.row]
        tableView.reloadSections([0], with: .fade)
    }
}
