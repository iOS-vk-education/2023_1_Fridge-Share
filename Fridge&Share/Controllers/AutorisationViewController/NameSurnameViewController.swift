//
//  RegistrationViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

final class NameSurnameViewController: UIViewController {
    
    private var label: UILabel!
    private var nameTextField: UITextField!
    private var surnameTextField: UITextField!
    private var registerButton: UIButton!
    
    
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
        nameTextField.layer.borderWidth = 1.0
        nameTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        nameTextField.layer.cornerRadius = 15
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nameTextField.leftViewMode = .always
                
        surnameTextField = UITextField()
        surnameTextField.placeholder = "Фамилия"
        surnameTextField.textColor = .systemBlue
        surnameTextField.layer.borderColor = UIColor.systemBlue.cgColor
        surnameTextField.layer.borderWidth = 1.0
        surnameTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        surnameTextField.layer.cornerRadius = 15
        surnameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        surnameTextField.leftViewMode = .always
                
        registerButton = UIButton()
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitle("Продолжить", for: .normal)
        registerButton.layer.cornerRadius = 15
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
                label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 215),
                label.widthAnchor.constraint(equalToConstant: 270),
                label.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
                        
                nameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 150),
                nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
                nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameTextField.heightAnchor.constraint(equalToConstant: 60),
                        
                surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                surnameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
                surnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                surnameTextField.heightAnchor.constraint(equalToConstant: 60),
                        
                registerButton.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 30),
                registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                registerButton.widthAnchor.constraint(equalToConstant: 210),
                registerButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
}
