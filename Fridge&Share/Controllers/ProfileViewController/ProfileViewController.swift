//
//  ProfileViewController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.11.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    private enum Constants {
        static let title = "Profile"
        static let profileCornerRadius: CGFloat = 35
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 2.0
    }
    

    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.circle")
        img.tintColor = .darkGray
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = Constants.profileCornerRadius
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Tyler Durden"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let floorLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "floor 23"
        label.layer.borderWidth = Constants.borderWidth
        label.layer.cornerRadius = Constants.cornerRadius
        label.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        
        view.backgroundColor = .FASBackgroundColor
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(floorLabel)
        view.addSubview(changeButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            floorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            floorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            floorLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            changeButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            changeButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
}


class PaddingLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
