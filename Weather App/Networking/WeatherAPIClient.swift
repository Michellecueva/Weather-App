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
    

    
    func  getWeatherURL(txtfieldText: String) -> URL {
     guard let url = URL(string: "") else {fatalError("Error: Invalid URL")}
     return url
}
    

    func getWeather(userInput: String, completionHandler: @escaping (Result<[Weather], AppError>) -> Void) {
        NetworkHelper.manager.performDataTask(withUrl: getWeatherURL(txtfieldText: userInput), andMethod: .get) { result in
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
