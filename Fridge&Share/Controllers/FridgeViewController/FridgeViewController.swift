//
//  FridgeViewController.swift
//  Fridge&Share
//
//  Created by User on 23.11.2023.
//

import UIKit

final class FridgeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let products = ["product17", "bread", "cucumber", "dumplings", "fish", "butter", "meat", "milk", "salad", "tomato", "milk2"]
    
    let productName = ["Название продукта", "Хлеб", "Огурцы", "Пельмени", "Рыба", "Масло", "Колбаса", "Молоко", "Салат", "Помидоры", "Молоко"]
    let productExplorationDate = ["дд.мм.гг", "26.12.23", "28.12.23", "05.02.24", "30.12.23", "07.01.24", "28.12.23", "30.12.23", "29.12.23", "07.01.24", "03.02.24"]
    var collectionView: UICollectionView!
    var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchButton()
        setCollectionView()
    }

    func setupSearchButton() {
        searchButton = UIButton(type: .system)
        searchButton.setTitle("поиск продуктов по категориям ->", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .gray
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    @objc func searchButtonTapped() {
    let categoryViewController = CategoriesViewController()
    present(categoryViewController, animated: true, completion: nil)
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCell
    else {
        return UICollectionViewCell()
        
    }
    cell.productImageView.image = UIImage(named: products[indexPath.item])
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            let productVC = ProductViewController()
        guard let selectedImage = UIImage(named: productName[indexPath.row]) else { return }
        let viewModel = ProductViewController.ProductViewModel(selectedImage: selectedImage,caption: productName[indexPath.row],explorationDate: productExplorationDate[indexPath.row])

           productVC.setModel(viewModel)

           self.navigationController?.pushViewController(productVC, animated: true)// открытие ProductViewController
    }
}

