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

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .FASBackgroundColor
        collectionView.backgroundColor = .FASBackgroundColor

        view.addSubview(collectionView)
        
        let headerLabel = UILabel()
                headerLabel.translatesAutoresizingMaskIntoConstraints = false
                headerLabel.text = "Поиск по категориям"
                headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
                view.addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
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
            let padding: CGFloat = 30
            let collectionViewSize = collectionView.frame.size.width - padding
            let cellSize = collectionViewSize / 2
            return CGSize(width: cellSize, height: cellSize)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 50
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    }
