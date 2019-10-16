//
//  ViewController.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather = [Weather]() {
           didSet {
               weatherCollectionView.reloadData()
           }
    }
    
    var weatherLabelText = "Weather Forecast"
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 325, height: 300)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = #colorLiteral(red: 0.3850156015, green: 0.8531414642, blue: 0.985880573, alpha: 0.6418999566)
            
        return collectionView
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = weatherLabelText
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Search"
        addSubViews()
        configureConstraints()
        loadData(lat: 40.40652363, long: -75.15703082)
    }
    
    private func loadData(lat: Double, long: Double) {
        WeatherAPIClient.manager.getWeather(lat: lat, long: long) { (result) in
            DispatchQueue.main.async {
               switch result {
                    case .success(let weatherFromJSON):
                        self.weather = weatherFromJSON
                    case .failure(let error):
                        print(error)
                    }
            }
        }
    }
    
    private func addSubViews() {
        self.view.addSubview(weatherLabel)
        self.view.addSubview(weatherCollectionView)
        
    }
    
    private func configureConstraints() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 125),
            weatherCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherCollectionView.topAnchor.constraint(equalTo: self.weatherLabel.bottomAnchor, constant: 30),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 400),
            weatherCollectionView.widthAnchor.constraint(equalToConstant: 400)
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
        
        if let highTemp = currentWeather.temperatureHigh {
            cell.hiTempLabel.text = "High: \(highTemp.description)°F"
        }
        
        if let lowTemp = currentWeather.temperatureLow {
            cell.lowTempLabel.text = "Low: \(lowTemp.description)°F"
        }

        
        cell.backgroundColor = #colorLiteral(red: 0.3850156015, green: 0.8531414642, blue: 0.985880573, alpha: 0.6418999566)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let currentWeather = weather[indexPath.row]
//        let detailVC  = DetailViewController()
//        detailVC.view.backgroundColor = #colorLiteral(red: 0.5485045887, green: 0.8194161367, blue: 0.8383918695, alpha: 1)
//        detailVC.user = currentUser
//        self.present(detailVC, animated: true, completion: nil)
//    }
}



