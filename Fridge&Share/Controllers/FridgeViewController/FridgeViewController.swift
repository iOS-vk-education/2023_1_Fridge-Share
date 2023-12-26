//
//  FridgeViewController.swift
//  Fridge&Share
//
//  Created by User on 23.11.2023.
//

import UIKit

var listOfProducts : [Product] = [
    .init(name: "Название продукта", image: "product17", explorationDate: "дд.мм.гг"),
    .init(name: "Печенье овсяное с шоколадом", image: "product1", explorationDate: "13.12.23"),
    .init(name: "Помидоры", image: "product2", explorationDate: "03.12.23"),
    .init(name: "Огурцы", image: "product3", explorationDate: "05.12.23"),
    .init(name: "Молоко", image: "product4", explorationDate: "30.11.23"),
    .init(name: "Яйца", image: "product5", explorationDate: "07.01.24"),
    .init(name: "Яблочный пирог", image: "product6", explorationDate: "06.12.23"),
    .init(name: "Бананы", image: "product7", explorationDate: "30.11.23"),
    .init(name: "Вода", image: "product8", explorationDate: "12.11.24"),
    .init(name: "Клубника", image: "product9", explorationDate: "03.12.23"),
    .init(name: "Яблочный пирог", image: "product10", explorationDate: "05.12.23"),
    .init(name: "Ананас", image: "product11", explorationDate: "07.01.24"),
    .init(name: "Пицца", image: "product12", explorationDate: "03.12.23"),
    .init(name: "Вишневый пирог", image: "product13", explorationDate: "05.12.23"),
    .init(name: "Сыр", image: "product14", explorationDate: "03.12.23"),
    .init(name: "Творог", image: "product15", explorationDate: "30.11.23"),
    .init(name: "Куриное филе", image: "product16", explorationDate: "13.12.23"),
]

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
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")

    }

    func setupSearchButton() {

        searchButton = UIButton(type: .system)
        searchButton.setTitle("Добавить продукт", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = UIColor.systemBlue
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
        let productVC = ProductViewController()
           
           guard !listOfProducts.isEmpty,
                 let selectedImage = UIImage(named: listOfProducts[0].image) else {
               return
           }
           let productNameString = listOfProducts[0].name
           let productDate = listOfProducts[0].explorationDate

           let viewModel = ProductViewController.ProductViewModel(selectedImage: selectedImage, caption: productNameString, explorationDate: productDate)

           productVC.setModel(viewModel)
           self.navigationController?.pushViewController(productVC, animated: true)
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
        collectionView?.register(for: ProductCell.self)
        view.backgroundColor = .FASBackgroundColor
        collectionView.backgroundColor = .FASBackgroundColor
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let productImageName = products[indexPath.row]
        let productOwnerImageName = productOwner[indexPath.row % productOwner.count]
        let viewModel = ProductCell.ProductCellModel(productImageName: productImageName, productOwnerImageName: productOwnerImageName)
        cell.setModel(viewModel)

        cell.productOwnerImageView.isHidden = indexPath.row == 0

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
            let cellWidth = availableWidth / 4
        
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)

            // Минимальные отступы для секций и интервалы между элементами
            layout.minimumInteritemSpacing = padding
            layout.minimumLineSpacing = padding*4

            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

            collectionView.collectionViewLayout = layout
        }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let productVC = ProductViewController()
        guard let selectedImage = UIImage(named: products[indexPath.row]) else { return }
        let productNameString = productName[indexPath.row]
        let productDate = productExplorationDate[indexPath.row]
        let viewModel = ProductViewController.ProductViewModel(selectedImage: selectedImage, caption: productNameString, explorationDate: productDate)
        productVC.setModel(viewModel)
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}
