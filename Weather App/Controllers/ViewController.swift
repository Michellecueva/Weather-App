//
//  ViewController.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weather = [Weather]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    var currentTimeZone: String!
    
    var city = String() {
        didSet {
            weatherLabel.text = "Weather Forecast for \(self.city)"
        }
    }
    
    var zipcode = String() {
        didSet {
            setLatAndLongAndCity(zipcode: zipcode)
            userInput.text = zipcode
            UserDefaultsWrapper.shared.store(zipCode: zipcode)
        }
        
    }
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 275, height: 300)
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        
        return collectionView
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
//        label.text = weatherLabelText
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var userInput: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightText
        textField.borderStyle = .bezel
        textField.placeholder = "Zip Code"
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var zipCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a Zip Code"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadDefaultSettings()
        addSubViews()
        configureConstraints()
        
    }
    
    private func loadDefaultSettings() {
        self.view.backgroundColor = #colorLiteral(red: 0.6022105217, green: 0.9038603902, blue: 0.9913617969, alpha: 1)
        self.navigationItem.title = "Search"
        userInput.delegate = self
        
        if let userInput = UserDefaultsWrapper.shared.getZipCode() {
                   zipcode = userInput
               } else {
                   zipcode = "11421"
        }
    }
    
    private func loadData(lat: Double, long: Double) {
        
        WeatherAPIClient.manager.getWeather(lat: lat, long: long) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherFromJSON):
                    self.weather = weatherFromJSON.0
                    self.currentTimeZone = weatherFromJSON.1
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setLatAndLongAndCity(zipcode: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(zipcode) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            let city = placemark?.locality
            
            if let lat = lat, let lon = lon {
                self.loadData(lat: lat, long: lon)
            }
            
            if let city = city {
                self.city = city
            }
            
        }
    }
    
    private func addSubViews() {
        
        self.view.addSubview(weatherCollectionView)
        self.view.addSubview(weatherLabel)
        self.view.addSubview(userInput)
        self.view.addSubview(zipCodeLabel)
    }
    
    private func configureConstraints() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        userInput.translatesAutoresizingMaskIntoConstraints = false
        zipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            
            weatherCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherCollectionView.topAnchor.constraint(equalTo: self.weatherLabel.topAnchor),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 400),
            weatherCollectionView.widthAnchor.constraint(equalToConstant: 400),
            
            userInput.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userInput.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: -20),
            userInput.heightAnchor.constraint(equalToConstant: 40),
            userInput.widthAnchor.constraint(equalToConstant: 100),
            
            zipCodeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            zipCodeLabel.topAnchor.constraint(equalTo: userInput.bottomAnchor, constant: 30),
        ])
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        
        let currentWeather = weather[indexPath.row]
        
        cell.hiTempLabel.text = "High: \(currentWeather.highTempinInt)°F"
        cell.lowTempLabel.text = "Low: \(currentWeather.lowTempinInt)°F"
        cell.dateLabel.text = currentWeather.timeInStringFormat
        cell.weatherImage.image = UIImage(named: currentWeather.icon)
        
        
        
        cell.backgroundColor = #colorLiteral(red: 0.3850156015, green: 0.8531414642, blue: 0.985880573, alpha: 0.6418999566)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentWeather = weather[indexPath.row]
        let detailVC  = DetailViewController()
        detailVC.weather = currentWeather
        detailVC.currentTimeZone = currentTimeZone
        detailVC.city = city
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userInput = textField.text {
            zipcode = userInput
        }
        return true
    }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            if range.location == 0 && (string == " ") { return false }
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
    }
}



