//
//  ItemCell.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 13.11.2023.
//

import UIKit

final class ItemCell: UICollectionViewCell {
    private let fridge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "refrigerator")
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fridge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fridge)
        
        NSLayoutConstraint.activate([
            fridge.topAnchor.constraint(equalTo: contentView.topAnchor),
            fridge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fridge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fridge.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
