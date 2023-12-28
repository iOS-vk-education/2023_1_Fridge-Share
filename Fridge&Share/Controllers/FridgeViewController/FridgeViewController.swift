//
//  FridgeViewController.swift
//  Fridge&Share
//
//  Created by User on 23.11.2023.
//

import UIKit

var listOfProducts : [Product] = [
]


final class FridgeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let products = [ "bread", "cucumber", "dumplings", "fish", "butter", "meat", "milk", "salad", "tomato", "milk2"]
    
    let productName = [ "Хлеб ржаной нарезной", "Огурцы", "Пельмени Цезарь", "Рыба Форель слабосоленая", "Масло 150г", "Колбаса Вязанка", "Молоко Домик в деревне 2,5%", "Салат Цезарь", "Помидоры красные", "Молоко  Parmalat 3,5%"]
    let productExplorationDate = ["26.12.23", "28.12.23", "05.02.24", "30.12.23", "07.01.24", "28.12.23", "30.12.23", "29.12.23", "07.01.24", "03.02.24"]
    let productOwner = ["ava1", "ava2", "ava3", "ava4"]
    var collectionView: UICollectionView!
    var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FireBase.shared.getAllData()
        setupSearchButton()
        setCollectionView()
        setCollectionViewLayout()
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        print(listOfRequests)
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.register(for: ProductCell.self)
        view.backgroundColor = .FASBackgroundColor
        collectionView.backgroundColor = .FASBackgroundColor
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let productImageName = listOfProducts[indexPath.row].image
        let productOwnerImageName = productOwner[indexPath.row % productOwner.count]
        let viewModel = ProductCell.ProductCellModel(productImageName: productImageName, productOwnerImageName: productOwnerImageName)
        cell.setModel(viewModel)
        
        cell.productOwnerImageView.isHidden = indexPath.row == 0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfProducts.count
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
        guard let selectedImage = UIImage(named: listOfProducts[indexPath.row].image) else { return }
        let productNameString = listOfProducts[indexPath.row].name
        let productDate = listOfProducts[indexPath.row].explorationDate
        let viewModel = ProductViewController.ProductViewModel(selectedImage: selectedImage, caption: productNameString, explorationDate: productDate)
        productVC.setModel(viewModel)
        productVC.configure(id: listOfProducts[indexPath.row].id ?? "")
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}



