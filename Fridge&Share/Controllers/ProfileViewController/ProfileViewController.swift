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
        static let title = "Профиль"
        static let profileCornerRadius: CGFloat = 35
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 2.0
        static let tableViewCornerRadius: CGFloat = 16
    }
    
    enum ProfileCellType {
        case fridge
        case products
        case requests

        var title: String {
            switch self {
            case .products: return "Мои продукты"
            case .fridge: return "Мой холодильник"
            case .requests: return "Уведомления"
            }
        }

    }
    
    private let icons = ["takeoutbag.and.cup.and.straw", "refrigerator", "bell"]
    private let names = ["Мои продукты", "Мой холодильник", "Уведомления"]

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
    
    let profileAddPhotoButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "photo.circle"), for: .normal)
        
        button.imageView?.tintColor = .darkGray
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.cornerRadius = Constants.profileCornerRadius
        button.imageView?.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hey), for: .touchUpInside)
        return button
    }()
    
    @objc func hey() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Tyler Durden"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let floorLabel: UILabel = {
        let label = UILabel()
        label.text = "floor 23"
        label.textColor = .black
        label.font = UIFont(name: "normal", size: 17)
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
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        
        view.backgroundColor = .FASBackgroundColor
        
        view.addSubview(profileAddPhotoButton)
        view.addSubview(nameLabel)
        view.addSubview(floorLabel)
        view.addSubview(tableView)
        
        setTableView()
        
        NSLayoutConstraint.activate([
            profileAddPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileAddPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileAddPhotoButton.widthAnchor.constraint(equalToConstant: 200),
            profileAddPhotoButton.heightAnchor.constraint(equalToConstant: 200),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileAddPhotoButton.bottomAnchor, constant: 20),
            floorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            floorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: floorLabel.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setTableView() {
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .FASBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
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


extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileAddPhotoButton.setBackgroundImage(image, for: .normal)
            profileAddPhotoButton.imageView?.layer.cornerRadius = Constants.profileCornerRadius
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let fullString = NSMutableAttributedString()
        let textString = NSAttributedString(string: names[indexPath.section])
        let attachment = NSTextAttachment()
        if let image = UIImage(systemName: icons[indexPath.section],
                               withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold))?
            .withTintColor(.red, renderingMode: .alwaysOriginal) {
            attachment.image = image
            fullString.append(NSAttributedString(attachment: attachment))
        }
        
        fullString.append(textString)
        cell.textLabel?.attributedText = fullString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            let destination = ListOfMyProductsController()
            navigationController?.pushViewController(destination, animated: true)
            destination.title = ProfileCellType.products.title
        case 1:
            let destination = FridgeViewController()
            navigationController?.pushViewController(destination, animated: true)
            destination.title = ProfileCellType.fridge.title
        case 2:
            let destination = RequestsViewController()
            navigationController?.pushViewController(destination, animated: true)
            destination.title = ProfileCellType.requests.title
        default: print(indexPath.section)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
