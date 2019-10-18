//
//  Weather.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct WeatherWrapper: Codable {
    let daily: Daily
    let timezone: String
    
    static func decodeWeatherFromData(from jsonData: Data) throws -> ([Weather], String) {
        let response = try JSONDecoder().decode(WeatherWrapper.self, from: jsonData)
        return (response.daily.data, response.timezone)
    }
}

struct Daily: Codable {
    let data: [Weather]
}

struct Weather: Codable {
    let icon: String
    let summary: String
    let time: Double
    private let temperatureHigh: Double
    private let temperatureLow: Double
    let sunriseTime: Double
    let sunsetTime: Double
    private let windSpeed: Double
    let precipProbability: Double
    
    
    var highTempinInt: Int {
       return Int(temperatureHigh)
    }
    
    var lowTempinInt: Int {
        return Int(temperatureLow)
    }
    
    var windSpeedInInt: Int {
        return Int(windSpeed)
    }
    
    var timeInStringFormat: String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    var percentageOfprecipitation: Int {
       return Int(precipProbability * 100)
    }
    
    func setTime(time: Double, timeZone: String) -> String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        
        let tz = TimeZone.init(identifier: timeZone )
        guard let abbreviation = tz?.abbreviation() else {return ""}
        dateFormatter.timeZone = TimeZone(abbreviation: abbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
