//
//  LoginViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginDidSucceed: (() -> Void)?
    
    private var logoImageView = UIImageView()
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    private var registrationPromptButton = UIButton()
    
    private enum Constants {
        static let cornerRadius: CGFloat = 15.0
        static let borderWidth: CGFloat = 1.0
        
        static let logoImageViewScale: CGFloat = 1.3
        static let textFieldHeight: CGFloat = 60.0
        static let buttonCornerRadius: CGFloat = 15.0
        static let leftViewWidth: CGFloat = 10
        
        static let loginButtonWidth: CGFloat = 160
        static let loginButtonHeight: CGFloat = 50
        
        static let textFieldWidthMultiplier: CGFloat = 0.75
        static let registrationButtonWidthMultiplier: CGFloat = 0.9
        static let registrationButtonMinHeight: CGFloat = 40.0
        static let textFieldsTopConstraint: CGFloat = 150.0
        static let textFieldSpacing: CGFloat = 20.0
        static let buttonTopConstraint: CGFloat = 30.0
        static let registrationButtonTopConstraint: CGFloat = 20.0
        static let logoImageCenterYOffset: CGFloat = 215.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
    }
    
    @objc private func handleLogin() {
        loginDidSucceed?()
    }
    
    @objc private func handleRegistration() {
        let registrationViewController = RegistrationViewController()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    private func setupUI() {
        
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        logoImageView.transform = CGAffineTransform(scaleX: Constants.logoImageViewScale, y: Constants.logoImageViewScale)
                
        loginTextField = UITextField()
        loginTextField.placeholder = "Логин"
        loginTextField.textColor = .systemBlue
        loginTextField.layer.borderColor = UIColor.systemBlue.cgColor
        loginTextField.layer.borderWidth = Constants.borderWidth
        loginTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        loginTextField.layer.cornerRadius = Constants.cornerRadius
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        loginTextField.leftViewMode = .always
                
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textColor = .systemBlue
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        passwordTextField.layer.borderWidth = Constants.borderWidth
        passwordTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        passwordTextField.layer.cornerRadius = Constants.cornerRadius
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        passwordTextField.leftViewMode = .always
                
        loginButton = UIButton()
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("Войти", for: .normal)
        loginButton.layer.cornerRadius = Constants.cornerRadius
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        registrationPromptButton = UIButton(type: .system)
        registrationPromptButton.setTitle("или Регистрация с эл. адресом или номером телефона", for: .normal)
        registrationPromptButton.titleLabel?.numberOfLines = 2
        registrationPromptButton.titleLabel?.lineBreakMode = .byWordWrapping
        registrationPromptButton.titleLabel?.textAlignment = .center
        registrationPromptButton.setTitleColor(.systemBlue, for: .normal)
        registrationPromptButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
                view.addSubview(logoImageView)
                view.addSubview(loginTextField)
                view.addSubview(passwordTextField)
                view.addSubview(loginButton)
                view.addSubview(registrationPromptButton)

            }
    private func setupConstraints() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registrationPromptButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.logoImageCenterYOffset),
                    
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.textFieldsTopConstraint),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
                    
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Constants.textFieldSpacing),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
                    
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.buttonTopConstraint),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: Constants.loginButtonWidth),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.loginButtonHeight),
            
            registrationPromptButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Constants.registrationButtonTopConstraint),
            registrationPromptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationPromptButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.registrationButtonWidthMultiplier),

            registrationPromptButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.registrationButtonMinHeight)
        ])
    }
    
}
