//
//  ProductViewContoller.swift
//  Fridge&Share
//
//  Created by User on 27.11.2023.
//


import UIKit

class ProductViewController: UIViewController, UITextFieldDelegate {
    
    var selectedImage: UIImage?
    var caption: String?
    var explorationDate: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = UIScreen.main.bounds.height
        
        // Создание основного контейнера для изображения и текстовых полей
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        view.backgroundColor = .FASBackgroundColor
        // Установка верхних, левых, правых и нижних констрейнтов для контейнера
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Создание и добавление изображения сверху экрана
        let imageView = UIImageView(image: selectedImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        // Установка констрейнтов для изображения
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2).isActive = true
        
        // Создание текстовых полей
        let firstTextField = UITextField()
        firstTextField.placeholder = caption
        firstTextField.textColor = UIColor.systemGray6
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(firstTextField)
        
        let secondTextField = UITextField()
        secondTextField.placeholder = explorationDate
        secondTextField.layer.borderWidth = 2.0
        secondTextField.layer.cornerRadius = 5.0
        secondTextField.layer.borderColor = UIColor.green.cgColor
        secondTextField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        secondTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        secondTextField.layer.masksToBounds = true
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(secondTextField)

        // Установка констрейнтов для текстовых полей
       /* NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            firstTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
            secondTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -210),
            secondTextField.heightAnchor.constraint(equalTo: firstTextField.heightAnchor, constant: 30)
        ])
        */
        // Создание поля для комментария
        let commentField = UITextField()
        commentField.placeholder = "Add a comment..."
        commentField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        commentField.layer.cornerRadius = 8.0
        commentField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        commentField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(commentField)
        view.endEditing(true)
        
        
        // Установка констрейнтов для поля комментария
       /* NSLayoutConstraint.activate([
            commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 20),
            commentField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            commentField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            commentField.heightAnchor.constraint(equalToConstant: 80)
        ])
        */
        // Создание и настройка кнопки
        let button = UIButton(type: .system)
        button.setTitle("Попросить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.frame.size = CGSize(width: 100.0, height: 20.0)
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        
        let imageHeight = screenHeight / 3
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        firstTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 10).isActive = true
        secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -210).isActive = true
        
        NSLayoutConstraint.activate([
        commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 10),
        commentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        commentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        commentField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 20),
        button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 105),
        button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -105),
        button.heightAnchor.constraint(equalToConstant: 30),
        
               ])
        
    }
}

/*
 import UIKit

 class ViewController: UIViewController
     
     let imageView = UIImageView()
     let textField1 = UITextField()
     let textField2 = UITextField()
     let commentField = UITextField()
     let requestButton = UIButton()
     
     override func viewDidLoad()
         super.viewDidLoad()
         
         // Set up the image view
         imageView.image = UIImage(named: "yourImageName")
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(imageView)
         
         // Set up the first text field
         textField1.textColor = UIColor.systemGray6
         textField1.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(textField1)
         
         // Set up the second text field
         textField2.layer.borderWidth = 1
         textField2.layer.borderColor = UIColor.green.cgColor
         textField2.layer.cornerRadius = 10
         textField2.backgroundColor = UIColor.green.withAlphaComponent(0.3)
         textField2.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(textField2)
         
         // Set up the comment field
         commentField.placeholder = "Add a comment..."
         commentField.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(commentField)
         
         // Set up the request button
         requestButton.setTitle("Попросить", for: .normal)
         requestButton.backgroundColor = .blue // Set your desired background color
         requestButton.setTitleColor(.white, for: .normal)
         requestButton.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(requestButton)
         
         // Set up constraints
         let screenHeight = UIScreen.main.bounds.height
         let imageHeight = screenHeight / 3
         
         imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
         
         textField1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
         textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
         textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
         
         textField2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 10).isActive = true
         textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
         textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
         
         commentField.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 10).isActive = true
         commentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
         commentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
         
         requestButton.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 10).isActive = true
         requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 */
