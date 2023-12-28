//
//  CatrgoriesViewController.swift
//  Fridge&Share
//
//  Created by User on 10.12.2023.
//
import UIKit

final class CategoryCell: UICollectionViewCell {
    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
        
    }

    static let identifier = "CategoryCellIdentifier"
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
            print(text)
    }
    
    let categoryNames = [
            "Молочные продукты, яйца",
            "Мясо, рыба",
            "Выпечка",
            "Напитки",
            "Соусы",
            "Сладости",
            "Фрукты, овощи",
            "Готовые блюда"
        ]

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        return collectionView
    }()

    let images: [UIImage] = [
        UIImage(named: "CategoryMilk")!,
        UIImage(named: "CategoryMeat")!,
        UIImage(named: "CategoryBread")!,
        UIImage(named: "CategoryDrinks")!,
        UIImage(named: "CategorySauce")!,
        UIImage(named: "CategorySweet")!,
        UIImage(named: "CategoryVegetables")!,
        UIImage(named: "СategoryReadyfood")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .FASBackgroundColor
        collectionView.backgroundColor = .FASBackgroundColor
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
    // MARK: - UICollectionViewDataSource

    extension CategoriesViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.imageView.image = images[indexPath.item]
            return cell
        }
    // MARK: - UICollectionViewDelegateFlowLayout

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 40
            let collectionViewSize = collectionView.frame.size.width - padding
            let cellSize = collectionViewSize / 2
            return CGSize(width: cellSize, height: cellSize)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 40
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    }
extension CategoriesViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oneCategoryVC = OneCategoryViewController()
        
        let selectedCategory = categoryNames[indexPath.row]
        oneCategoryVC.categoryName = selectedCategory

        oneCategoryVC.categoryProducts = self.productsForCategory(categoryName: selectedCategory)
        
        navigationController?.pushViewController(oneCategoryVC, animated: true)
    }

    private func productsForCategory(categoryName: String) -> [Product]? {
        switch categoryName {
        case "Молочные продукты, яйца":
            return listOfProducts.filter { $0.name.contains("Масло") || $0.name.contains("Молоко") || $0.name.contains("Яйца")}
        case "Мясо, рыба":
            return listOfProducts.filter { $0.name.contains("Рыба") || $0.name.contains("Колбаса") || $0.name.contains("Курица") || $0.name.contains("Говядина") || $0.name.contains("Баранина") || $0.name.contains("Индейка") || $0.name.contains("Свинина")}
        case "Выпечка":
            return listOfProducts.filter { $0.name.contains("Хлеб") }
        case "Напитки":
            return listOfProducts.filter { $0.name.contains("Вода") || $0.name.contains("Сок") || $0.name.contains("Газировка")}
        case "Соусы":
            return listOfProducts.filter { $0.name.contains("Соус") || $0.name.contains("Майонез") || $0.name.contains("Кетчуп") || $0.name.contains("Сметана")}
        case "Сладости":
            return listOfProducts.filter {$0.name.contains("Конфеты") }
        case "Фрукты, овощи":
            return listOfProducts.filter { $0.name.contains("Помидоры") || $0.name.contains("Огурцы")}
        case "Готовые блюда":
            return listOfProducts.filter { $0.name.contains("Салат") || $0.name.contains("Пельмени")}
        default:
            return nil
        }
    }
}

