import UIKit

final class RequestCell: UITableViewCell {
    private enum Constants {
        static let imageCornerRadius: CGFloat = 10
        static let nameLabelNumberOfLines = 3
        static let cellPadding: CGFloat = 8
    }
    var name = UILabel()
    var image = UIImageView(frame: .zero)
    var date = UILabel()
    
    let stack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
        
        contentView.addSubview(image)
        contentView.addSubview(stack)
        
        setupConstraints()
        
    }
    
    private func setupUI() {
        image.layer.cornerRadius = Constants.imageCornerRadius
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        name.textColor = .black
        name.font = UIFont(name: "normal", size: 17)
        name.numberOfLines = Constants.nameLabelNumberOfLines
        name.translatesAutoresizingMaskIntoConstraints = false
        
        date.textColor = .lightGray
        date.font = UIFont.boldSystemFont(ofSize: 13)
        date.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.layer.cornerRadius = Constants.imageCornerRadius
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(date)
        contentView.layer.cornerRadius = Constants.imageCornerRadius
        contentView.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
