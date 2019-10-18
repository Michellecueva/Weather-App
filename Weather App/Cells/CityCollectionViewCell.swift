//
//  CityCollectionViewCell.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/17/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    var cityImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cityImage.layer.cornerRadius = 30
        cityImage.clipsToBounds = true
        self.contentView.addSubview(cityImage)
        configureConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     private func configureConstraints() {
            cityImage.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                cityImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                cityImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                cityImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
                cityImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
   
            ])
        }

}
