//
//  ItemCell.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 13.11.2023.
//

import UIKit

final class ItemCell: UICollectionViewCell, ReusableCollectionCell {
    private enum Constants {
        static let frigeIcon = "refrigerator"
    }
    
    private let fridge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.frigeIcon)
        imageView.tintColor = .black
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "normal", size: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fridge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fridge)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            fridge.topAnchor.constraint(equalTo: contentView.topAnchor),
            fridge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fridge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fridge.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: fridge.bottomAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
