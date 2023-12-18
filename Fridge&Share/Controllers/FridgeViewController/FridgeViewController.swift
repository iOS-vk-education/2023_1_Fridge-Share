//
//  FridgeViewController.swift
//  Fridge&Share
//
//  Created by User on 23.11.2023.
//

import UIKit

final class FridgeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let products = ["product17", "bread", "cucumber", "dumplings", "fish", "butter", "meat", "milk", "salad", "tomato", "milk2"]
    
    let productName = ["Название продукта", "Хлеб", "Огурцы", "Пельмени", "Рыба", "Масло", "Колбаса", "Молоко", "Салат", "Помидоры", "Молоко"]
    let productExplorationDate = ["дд.мм.гг", "26.12.23", "28.12.23", "05.02.24", "30.12.23", "07.01.24", "28.12.23", "30.12.23", "29.12.23", "07.01.24", "03.02.24"]
    let productOwner = ["ava1", "ava2", "ava3", "ava4"]
    var collectionView: UICollectionView!
    var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchButton()
        setCollectionView()
        setCollectionViewLayout()
    }

    func setupSearchButton() {
        searchButton = UIButton(type: .system)
        searchButton.setTitle("поиск продуктов по категориям ->", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .systemGray4
        searchButton.layer.cornerRadius = 15
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/7),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)
        ])
    }
    
    @objc func searchButtonTapped() {
    let categoryViewController = CategoriesViewController()
    self.navigationController?.pushViewController(categoryViewController, animated: true)
    }

    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .FASBackgroundColor
        collectionView.backgroundColor = .FASBackgroundColor
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
    if indexPath.item != 0 {
        let roundViewTag = 100 // произвольный идентификатор для roundView
        let radius = cell.bounds.size.width / 4
        if  let roundView = cell.contentView.viewWithTag(roundViewTag) {
            roundView.frame = CGRect(x: cell.bounds.size.width / 2 - radius,
                                     y: cell.bounds.size.height - radius,
                                                   width: 2 * radius,
                                                   height: 2 * radius)
        }
        else {
            let roundView = UIImageView(frame: CGRect(x: cell.bounds.size.width / 2 - radius,
                                                    y: cell.bounds.size.height - radius,
                                                    width: 2 * radius,
                                                    height: 2 * radius))
            roundView.backgroundColor = .white
            roundView.tag = roundViewTag 
            let imageName = self.productOwner[indexPath.item % self.productOwner.count]
            roundView.image = UIImage(named: imageName)
            roundView.layer.cornerRadius = radius
            roundView.layer.borderWidth = 1.0
            roundView.layer.borderColor = UIColor.lightGray.cgColor
            roundView.layer.masksToBounds = true
            cell.contentView.addSubview(roundView)
        }
    }
    cell.productImageView.image = UIImage(named: products[indexPath.item])
       
       return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func setCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            let padding: CGFloat = 15 // Отступы между ячейками и от работы к краям.
            // Используем три отступа между элементами (2 между ячейками и по одному с каждого края).
            let availableWidth = view.frame.size.width - padding * 4
            let cellWidth = availableWidth / 4 // ширина для каждой ячейки
            
            // Установить размер каждой ячейки
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)

            // Установить минимальные отступы для секций и интервалы между элементами
            layout.minimumInteritemSpacing = padding
            layout.minimumLineSpacing = padding*4
            
            // Установить отступы секции
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

            // Обновить collectionView с новыми параметрами компоновки
            collectionView.collectionViewLayout = layout
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            let productVC = ProductViewController()
        guard let selectedImage = UIImage(named: productName[indexPath.row]) else { return }
        let viewModel = ProductViewController.ProductViewModel(selectedImage: selectedImage,caption: productName[indexPath.row],explorationDate: productExplorationDate[indexPath.row])

           productVC.setModel(viewModel)
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}

