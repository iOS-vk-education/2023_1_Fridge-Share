//
//  RequestCell.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 24.12.2023.
//

import UIKit

protocol AnswerViewControllerDelegate: AnyObject {
    func reloadDataForTable(documentId: String, newAnswer: answerCase)
}

final class AnswerCell: UITableViewCell {
    private enum Constants {
        static let iconCheckmark = "checkmark"
        static let iconXmark = "xmark"
        static let imageCornerRadius: CGFloat = 16
        static let nameLabelNumberOfLines = 3
    }
    
    private var documentId: String = ""
    weak var delegate: AnswerViewControllerDelegate?
    
    func configureCell(id: String, delegate: AnswerViewControllerDelegate) {
        documentId = id
        self.delegate = delegate
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
        
        setupUI()
        
        contentView.addSubview(image)
        contentView.addSubview(stackNameAndDate)
        contentView.addSubview(buttonStack)
        
        setupConstraints()
    }
    
    private func setupUI() {
        image.layer.cornerRadius = Constants.imageCornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        
        name.textColor = .black
        name.font = UIFont(name: "normal", size: 17)
        name.numberOfLines = Constants.nameLabelNumberOfLines
        name.translatesAutoresizingMaskIntoConstraints = false
        
        date.textColor = .black
        date.font = UIFont.boldSystemFont(ofSize: 13)
        date.translatesAutoresizingMaskIntoConstraints = false
        
        stackNameAndDate.axis = .vertical
        stackNameAndDate.layer.cornerRadius = Constants.imageCornerRadius
        stackNameAndDate.translatesAutoresizingMaskIntoConstraints = false
        
        stackNameAndDate.addArrangedSubview(name)
        stackNameAndDate.addArrangedSubview(date)
        
        agreeButton.backgroundColor = .lightGreen
        agreeButton.tintColor = .backgroundGreen
        agreeButton.layer.cornerRadius = Constants.imageCornerRadius
        agreeButton.setImage(UIImage(systemName: Constants.iconCheckmark), for: .normal)
        agreeButton.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        
        disagreeButton.backgroundColor = .lightRed
        disagreeButton.tintColor = .backgroundRed
        disagreeButton.layer.cornerRadius = Constants.imageCornerRadius
        disagreeButton.setImage(UIImage(systemName: Constants.iconXmark), for: .normal)
        disagreeButton.addTarget(self, action: #selector(disagreeButtonTapped), for: .touchUpInside)
        disagreeButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.spacing = 20
        buttonStack.distribution = .fillEqually
        buttonStack.axis = .horizontal
        buttonStack.addArrangedSubview(disagreeButton)
        buttonStack.addArrangedSubview(agreeButton)
        buttonStack.layer.cornerRadius = Constants.imageCornerRadius
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            
            stackNameAndDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackNameAndDate.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            
            buttonStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            agreeButton.widthAnchor.constraint(equalToConstant: 120),
            agreeButton.heightAnchor.constraint(equalToConstant: 36),
            disagreeButton.widthAnchor.constraint(equalToConstant: 120),
            disagreeButton.heightAnchor.constraint(equalToConstant: 36),
            buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)

        ])
    }
    
    @objc func agreeButtonTapped() {
        self.delegate?.reloadDataForTable(documentId: documentId, newAnswer: .agree)
    }
    
    @objc func disagreeButtonTapped() {
        self.delegate?.reloadDataForTable(documentId: documentId, newAnswer: .disagree)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
