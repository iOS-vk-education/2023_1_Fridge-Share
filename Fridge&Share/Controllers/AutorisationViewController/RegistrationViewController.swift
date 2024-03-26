//
//  RegistrationViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit
import Firebase
import FirebaseAuth

var listOfUsers: [User] = []

final class RegistrationViewController: UIViewController {
    
    private var logoImageView = UIImageView()
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var registerButton = UIButton()
    
    private enum Constants {
        static let logoImageViewTopOffset: CGFloat = 215.0
        static let logoImageViewScale: CGFloat = 0.45

        static let textFieldsTopOffset: CGFloat = 150.0
        static let textFieldsSpacing: CGFloat = 20.0
        static let textFieldsWidthMultiplier: CGFloat = 0.75
        static let textFieldsHeight: CGFloat = 60.0

        static let registerButtonTopOffset: CGFloat = 30.0
        static let registerButtonWidth: CGFloat = 210.0
        static let registerButtonHeight: CGFloat = 50.0

        static let generalSpacing: CGFloat = 10.0
        
        static let cornerRadius: CGFloat = 15.0
        static let borderWidth: CGFloat = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
    }

    @objc private func handleRegistration() {
        if let email = loginTextField.text, let password = passwordTextField.text {
            FirebaseAuthManager.shared.createUser(email: email, password: password) { [weak self] (success) in
                guard let self = self, success else {
                    return
                }
                listOfUsers.append(User(id: FirebaseAuthManager.shared.userId, email: email, password: password))
                let NSViewController = NameSurnameViewController()
                NSViewController.configure(id: FirebaseAuthManager.shared.userId)
                self.present(NSViewController, animated: true, completion: nil)
            }
        }
    }
    private func setupUI() {
        let tapElsewhereGesture = UITapGestureRecognizer(target: self, action: #selector(tappedNotInKeyboard))
        tapElsewhereGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapElsewhereGesture)
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        logoImageView.transform = CGAffineTransform(scaleX: Constants.logoImageViewScale, y: Constants.logoImageViewScale)
                
        loginTextField = UITextField()
        loginTextField.placeholder = "Email"
        loginTextField.textColor = .systemBlue
        loginTextField.layer.borderColor = UIColor.systemBlue.cgColor
        loginTextField.layer.borderWidth = Constants.borderWidth
        loginTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        loginTextField.layer.cornerRadius = Constants.cornerRadius
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.generalSpacing, height: 0))
        loginTextField.leftViewMode = .always
                
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textColor = .systemBlue
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        passwordTextField.layer.borderWidth = Constants.borderWidth
        passwordTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        passwordTextField.layer.cornerRadius = Constants.cornerRadius
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.generalSpacing, height: 0))
        passwordTextField.leftViewMode = .always
                
        registerButton = UIButton()
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.layer.cornerRadius = Constants.cornerRadius
        registerButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
    @objc func tappedNotInKeyboard() {
        loginTextField.endEditing(true)
        loginTextField.resignFirstResponder()
        
        passwordTextField.endEditing(true)
        passwordTextField.resignFirstResponder()
    }

    private func setupConstraints() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.logoImageViewTopOffset),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.textFieldsTopOffset),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldsWidthMultiplier),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Constants.textFieldsSpacing),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldsWidthMultiplier),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.registerButtonTopOffset),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: Constants.registerButtonWidth),
            registerButton.heightAnchor.constraint(equalToConstant: Constants.registerButtonHeight)
        ])
    }
    
    func registerUser(email: String, password: String) {
        FirebaseAuthManager.shared.createUser(email: email, password: password) {[weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            if (success) {
                message = "Пользователь успешно зарегистрирован!"
            } else {
                message = "Ошибка!"
            }
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
