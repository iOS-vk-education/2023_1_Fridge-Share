//
//  LoginViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginDidSucceed: (() -> Void)?
    
    private var logoImageView: UIImageView!
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var registrationPromptButton: UIButton!
    
    private enum Constants {
        static let cornerRadius: CGFloat = 15.0
        static let borderWidth: CGFloat = 1.0
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
        logoImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                
        loginTextField = UITextField()
        loginTextField.placeholder = "Логин"
        loginTextField.textColor = .systemBlue
        loginTextField.layer.borderColor = UIColor.systemBlue.cgColor
        loginTextField.layer.borderWidth = Constants.borderWidth
        loginTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        loginTextField.layer.cornerRadius = Constants.cornerRadius
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        loginTextField.leftViewMode = .always
                
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textColor = .systemBlue
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        passwordTextField.layer.borderWidth = Constants.borderWidth
        passwordTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        passwordTextField.layer.cornerRadius = Constants.cornerRadius
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
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
            logoImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 215),
                    
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 150),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 60),
                    
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
                    
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 160),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationPromptButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registrationPromptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationPromptButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

            registrationPromptButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
    
}
