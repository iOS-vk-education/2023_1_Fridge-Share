//
//  LoginViewController.swift
//  Fridge&Share
//
//  Created by User on 26.12.2023.
//

import UIKit

final class RegistrationDormitoryViewController: UIViewController {
    var userId: String = ""
    var username: String = ""
    var usersurname: String = ""
    
    func configure(id: String, name: String, surname: String) {
        userId = id
        username = name
        usersurname = surname
        print(id)
        print(name)
        print(surname)
    }
    
    private var label = UILabel()
    private var eduTextField = UITextField()
    private var dormTextField = UITextField()
    private var loginButton = UIButton()
    private var registrationPromptButton = UIButton()
    
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
        
        static let registrationPromptButtonTopOffset: CGFloat = 10.0
        static let registrationPromptButtonWidth: CGFloat = 200.0
        static let registrationPromptButtonMinimumHeight: CGFloat = 100.0
        
        static let leftViewWidth: CGFloat = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
    }
    
    
    @objc private func handleRegistration() {
    }
    
    @objc private func handleLogin() {
        if let numberOfFloor = eduTextField.text, let numberOfFrige = dormTextField.text {
            if let index = listOfUsers.firstIndex(where: { $0.id == userId }) {
                var user = listOfUsers[index]
                user.numberOfFloor = Int(numberOfFloor)
                user.numberOfFrige = Int(numberOfFrige)
                FireBase.shared.updateUser(documentId: userId, user: user)
                
                FireBase.shared.getAllUsers{ listOfUsers in
                    
                }
                let alertController = UIAlertController(title: nil, message: "Вы успешно заригистрированы!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func setupUI() {
        
        label = UILabel()
        label.text = "Добро пожаловать, \(username) \(usersurname)"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        eduTextField = UITextField()
        eduTextField.placeholder = "Введите номер этажа"
        eduTextField.textColor = .systemBlue
        eduTextField.layer.borderColor = UIColor.systemBlue.cgColor
        eduTextField.layer.borderWidth = Constants.borderWidth
        eduTextField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        eduTextField.layer.cornerRadius = Constants.cornerRadius
        eduTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.leftViewWidth, height: 0))
        eduTextField.leftViewMode = .always
        
        dormTextField = UITextField()
        dormTextField.placeholder = "Выберите номер холодильника"
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
        
    }
    private func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        eduTextField.translatesAutoresizingMaskIntoConstraints = false
        dormTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registrationPromptButton.translatesAutoresizingMaskIntoConstraints = false
        
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
