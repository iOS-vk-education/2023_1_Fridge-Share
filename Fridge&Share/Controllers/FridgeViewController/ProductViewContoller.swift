//
//  ProductViewContoller.swift
//  Fridge&Share
//
//  Created by User on 27.11.2023.
//


import UIKit

class ProductViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let imageView = UIImageView(image: UIImage(named: "product1"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        // Установка констрейнтов для изображения
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        // Создание текстовых полей
        let firstTextField = UITextField()
        firstTextField.placeholder = "Печенье овсяное с шоколадом"
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(firstTextField)
        
        let secondTextField = UITextField()
        secondTextField.placeholder = "03.12.23"
        secondTextField.layer.borderWidth = 1.0
        secondTextField.layer.cornerRadius = 10.0
        secondTextField.layer.borderColor = UIColor.green.cgColor
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(secondTextField)
        
        // Установка констрейнтов для текстовых полей
        NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            firstTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
            secondTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            secondTextField.heightAnchor.constraint(equalTo: firstTextField.heightAnchor)
        ])
        
        // Создание поля для комментария
        let commentField = UITextView()
        commentField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        commentField.layer.cornerRadius = 8.0
        commentField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(commentField)
        
        
        // Установка констрейнтов для поля комментария
        NSLayoutConstraint.activate([
            commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 20),
            commentField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            commentField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            commentField.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Создание и настройка кнопки
        let button = UIButton(type: .system)
        button.setTitle("Попросить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        
        // Установка констрейнтов для кнопки
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}


