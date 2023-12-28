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

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        let vc = searchController.searchResultsController as? ResultViewController
        
        // Очистка массива перед добавлением новых результатов
        vc?.resultProducts.removeAll()
        
        listOfProducts.forEach { (product) in
            if product.name.contains(text) {
                vc?.resultProducts.append(product)
            }
        }
        vc?.tableView.reloadData()
    }
    
    var progressView: UIProgressView?
    
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
        UIImage(named: "CategoruMeat")!,
        UIImage(named: "CategoryBread")!,
        UIImage(named: "CategoryDrinks")!,
        UIImage(named: "CategorySauce")!,
        UIImage(named: "CategorySweet")!,
        UIImage(named: "CategoryVegetables")!,
        UIImage(named: "СategoryReadyfood")!
    ]
    
    let searchController = UISearchController(searchResultsController: ResultViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let search = UISearchController(searchResultsController: ResultViewController())
        //        search.searchResultsUpdater = self
        //        search.obscuresBackgroundDuringPresentation = false
        //        search.searchBar.placeholder = "Type something here to search"
        //        navigationItem.searchController = search
        searchController.searchResultsUpdater = self
        navigationItem.searchController?.delegate = self
        definesPresentationContext = true
//        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController = searchController
        
//        progressView = UIProgressView(progressViewStyle: .bar)
//        progressView?.frame = CGRect(x: 10, y: navigationItem.searchController!.searchBar.frame.height, width: 20, height: 20)
//        navigationItem.searchController?.searchBar.addSubview(progressView!)
        
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
    
    var serial_search = DispatchQueue(label: "ser_search")
    
    var cancel = false
    var inProgress = false
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //when search text is changed, we cancel an ongoing search loop
        if inProgress {
            self.cancel = true
        }
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

