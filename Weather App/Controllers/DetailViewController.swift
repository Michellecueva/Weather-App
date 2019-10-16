//
//  DetailViewController.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var weather: Weather!
    
    lazy var hiTempLabel: UILabel = {
        let label = UILabel()
        label.text = "High: \(weather.temperatureHigh)°F"
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Low: \(weather.temperatureLow)°F"
        return label
    }()
    
    lazy var sunriseTimeLabel: UILabel = {
           let label = UILabel()
           label.text = "Sunrise:"
           return label
    }()
    
    lazy var sunsetTimeLabel: UILabel = {
              let label = UILabel()
              label.text = "Sunset"
              return label
       }()
    
    lazy var windSpeedLabel: UILabel = {
           let label = UILabel()
        label.text = "Wind Speed: \((weather.windSpeed)) MPH"
           return label
    }()
    
    lazy var precipitationLabel: UILabel = {
           let label = UILabel()
        label.text = "Precipitation: \(weather.percentageOfprecipitation)%"
           return label
    }()
    
    lazy var labelStackview: UIStackView = {
           let stackView = UIStackView()
           stackView.axis = .vertical
           stackView.alignment = .fill
           stackView.distribution = .fillEqually
           stackView.addArrangedSubview(hiTempLabel)
        stackView.addArrangedSubview(lowTempLabel)
        stackView.addArrangedSubview(sunriseTimeLabel)
        stackView.addArrangedSubview(sunsetTimeLabel)
        stackView.addArrangedSubview(windSpeedLabel)
        stackView.addArrangedSubview(precipitationLabel)
           return stackView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSubViews()
        configureConstraints()
    }
    
    
       private func setSubViews() {
        self.view.addSubview(labelStackview)
       }
    
    private func configureConstraints() {
        labelStackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            labelStackview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
}
