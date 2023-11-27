//
//  FridgeViewController.swift
//  Fridge&Share
//
//  Created by User on 23.11.2023.
//

import UIKit

final class FridgeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let products = ["product1", "product2", "product3", "product4", "product5", "product6", "product7", "product8", "product9", "product10", "product11", "product12", "product13", "product14", "product15", "product16", "product17"]
    
    let productName = ["Печенье овсяное с шоколадом", "Помидоры", "Огурцы", "Молоко", "Яйца", "Яблочный пирог","Бананы","Вода","Клубника","Яблочный пирог","Ананас","Пицца","Вишневый пирог","Сыр", "Творог", "Куриное филе", "Название продукта"]
    let productExplorationDate = ["13.12.23", "03.12.23", "05.12.23", "30.11.23", "07.01.24", "06.12.23", "30.11.23", "12.11.24", "03.12.23", "05.12.23", "07.01.24", "03.12.23", "05.12.23", "03.12.23", "30.11.23", "13.12.23", "дд.мм.гг"]
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        setCollectionView()
    }
    
    func setCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

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
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 15
        return CGSize(width: width, height: width)
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
