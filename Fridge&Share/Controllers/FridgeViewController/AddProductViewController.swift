//
//  AddProductViewController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import UIKit

final class AddProducrViewController: UIViewController, UITextFieldDelegate {
    
    private let firstTextField = UITextField()
    private let secondTextField = UITextField()
    private let imageView = UIImageView()
    private let commentField = UITextField()
    private let button = UIButton ()
    
    private enum Constants {
        static let title = "Добавить"
        static let placeholder = "Добавить комментарий"
        static let placeholderName = "Название продукта"
        static let placeholderDate = "дд.мм.гггг"
        static let placeholderComment = "Комментарий"
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2.0
        static let screenHeight = UIScreen.main.bounds.height
        static let imageHeight = screenHeight/3
        static let width: CGFloat = 100
        static let height: CGFloat = 20
        static let heightImage: CGFloat = 400
        static let icon = "photo.stack"
    }
    
    
    func setModel() {
        firstTextField.placeholder = Constants.placeholderName
        secondTextField.placeholder = Constants.placeholderDate
        imageView.image = UIImage(systemName: Constants.icon)
    }
    
    private func setupUI(){
        setModel()
        let tapElsewhereGesture = UITapGestureRecognizer(target: self, action: #selector(tappedNotInKeyboard))
        tapElsewhereGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapElsewhereGesture)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGrey
        view.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.userDidTapTitle(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        firstTextField.font = UIFont.systemFont(ofSize: 26)
        view.addSubview(firstTextField)
        
        secondTextField.layer.borderWidth = Constants.borderWidth
        secondTextField.layer.cornerRadius = Constants.cornerRadius
        secondTextField.font = UIFont.systemFont(ofSize: 22)
        secondTextField.textColor = .backgroundGreen
        secondTextField.layer.borderColor = CGColor(red: 0.49, green: 0.77, blue: 0.42, alpha: 1.0)
        secondTextField.backgroundColor = .lightGreen
        secondTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        secondTextField.layer.masksToBounds = true
        view.addSubview(secondTextField)
        
        commentField.placeholder = Constants.placeholderComment
        commentField.font = UIFont.systemFont(ofSize: 22)
        commentField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        commentField.layer.cornerRadius = Constants.cornerRadius
        commentField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        view.addSubview(commentField)
        
        button.setTitle(Constants.title, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        commentField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.heightImage),
            
            firstTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.height+5),
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.height*2),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.height),
            
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.height*2),
            secondTextField.widthAnchor.constraint(equalToConstant: 155),
            secondTextField.heightAnchor.constraint(equalToConstant: Constants.height*2),
            
            commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 25),
            commentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.height*2),
            commentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.height*2),
            commentField.heightAnchor.constraint(equalToConstant: 65),
            
            button.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: Constants.height*3),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
        view.endEditing(true)
    }
    
    @objc func userDidTapTitle(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func addButtonTapped() {
        let name = firstTextField.text
        let image = "meat"
        let explorationDate = secondTextField.text
        let product = Product(name: name ?? "some product", image: image, explorationDate: explorationDate ?? "22.12.2023")
        FireBase.shared.addProduct(product: product)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedNotInKeyboard() {
        firstTextField.endEditing(true)
        firstTextField.resignFirstResponder()
        
        secondTextField.endEditing(true)
        secondTextField.resignFirstResponder()
        
        commentField.endEditing(true)
        commentField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let vc1 = self.navigationController?.topViewController as? FridgeViewController {
            DispatchQueue.main.async {
                FireBase.shared.getAllData()
                vc1.collectionView.reloadData()
            }
            
        }
    }
    
}


extension AddProducrViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

