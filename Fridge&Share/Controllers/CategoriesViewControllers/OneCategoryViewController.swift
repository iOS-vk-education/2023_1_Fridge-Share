//
//  OneCategoryViewController.swift
//  Fridge&Share
//
//  Created by User on 28.12.2023.
//

import UIKit

let dairyProducts = ["Молоко Домик в деревне 2,5%", "Молоко  Parmalat 3,5%", "Масло 150г"]
let meatFish = ["Форель слабосоленая", "Колбаса Вязанка"]
let bakeryProducts = ["Хлеб ржаной нарезной"]
let beverages = ["Напитки"]
let sauces = ["Соусы"]
let sweets = ["Сладости"]
let fruitsVegetables = ["Помидоры красные", "Огурцы"]
let readyMeals = ["Салат Цезарь", "Пельмени Цезарь",]


final class OneCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var categoryName: String?
    var collectionView: UICollectionView!
    var categoryProducts: [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categoryName

        setupCollectionView()
        setCollectionViewLayout()
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        if let categoryName = categoryName {
                    title = categoryName
                }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .FASBackgroundColor
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell,
                 let product = categoryProducts?[indexPath.row] else {
               fatalError("Unexpectedly failed to dequeue ProductCell or product is nil")
           }
           
           let viewModel = ProductCell.ProductCellModel(
            productImageName: product.image,
            productOwnerImageName: nil
           )
           cell.setModel(viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProducts!.count
    }

    func setCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let padding: CGFloat = 15
        let availableWidth = view.frame.size.width - padding * 4
        let cellWidth = availableWidth / 4
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)

        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding * 3

        layout.sectionInset = UIEdgeInsets(top: padding + 20, left: padding*2, bottom: padding, right: padding*2)

        collectionView.collectionViewLayout = layout
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = ProductViewController()
        
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}

