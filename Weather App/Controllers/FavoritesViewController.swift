//
//  FavoritesViewController.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var cityImages = [CityImage]() {
        didSet {
            
            cityCollectionView.reloadData()
        }
    }
    
    lazy var noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "No Saved Favorites"
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var cityCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 410, height: 350)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cityCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = #colorLiteral(red: 0.6022105217, green: 0.9038603902, blue: 0.9913617969, alpha: 1)
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(cityCollectionView)
        self.view.addSubview(noFavoritesLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
       configureConstraints()
    }
    
    private func loadData() {
           do {
               cityImages = try PhotoPersistenceHelper.manager.getPhoto()
           } catch {
               print(error)
           }
    }
    
    private func configureConstraints() {
        noFavoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        noFavoritesLabel.isHidden = cityImages.count != 0
        
        NSLayoutConstraint.activate([
            noFavoritesLabel.centerXAnchor.constraint(equalTo: self.cityCollectionView.centerXAnchor),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: self.cityCollectionView.centerYAnchor)
        ])
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cityImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.cityCollectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as? CityCollectionViewCell else {
            print("didnt find cell")
            return UICollectionViewCell()}
        
        let currentImage = cityImages[indexPath.row]
        
        cell.cityImage.image = UIImage(data: currentImage.image)        
        return cell
    }
}


