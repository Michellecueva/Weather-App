//
//  WeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var weatherImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var hiTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var lowTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 35
        addViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(weatherImage)
        self.contentView.addSubview(hiTempLabel)
        self.contentView.addSubview(lowTempLabel)
        
    }
    
    private func configureConstraints() {
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        hiTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .top
        
        NSLayoutConstraint.activate([
            
            dateLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            
            weatherImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -15),
            weatherImage.widthAnchor.constraint(equalToConstant: 150),
            weatherImage.heightAnchor.constraint(equalToConstant: 150),
            
            hiTempLabel.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
            hiTempLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 180),
            
            lowTempLabel.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
            lowTempLabel.bottomAnchor.constraint(equalTo: hiTempLabel.bottomAnchor, constant: 30)
        ])
    }
    
}
