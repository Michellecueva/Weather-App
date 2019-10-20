//
//  Weather_AppTests.swift
//  Weather AppTests
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import XCTest
@testable import Weather_App

class Weather_AppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func WeatherModel() -> Data? {
            let bundle = Bundle(for: type(of: self))
            guard let pathToData = bundle.path(forResource: "WeatherSample", ofType: ".json")  else {
                XCTFail("couldn't find Json")
                return nil
            }
            let url = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch let error {
                fatalError("couldn't find data \(error)")
            }
        }

    func testWeatherModel () {
            let data = WeatherModel() ?? Data()
            
            do {
                let weatherData = try WeatherWrapper.decodeWeatherFromData(from: data)
                
                 XCTAssertTrue(weatherData.0.count > 0, "weather was not loaded")
            } catch let error {
                XCTFail(error.localizedDescription)
            }
    }
    
    private func CityModel() -> Data? {
            let bundle = Bundle(for: type(of: self))
            guard let pathToData = bundle.path(forResource: "CitySample", ofType: ".json")  else {
                XCTFail("couldn't find Json")
                return nil
            }
            let url = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch let error {
                fatalError("couldn't find data \(error)")
            }
        }

    func testCityModel () {
            let data = CityModel() ?? Data()
            
            do {
                let cityData = try CityImageWrapper.decodeCityFromData(from: data)
                
                 XCTAssertTrue(cityData != nil, "cityData was not loaded")
            } catch let error {
                XCTFail(error.localizedDescription)
            }
    }

}
