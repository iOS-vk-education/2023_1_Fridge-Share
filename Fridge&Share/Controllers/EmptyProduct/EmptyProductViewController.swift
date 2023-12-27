//
//  EmptyProductViewController.swift
//  Fridge&Share
//
//  Created by User on 27.12.2023.
//
import UIKit

final class EmptyProductViewController: UIViewController, UITextFieldDelegate {
    
    private let firstTextField = UITextField()
    private let secondTextField = UITextField()
    private let imageView = UIImageView()
    private let commentField = UITextField()
    private let button = UIButton()
    
    private let datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.preferredDatePickerStyle = .wheels
            picker.datePickerMode = .date
            return picker
        }()
    
    private enum Constants {
        static let title = "Добавить"
        static let placeholder = "Добавить комментарий"
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2.0
        static let screenHeight = UIScreen.main.bounds.height
        static let imageHeight = screenHeight/3
        static let width: CGFloat = 100
        static let height: CGFloat = 20
        static let heightImage: CGFloat = 400
        static let grayBorderColor = UIColor.gray.cgColor
        static let grayTextColor = UIColor.gray
    }
    
    struct ProductViewModel {
        let selectedImage: UIImage
        let caption: String
        let explorationDate: String
    }
    
    func setModel(_ viewModel: ProductViewModel) {
        firstTextField.text = viewModel.caption
        secondTextField.text = viewModel.explorationDate
        imageView.image = viewModel.selectedImage
    }
    
    private func setupUI(){
        
     
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "empty")
        view.addSubview(imageView)
        
        firstTextField.borderStyle = .roundedRect
        firstTextField.text = "Название продукта"
        firstTextField.font = UIFont.systemFont(ofSize: 26)
        view.addSubview(firstTextField)
        
        secondTextField.borderStyle = .roundedRect
        secondTextField.text = "дд.мм.гг"
        secondTextField.layer.borderWidth = Constants.borderWidth
        secondTextField.layer.borderColor = Constants.grayBorderColor
        secondTextField.layer.cornerRadius = Constants.cornerRadius
        secondTextField.font = UIFont.systemFont(ofSize: 22)
        secondTextField.textColor = Constants.grayTextColor
        secondTextField.backgroundColor = .FASBackgroundColor
        
        secondTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        view.addSubview(secondTextField)

        commentField.placeholder = Constants.placeholder
        commentField.font = UIFont.systemFont(ofSize: 22)
        commentField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        commentField.layer.cornerRadius = Constants.cornerRadius
        commentField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        view.addSubview(commentField)
        
        button.setTitle(Constants.title, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = Constants.cornerRadius
        view.addSubview(button)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.userDidTapTitle(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        commentField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.heightImage),
            
            firstTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.height+5),
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.height*2),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.height*2),
            
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.height*2),
            secondTextField.widthAnchor.constraint(equalToConstant: 155),
            secondTextField.heightAnchor.constraint(equalToConstant: Constants.height*2),
            
            commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 25),
            commentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.height*2),
            commentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.height*2),
            commentField.heightAnchor.constraint(equalToConstant: 65),
            
            button.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: Constants.height*3),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FASBackgroundColor
        setupUI()
        setupConstraints()
        configureDatePicker()
        view.endEditing(true)
    }
    
    @objc func userDidTapTitle(_ sender: UITapGestureRecognizer) {
        if firstTextField.text == "Название продукта" {
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
    }
    
    private func configureDatePicker() {
            
            secondTextField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
            toolbar.setItems([doneButton], animated: false)
            
            secondTextField.inputAccessoryView = toolbar
        }
        
        @objc func datePickerChanged(picker: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            
            secondTextField.text = formatter.string(from: picker.date)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
}


extension EmptyProductViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
