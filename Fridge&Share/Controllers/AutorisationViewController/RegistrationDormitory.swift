//
//  LoginViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

final class RegistrationDormitoryViewController: UIViewController {
    
    
    private var label: UILabel!
    private var eduTextField: UITextField!
    private var dormTextField: UITextField!
    private var loginButton: UIButton!
    private var registrationPromptButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
    }
    
    
    @objc private func handleRegistration() {
        let newDormViewController = NewDormitoryViewController()
        navigationController?.pushViewController(newDormViewController, animated: true)
    }
    
    @objc private func handleLogin() {
        let yourDormVC = YourDormViewController()
        navigationController?.pushViewController(yourDormVC, animated: true)
    }
    
    private func setupUI() {
        
        label = UILabel()
        label.text = "Добро пожаловать, "
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
                
        eduTextField = UITextField()
        eduTextField.placeholder = "Введите название уч. заведения"
        eduTextField.textColor = .systemBlue
        eduTextField.layer.borderColor = UIColor.systemBlue.cgColor
        eduTextField.layer.borderWidth = 1.0
        eduTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        eduTextField.layer.cornerRadius = 15
        eduTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        eduTextField.leftViewMode = .always
                
        dormTextField = UITextField()
        dormTextField.placeholder = "Выберите название общежития"
        dormTextField.textColor = .systemBlue
        dormTextField.layer.borderColor = UIColor.systemBlue.cgColor
        dormTextField.layer.borderWidth = 1.0
        dormTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        dormTextField.layer.cornerRadius = 15
        dormTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        dormTextField.leftViewMode = .always
                
        loginButton = UIButton()
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("->", for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        registrationPromptButton = UIButton(type: .system)
        registrationPromptButton.setTitle("Не нашли общежитие? Создайте!", for: .normal)
        registrationPromptButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registrationPromptButton.titleLabel?.numberOfLines = 2
        registrationPromptButton.titleLabel?.lineBreakMode = .byWordWrapping
        registrationPromptButton.titleLabel?.textAlignment = .center
        registrationPromptButton.setTitleColor(.systemBlue, for: .normal)
        registrationPromptButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
                view.addSubview(label)
                view.addSubview(eduTextField)
                view.addSubview(dormTextField)
                view.addSubview(loginButton)
                view.addSubview(registrationPromptButton)

            }
    private func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        eduTextField.translatesAutoresizingMaskIntoConstraints = false
        dormTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registrationPromptButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 215),
            label.widthAnchor.constraint(equalToConstant: 270),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
                    
            eduTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 150),
            eduTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            eduTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eduTextField.heightAnchor.constraint(equalToConstant: 60),
                    
            dormTextField.topAnchor.constraint(equalTo: eduTextField.bottomAnchor, constant: 20),
            dormTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            dormTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dormTextField.heightAnchor.constraint(equalToConstant: 60),
                    
            loginButton.topAnchor.constraint(equalTo: dormTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationPromptButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registrationPromptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationPromptButton.widthAnchor.constraint(equalToConstant: 200),
            registrationPromptButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
}
