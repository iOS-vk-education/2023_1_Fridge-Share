//
//  FridgeViewController.swift
//  Fridge&Share
//
//  Created by User on 23.11.2023.
//

import UIKit

final class FridgeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let products = ["product1", "product2", "product3", "product4", "product5", "product6", "product7", "product8", "product9", "product10", "product11", "product12", "product13", "product14", "product15", "product16", "product17"]
    
    let productName = ["Печенье овсяное с шоколадом", "Помидоры", "Огурцы", "Молоко", "Яйца", "Яблочный пирог","Бананы","Вода","Клубника","Яблочный пирог","Ананас","Пицца","Вишневый пирог","Сыр", "Творог", "Куриное филе", "Название продукта"]
    let productExplorationDate = ["13.12.23", "03.12.23", "05.12.23", "30.11.23", "07.01.24", "06.12.23", "30.11.23", "12.11.24", "03.12.23", "05.12.23", "07.01.24", "03.12.23", "05.12.23", "03.12.23", "30.11.23", "13.12.23", "дд.мм.гг"]
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
        collectionView.register(for: ProductCell.self)
        view.backgroundColor = .FASBackgroundColor
        collectionView.backgroundColor = .FASBackgroundColor
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reusableIdentifier, for: indexPath) as? ProductCell
        else {
            return UICollectionViewCell()
            
        }
        if indexPath.item != listOfProducts.count {
            cell.productImageView.image = UIImage(named: listOfProducts[indexPath.item].image)
        } else {
            cell.productImageView.image = UIImage(named: "product17")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfProducts.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            let productVC = ProductViewController()
            productVC.selectedImage = UIImage(named: products[indexPath.row]) // передача выбранной картинки в ProductViewController
            productVC.caption = productName[indexPath.row] // передача подписи к картинке в ProductViewController
            productVC.explorationDate = productExplorationDate[indexPath.row]
            self.navigationController?.pushViewController(productVC, animated: true) // открытие ProductViewController
    }
    
class ProductCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
   let productImageView = UIImageView(frame: .zero)
   override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productImageView.layer.cornerRadius = 20
        productImageView.layer.masksToBounds = true
        productImageView.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
}

extension FridgeViewController: ProductViewControllerDelegate {
    func reloadDataForCollection() {
        collectionView.reloadData()
    }
}
