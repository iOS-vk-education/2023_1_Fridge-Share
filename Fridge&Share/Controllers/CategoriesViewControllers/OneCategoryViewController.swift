import UIKit

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("Unexpectedly failed to dequeue ProductCell")
        }
        
        let product = categoryProducts![indexPath.item]
        let viewModel = ProductCell.ProductCellModel(
            productImageName: product.image,
            productOwnerImageName: nil
        )
        
        cell.setModel(viewModel)

        cell.productOwnerImageView.isHidden = false
        
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
        layout.minimumLineSpacing = padding * 4

        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

        collectionView.collectionViewLayout = layout
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = ProductViewController()
        //guard let selectedImage = UIImage(named: products[indexPath.row]) else { return }
        //let productNameString = productName[indexPath.row]
        //let productDate = productExplorationDate[indexPath.row]
       // let viewModel = ProductViewController.ProductViewModel(selectedImage: selectedImage, caption: productNameString, explorationDate: productDate)
        //productVC.setModel(viewModel)
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}
