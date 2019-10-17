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
    
    var currentTimeZone: String!
    
    var weatherText = "Weather Forecast For"
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = weatherText
        label.textAlignment = .center
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = weather.timeInDateFormat
        label.textAlignment = .center
        return label
    }()
    
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
        label.text = "Sunrise: \(weather.setTime(time: weather.sunriseTime, timeZone: currentTimeZone))"
        return label
    }()
    
    lazy var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunset: \(weather.setTime(time: weather.sunsetTime, timeZone: currentTimeZone))"
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
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
//        image.image =
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .lightGray
        return image
    }()
    
    lazy var detailLabelStackview: UIStackView = {
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
    
    lazy var topLabelStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.addArrangedSubview(weatherLabel)
        stackView.addArrangedSubview(dateLabel)
        return stackView
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let saveItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: nil, action: #selector(pressSaveButton))
        return saveItem
    }()
    
    @objc func pressSaveButton() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSubViews()
        configureConstraints()
        navigationItem.title = "Forecast"
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    private func setSubViews() {
        self.view.addSubview(detailLabelStackview)
        self.view.addSubview(topLabelStackview)
        self.view.addSubview(weatherImage)
    }
    
    private func configureConstraints() {
        detailLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        topLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topLabelStackview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
        
            weatherImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherImage.topAnchor.constraint(equalTo: topLabelStackview.bottomAnchor, constant: 30),
            weatherImage.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 300),
            
            detailLabelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailLabelStackview.topAnchor.constraint(equalTo: weatherImage.bottomAnchor,constant: 30)
        ])
        
    }
}
