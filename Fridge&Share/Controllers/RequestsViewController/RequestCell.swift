//
//  RequestCell.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 24.12.2023.
//

import UIKit

final class RequestCell: UITableViewCell {
    var name = UILabel()
    var image = UIImageView(frame: .zero)
    var date = UILabel()
    
    let stack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 16
        image.translatesAutoresizingMaskIntoConstraints = false
        
        name.textColor = .black
        name.font = UIFont(name: "normal", size: 17)
        name.numberOfLines = 3
        name.translatesAutoresizingMaskIntoConstraints = false
        
        date.textColor = .lightGray
        date.font = UIFont.boldSystemFont(ofSize: 13)
        date.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.layer.cornerRadius = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(date)
        
        contentView.addSubview(image)
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
