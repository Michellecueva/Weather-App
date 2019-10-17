//
//  FavoritesViewController.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let cityImages = [CityImage]()
    
    lazy var CityCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 275, height: 300)
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.CityCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        
    
        
        
        cell.backgroundColor = #colorLiteral(red: 0.3850156015, green: 0.8531414642, blue: 0.985880573, alpha: 0.6418999566)
        
        return cell
    }
}


