import UIKit

final class ProductCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, ReusableCollectionCell {
    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
        static let ownerImageSize: CGFloat = 40.0
        static let ownerImageOverlap: CGFloat = 20.0 
    }
    
    struct ProductCellModel {
        let productImageName: String
        let productOwnerImageName: String?
    }
    
    private let productImageView = UIImageView()
    let productOwnerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.layer.cornerRadius = Constants.cornerRadius
        productImageView.layer.masksToBounds = true
        productImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(productOwnerImageView)
        productOwnerImageView.translatesAutoresizingMaskIntoConstraints = false
        productOwnerImageView.layer.cornerRadius = Constants.ownerImageSize / 2
        productOwnerImageView.layer.masksToBounds = true
        productOwnerImageView.layer.borderColor = UIColor.gray.cgColor
        productOwnerImageView.layer.borderWidth = 2.0
        NSLayoutConstraint.activate([
            productOwnerImageView.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            productOwnerImageView.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Constants.ownerImageOverlap),
            productOwnerImageView.widthAnchor.constraint(equalToConstant: Constants.ownerImageSize),
            productOwnerImageView.heightAnchor.constraint(equalToConstant: Constants.ownerImageSize)
        ])
    }
    
    func setModel(_ viewModel: ProductCellModel) {
        func setModel(_ viewModel: ProductCellModel) {
            productImageView.image = UIImage(named: viewModel.productImageName)
            
            if let ownerImageName = viewModel.productOwnerImageName, !ownerImageName.isEmpty {
                productOwnerImageView.image = UIImage(named: ownerImageName)
                productOwnerImageView.isHidden = false
            } else {
                productOwnerImageView.image = nil
                productOwnerImageView.isHidden = true
            }
        }
        
    }
}

