//
//  CityAPIHelper.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/17/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct CityImageAPIClient {
    
    
    static let manager = CityImageAPIClient()
    

    
    private func  getcityURL(city: String) -> URL {
        let cityStr = city.replacingOccurrences(of: " ", with: "+").lowercased()
        
        guard let url = URL(string: "https://pixabay.com/api/?key=\(Secrets.PixabayAPIKey)&q=\(cityStr)&image_type=photo&pretty=true&orientation=horizontal") else {fatalError("Error: Invalid URL")}
     return url
}
    

    func getCity(city: String, completionHandler: @escaping (Result<(String), AppError>) -> Void) {
        NetworkHelper.manager.performDataTask(withUrl: getcityURL(city: city), andMethod: .get) { result in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let cityInfo = try CityImageWrapper.decodeCityFromData(from: data)
                    completionHandler(.success(cityInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    

    private init() {}
}
