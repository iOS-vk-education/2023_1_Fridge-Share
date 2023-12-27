//
//  LoginViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

final class RegistrationDormitoryViewController: UIViewController {
    
    
    private var label = UILabel()
    private var eduTextField = UITextField()
    private var dormTextField = UITextField()
    private var loginButton = UIButton()

    private enum Constants {
        static let cornerRadius: CGFloat = 15.0
        static let borderWidth: CGFloat = 1.0
        
        static let labelTopOffset: CGFloat = 215.0
        static let labelWidth: CGFloat = 270.0
        static let labelMinimumHeight: CGFloat = 80.0
        
        static let textFieldTopOffset: CGFloat = 150.0
        static let textFieldWidthMultiplier: CGFloat = 0.75
        static let textFieldHeight: CGFloat = 60.0
        
        static let betweenTextFieldsOffset: CGFloat = 20.0
        
        static let loginButtonTopOffset: CGFloat = 30.0
        static let loginButtonSize: CGFloat = 50.0
        
        static let leftViewWidth: CGFloat = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
    }
    
    @objc private func handleLogin() {
        let categoriesVC = CategoriesViewController()
        navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    private func setupUI() {
        
        label = UILabel()
        label.text = "Добро пожаловать"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
                
        eduTextField = UITextField()
        eduTextField.placeholder = "Введите название уч. заведения"
        eduTextField.textColor = .systemBlue
        eduTextField.layer.borderColor = UIColor.systemBlue.cgColor
        eduTextField.layer.borderWidth = Constants.borderWidth
        eduTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        eduTextField.layer.cornerRadius = Constants.cornerRadius
        eduTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        eduTextField.leftViewMode = .always
                
        dormTextField = UITextField()
        dormTextField.placeholder = "Введите название общежития"
        dormTextField.textColor = .systemBlue
        dormTextField.layer.borderColor = UIColor.systemBlue.cgColor
        dormTextField.layer.borderWidth = Constants.borderWidth
        dormTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        dormTextField.layer.cornerRadius = Constants.cornerRadius
        dormTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        dormTextField.leftViewMode = .always
                
        loginButton = UIButton()
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("->", for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
                view.addSubview(label)
                view.addSubview(eduTextField)
                view.addSubview(dormTextField)
                view.addSubview(loginButton)

            }
    private func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        eduTextField.translatesAutoresizingMaskIntoConstraints = false
        dormTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.labelTopOffset),
            label.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.labelMinimumHeight),
                                
            eduTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.textFieldTopOffset),
            eduTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
            eduTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eduTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
                                
            dormTextField.topAnchor.constraint(equalTo: eduTextField.bottomAnchor, constant: Constants.betweenTextFieldsOffset),
            dormTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
            dormTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dormTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
                                
            loginButton.topAnchor.constraint(equalTo: dormTextField.bottomAnchor, constant: Constants.loginButtonTopOffset),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: Constants.loginButtonSize),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.loginButtonSize),
        ])
    }
    
}
