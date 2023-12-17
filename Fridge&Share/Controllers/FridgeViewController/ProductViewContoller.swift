import UIKit

final class ProductViewController: UIViewController, UITextFieldDelegate {
        
        private let firstTextField = UITextField()
        private let secondTextField = UITextField()
        private let imageView = UIImageView()
        private let commentField = UITextField()
        private let button = UIButton ()
    
    let button = UIButton(type: .system)
    let firstTextField = UITextField()
    let secondTextField = UITextField()
    
    private func setupUI(){
        
        let viewModel = ProductViewModel(selectedImage: imageView.image!, caption: firstTextField.placeholder!, explorationDate: secondTextField.placeholder!)
        setupViews(viewModel: viewModel)
        setupConstraints()
    }
        // Создание основного контейнера для изображения и текстовых полей
        let containerView: UIView = {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            return container
        }()
        
        // Создание и добавление изображения сверху экрана
        private func setupViews(viewModel: ProductViewModel) {
            //imageView = UIImageView(image: viewModel.selectedImage)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        
        // Создание текстовых полей
            //let firstTextField = UITextField()
            firstTextField.placeholder = viewModel.caption
            firstTextField.textColor = UIColor.systemGray6
            
            //let secondTextField = UITextField()
            secondTextField.placeholder = viewModel.explorationDate
            secondTextField.layer.borderWidth = Constants.borderWidth
            secondTextField.layer.cornerRadius = Constants.cornerRadius
            secondTextField.layer.borderColor = UIColor.green.cgColor
            secondTextField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
            secondTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            secondTextField.layer.masksToBounds = true
            
        // Создание поля для комментария
        //let commentField = UITextField()
            commentField.placeholder = Constants.placeholder
            commentField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            commentField.layer.cornerRadius = Constants.cornerRadius
            commentField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            
        // Создание и настройка кнопки
        //let button = UIButton ()
            button.setTitle(Constants.title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .blue
            button.frame.size = CGSize(width: Constants.width, height: Constants.height)
            button.layer.cornerRadius = Constants.cornerRadius
        }
    
        private func setupConstraints(){
            imageView.translatesAutoresizingMaskIntoConstraints = false;
            firstTextField.translatesAutoresizingMaskIntoConstraints = false;
            button.translatesAutoresizingMaskIntoConstraints = false;
            secondTextField.translatesAutoresizingMaskIntoConstraints = false;
            commentField.translatesAutoresizingMaskIntoConstraints = false;

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2),
            
            button.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 105),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -105),
            button.heightAnchor.constraint(equalToConstant: 30),
            
            commentField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 10),
            commentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentField.heightAnchor.constraint(equalToConstant: 40),
            
            firstTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 10),
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -310),
            ])
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
                view.backgroundColor = .FASBackgroundColor
            
                view.addSubview(containerView)
                containerView.addSubview(imageView)
                containerView.addSubview(firstTextField)
                containerView.addSubview(secondTextField)
                containerView.addSubview(commentField)
                containerView.addSubview(button)
            
                view.endEditing(true)
            
            listOfProducts.append(product)
            let dialogMessage = UIAlertController(title: "Внимание!", message: "Вы добавили продукт!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.navigationController?.popViewController(animated: true)
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
            
    }
