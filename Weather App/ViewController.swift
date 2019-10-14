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
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 325, height: 300)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: 400, height: 400), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = #colorLiteral(red: 0.3850156015, green: 0.8531414642, blue: 0.985880573, alpha: 0.6418999566)
            
        return collectionView
        }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(weatherCollectionView)
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
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        
        let currentWeather = weather[indexPath.row]
        
        if let highTemp = currentWeather.temperatureHigh {
            cell.hiTempLabel.text = highTemp.description
        }
        
        cell.backgroundColor = #colorLiteral(red: 0.5485045887, green: 0.8194161367, blue: 0.8383918695, alpha: 1)
        
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



