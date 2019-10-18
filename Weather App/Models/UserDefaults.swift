//
//  GeoHelper.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    static let shared = UserDefaultsWrapper()
    
    // Mark: getter
    func getZipCode() -> String? {
        return UserDefaults.standard.value(forKey: userZipCodeKey) as? String
    }
    
    //Mark:Setter
    
    func store(zipCode: String) {
        UserDefaults.standard.set(zipCode, forKey: userZipCodeKey)
    }
    
    
    private let userZipCodeKey = "zipCode"
}







