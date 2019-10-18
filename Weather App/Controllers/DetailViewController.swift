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
    
    var imageUrlString: String!
    
    var city = String()
    
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast For \(city)"
        label.textAlignment = .center
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = weather.timeInStringFormat
        label.textAlignment = .center
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = weather.summary
        label.textAlignment = .center
        return label
    }()
    
    lazy var hiTempLabel: UILabel = {
        let label = UILabel()
        label.text = "High: \(weather.highTempinInt)°F"
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Low: \(weather.lowTempinInt)°F"
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
        label.text = "Wind Speed: \((weather.windSpeedInInt)) MPH"
        return label
    }()
    
    lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.text = "Precipitation: \(weather.percentageOfprecipitation)%"
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: weather.icon)
        return image
    }()
    
    lazy var detailLabelStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
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
        let saveItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(pressSaveButton))
        return saveItem
    }()
    
    @objc func pressSaveButton() {
        
        guard let image = weatherImage.image else {return}
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        let photo = CityImage(image: data)
        
        do {
            try PhotoPersistenceHelper.manager.save(newPhoto: photo)
            showSavingsAlert()
        } catch {
            print(error)
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6022105217, green: 0.9038603902, blue: 0.9913617969, alpha: 1)
        setSubViews()
        configureConstraints()
        setNavigationBarItems()
        loadData(city: city)
    }
    
    private func loadData(city: String) {
        CityImageAPIClient.manager.getCity(city: city) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let urlString):
                    self.imageUrlString = urlString
                    self.setImage()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setImage() {
        if imageUrlString != nil {
            ImageHelper.shared.getImage(urlStr: imageUrlString) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageFromOnline):
                        self.weatherImage.image = imageFromOnline
                    case .failure( _):
                        self.weatherImage.image = UIImage(named: self.weather.icon)
                        
                    }
                }
            }
        }
    }
    private func setNavigationBarItems() {
        navigationItem.title = "Forecast"
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    private func setSubViews() {
        self.view.addSubview(detailLabelStackview)
        self.view.addSubview(topLabelStackview)
        self.view.addSubview(weatherImage)
        self.view.addSubview(summaryLabel)
    }
    
    private func configureConstraints() {
        detailLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        topLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topLabelStackview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
        
            weatherImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherImage.topAnchor.constraint(equalTo: topLabelStackview.bottomAnchor, constant: 30),
            weatherImage.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 300),
            
            summaryLabel.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
            summaryLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 30),
            
            detailLabelStackview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailLabelStackview.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor,constant: 30)
        ])
    }
    
    private func showSavingsAlert() {
        let alert = UIAlertController(title: "Saved", message: "Image Saved to Favorites.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
