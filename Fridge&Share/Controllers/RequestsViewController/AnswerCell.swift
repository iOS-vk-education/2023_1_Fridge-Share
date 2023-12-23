//
//  RequestCell.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 24.12.2023.
//

import UIKit

final class AnswerCell: UITableViewCell {
    private enum Constants {
        static let iconCheckmark = "checkmark"
        static let iconXmark = "xmark"
    }
    
    var name = UILabel()
    var image = UIImageView(frame: .zero)
    var date = UILabel()
    
    let stackNameAndDate = UIStackView()
    
    let agreeButton = UIButton()
    let disagreeButton = UIButton()
    
    let buttonStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
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
        
        stackNameAndDate.axis = .vertical
        stackNameAndDate.layer.cornerRadius = 16
        stackNameAndDate.translatesAutoresizingMaskIntoConstraints = false
        
        stackNameAndDate.addArrangedSubview(name)
        stackNameAndDate.addArrangedSubview(date)
        
        agreeButton.backgroundColor = .lightGreen
        agreeButton.tintColor = .backgroundGreen
        agreeButton.layer.cornerRadius = 16
        agreeButton.setImage(UIImage(systemName: Constants.iconCheckmark), for: .normal)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        
        disagreeButton.backgroundColor = .lightRed
        disagreeButton.tintColor = .backgroundRed
        disagreeButton.layer.cornerRadius = 16
        disagreeButton.setImage(UIImage(systemName: Constants.iconXmark), for: .normal)
        disagreeButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.axis = .horizontal
        buttonStack.addArrangedSubview(disagreeButton)
        buttonStack.addArrangedSubview(agreeButton)
        buttonStack.layer.cornerRadius = 16
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(image)
        contentView.addSubview(stackNameAndDate)
        contentView.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            
            stackNameAndDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackNameAndDate.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            
            buttonStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            agreeButton.widthAnchor.constraint(equalToConstant: 150),
            agreeButton.heightAnchor.constraint(equalToConstant: 36),
            disagreeButton.widthAnchor.constraint(equalToConstant: 150),
            disagreeButton.heightAnchor.constraint(equalToConstant: 36),
            buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
