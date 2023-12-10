//
//  ProductCellViewController.swift
//  Fridge&Share
//
//  Created by User on 27.11.2023.
//

import UIKit

final class ProductCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
    }
    
   let productImageView = UIImageView(frame: .zero)
   override init(frame: CGRect){
        super.init(frame: frame)
    
        addSubview(productImageView)
    
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.layer.cornerRadius = Constants.cornerRadius
        productImageView.layer.masksToBounds = true
        productImageView.backgroundColor = .white
    
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
