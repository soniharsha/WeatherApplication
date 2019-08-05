//
//  TempDetail.swift
//  WeatherApp
//
//  Created by Harsha on 03/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import Foundation

let daysInWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

struct HourlyTemperatureDetail {
    let date: Date
    let minTemp: Int
    let maxTemp: Int
    let avgTemp: Int
    let weather: String
    
    static let myCalendar = Calendar(identifier: .gregorian)
    
    var weekday: String {
        return daysInWeek[HourlyTemperatureDetail.myCalendar.component(.weekday, from: date) - 1]
    }
    
    var hour: String {
        var time = HourlyTemperatureDetail.myCalendar.component(.hour, from: date)
        let clock = (time < 12) ? "AM" : "PM"
        time = (time > 12) ? (24 - time) : time
        return String(time) + clock
    }
}
