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
    
    var weatherText = "Weather Forecast For"
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = weatherText
        label.textAlignment = .center
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date:"
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
    }
    
    private func configureConstraints() {
        detailLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        topLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topLabelStackview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            detailLabelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailLabelStackview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
}
