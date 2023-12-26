//
//  RegistrationViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

final class NameSurnameViewController: UIViewController {
    
    private var label = UILabel()
    private var nameTextField = UITextField()
    private var surnameTextField = UITextField()
    private var registerButton = UIButton()
    
    private enum Constants {
        static let cornerRadius: CGFloat = 15.0
        static let borderWidth: CGFloat = 1.0
        static let leftViewWidth: CGFloat = 10
        
        static let labelTopOffset: CGFloat = 215.0
        static let labelWidth: CGFloat = 270.0
        static let labelMinimumHeight: CGFloat = 60.0
        
        static let nameTextFieldTopOffset: CGFloat = 150.0
        
        static let textFieldWidthMultiplier: CGFloat = 0.75
        static let textFieldHeight: CGFloat = 60.0
                
        static let surnameTextFieldTopOffset: CGFloat = 20.0
                
        static let registerButtonTopOffset: CGFloat = 30.0
        static let registerButtonWidth: CGFloat = 210.0
        static let registerButtonHeight: CGFloat = 50.0
    }
    
    @objc private func handleRegistration() {
        let registrationDormitoryViewController = RegistrationDormitoryViewController()
        navigationController?.pushViewController(registrationDormitoryViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        label = UILabel()
        label.text = "Давайте познакомимся"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        nameTextField = UITextField()
        nameTextField.placeholder = "Имя"
        nameTextField.textColor = .systemBlue
        nameTextField.layer.borderColor = UIColor.systemBlue.cgColor
        nameTextField.layer.borderWidth = Constants.borderWidth
        nameTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        nameTextField.layer.cornerRadius = Constants.cornerRadius
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        nameTextField.leftViewMode = .always
                
        surnameTextField = UITextField()
        surnameTextField.placeholder = "Фамилия"
        surnameTextField.textColor = .systemBlue
        surnameTextField.layer.borderColor = UIColor.systemBlue.cgColor
        surnameTextField.layer.borderWidth = Constants.borderWidth
        surnameTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        surnameTextField.layer.cornerRadius = Constants.cornerRadius
        surnameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        surnameTextField.leftViewMode = .always
                
        registerButton = UIButton()
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitle("Продолжить", for: .normal)
        registerButton.layer.cornerRadius = Constants.cornerRadius
        registerButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(registerButton)
    }
        private func setupConstraints() {
            
            label.translatesAutoresizingMaskIntoConstraints = false
            nameTextField.translatesAutoresizingMaskIntoConstraints = false
            surnameTextField.translatesAutoresizingMaskIntoConstraints = false
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.labelTopOffset),
                label.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
                label.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.labelMinimumHeight),
                            
                nameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.nameTextFieldTopOffset),
                nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
                nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
                            
                surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.surnameTextFieldTopOffset),
                surnameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
                surnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                surnameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
                            
                registerButton.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: Constants.registerButtonTopOffset),
                registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                registerButton.widthAnchor.constraint(equalToConstant: Constants.registerButtonWidth),
                registerButton.heightAnchor.constraint(equalToConstant: Constants.registerButtonHeight)
            ])
        }
}
