//
//  CityImage.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/17/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct CityImageWrapper: Codable {
    let hits: [ImageInfo]
    
    static func decodeCityFromData(from jsonData: Data) throws -> String {
        let response = try JSONDecoder().decode(CityImageWrapper.self, from: jsonData)
        return response.hits[Int.random(in: 0 ..< response.hits.count)].largeImageURL
    }
}


struct ImageInfo: Codable {
    let largeImageURL: String
}
