//
//  GeoHelper.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import CoreLocation

struct GeoHelper {
    
     
    
    static func getCoordinates(zipCode: String) -> (Lat: CLLocationDegrees?, Long: CLLocationDegrees?) {
       let geoCoder = CLGeocoder()
        
        var lat: CLLocationDegrees?
        var lon: CLLocationDegrees?
        geoCoder.geocodeAddressString(zipCode) {
            placemarks, error in
            let placemark = placemarks?.first
            lat = placemark?.location?.coordinate.latitude
            lon = placemark?.location?.coordinate.longitude
            
        }
        
        return (lat,lon)
    }
}







