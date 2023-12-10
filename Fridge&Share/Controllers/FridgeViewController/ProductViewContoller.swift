import UIKit

final class ProductViewController: UIViewController, UITextFieldDelegate {
        
        private enum Constants {
            static var selectedImage: UIImage?
            static var caption: String?
            static var explorationDate: String? 
            static let title = "Попросить"
            static let placeholder = "Добавить комментарий"
            static let profileCornerRadius: CGFloat = 35
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 2.0
            static let screenHeight = UIScreen.main.bounds.height
            static let imageHeight = screenHeight/3
            static let width: CGFloat = 100
            static let height: CGFloat = 20
        }
            
        func setSelectedImage(_ image: UIImage) {
            Constants.selectedImage = image
        }

        func setCaption(_ caption: String) {
            Constants.caption = caption
        }

        func setExplorationDate(_ date: String) {
            Constants.explorationDate = date
        }
        
        // Создание основного контейнера для изображения и текстовых полей
        let containerView: UIView = {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            return container
        }()
        
        // Создание и добавление изображения сверху экрана
        let imageContainerView:UIImageView = {
            let img = UIImageView(image: Constants.selectedImage)
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            img.translatesAutoresizingMaskIntoConstraints = false
            return img
        }()
        
        // Создание текстовых полей
        let firstTextField:UITextField = {
            let firstTF = UITextField()
            firstTF.placeholder = Constants.caption
            firstTF.textColor = UIColor.systemGray6
            firstTF.translatesAutoresizingMaskIntoConstraints = false
            return firstTF
        }()
        
        let secondTextField:UITextField = {
            let secondTF = UITextField()
            secondTF.placeholder = Constants.explorationDate
            secondTF.layer.borderWidth = Constants.borderWidth
            secondTF.layer.cornerRadius = Constants.cornerRadius
            secondTF.layer.borderColor = UIColor.green.cgColor
            secondTF.backgroundColor = UIColor.green.withAlphaComponent(0.3)
            secondTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            secondTF.layer.masksToBounds = true
            secondTF.translatesAutoresizingMaskIntoConstraints = false
            return secondTF
        }()
        
        // Создание поля для комментария
        let commentField:UITextField = {
            let comment = UITextField()
            comment.placeholder = Constants.placeholder
            comment.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            comment.layer.cornerRadius = Constants.cornerRadius
            comment.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            comment.translatesAutoresizingMaskIntoConstraints = false
            return comment
        }()
        
        // Создание и настройка кнопки
        let button:UIButton = {
            let but = UIButton(type: .system)
            but.setTitle(Constants.title, for: .normal)
            but.setTitleColor(.white, for: .normal)
            but.backgroundColor = .blue
            but.frame.size = CGSize(width: Constants.width, height: Constants.height)
            but.layer.cornerRadius = Constants.cornerRadius
            but.translatesAutoresizingMaskIntoConstraints = false
            return but
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
                view.backgroundColor = .FASBackgroundColor
            
                view.addSubview(containerView)
                containerView.addSubview(imageContainerView)
                containerView.addSubview(firstTextField)
                containerView.addSubview(secondTextField)
                containerView.addSubview(commentField)
                containerView.addSubview(button)
            
                view.endEditing(true)
            
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: view.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
                imageContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                imageContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                imageContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2),
                button.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 20),
                button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 105),
                button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -105),
                button.heightAnchor.constraint(equalToConstant: 30),
                commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 10),
                commentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                commentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                commentField.heightAnchor.constraint(equalToConstant: 40),
                firstTextField.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 20),
                firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 10),
                secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -210)
            ])
            
    }
}
