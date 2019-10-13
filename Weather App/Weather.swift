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
    
    
    static func decodeElementsFromData(from jsonData: Data) throws -> [Weather] {
        let response = try JSONDecoder().decode(WeatherWrapper.self, from: jsonData)
        return response.daily.data
    }
}

struct Daily: Codable {
    let data: [Weather]
}

struct Weather: Codable {
    let time: Int
    let temperatureHigh: Double
    let temperatureLow: Double
    let sunriseTime: Int
    let sunsetTime: Int
    let windSpeed: Double
    let precipProbability: Double
}
