//
//  WeatherAPIClient.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct WeatherAPIClient {
    
    
    static let manager = WeatherAPIClient()
    

    
    func  getWeatherURL(lat: Double, long: Double) -> URL {
        guard let url = URL(string: "https://api.darksky.net/forecast/\(Secrets.DarkSkyAPIKey)/\(lat),\(long)") else {fatalError("Error: Invalid URL")}
     return url
}
    

    func getWeather(lat: Double, long: Double, completionHandler: @escaping (Result<[Weather], AppError>) -> Void) {
        NetworkHelper.manager.performDataTask(withUrl: getWeatherURL(lat: lat, long: long), andMethod: .get) { result in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let weather = try WeatherWrapper.decodeElementsFromData(from: data)
                    completionHandler(.success(weather))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }

    private init() {}
}
