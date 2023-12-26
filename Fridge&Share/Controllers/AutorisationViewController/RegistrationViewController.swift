//
//  RegistrationViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    private var logoImageView: UIImageView!
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var registerButton: UIButton!
    
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
    
    @objc private func handleRegistration() {
        let NSViewController = NameSurnameViewController()
        navigationController?.pushViewController(NSViewController, animated: true)
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
        private func setupConstraints() {
            
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            loginTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            
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
                        
                registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
                registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                registerButton.widthAnchor.constraint(equalToConstant: 210),
                registerButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
}
