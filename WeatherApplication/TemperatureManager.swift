//
//  TemperatureManager.swift
//  WeatherApp
//
//  Created by Harsha on 03/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import Foundation
import UIKit

class TemperatureManager {
    
    var currentSelected: HourlyTemperatureDetail?
    
    private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=1273294&APPID=a11d754062e9e272b1878b28781eb2c7")!
    
    func fetchTemperature(completion: @escaping ([HourlyTemperatureDetail]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL) {
            (data, response, error) in
            if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                
                guard let jsonArray = jsonResponse as? [String : Any], let list = jsonArray["list"], let listOfDict = list as? [[String : Any]] else {
                    return
                }
                
                var createHourlyTemperature = [HourlyTemperatureDetail]()
                
                for dict in listOfDict {
                    guard let main = dict["main"] as? [String : Any], let weather = dict["weather"] as? [[String : Any]], let dateText = dict["dt_txt"] as? String else {
                        return
                    }
                    guard let minTemp = main["temp_min"] as? Double, let maxTemp = main["temp_max"] as? Double, let avgTemp = main["temp"] as? Double, let detailWeather = weather[0]["main"] as? String else {
                        return
                    }
                    let date = DateFormatter.dateFormatter.date(from: dateText) ?? Date()
                    let currentData = HourlyTemperatureDetail(date: date, minTemp: minTemp.toCelsius, maxTemp: maxTemp.toCelsius, avgTemp: avgTemp.toCelsius, weather: detailWeather)
                    createHourlyTemperature.append(currentData)
                }
                completion(createHourlyTemperature, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
}

extension Double {
    var toCelsius: Int {
        return Int(self - 273.15)
    }
}
