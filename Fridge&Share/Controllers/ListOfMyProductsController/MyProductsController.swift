//
//  MyProductsController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 23.12.2023.
//

import UIKit



final class ListOfMyProductsController: UIViewController {
    private enum Constants {
        static let tableViewCornerRadius: CGFloat = 16
        static let reusableIdentifier = "OneProductCell"
        static let buttonCornerRadius: CGFloat = 8
        static let edgeInsets: CGFloat = 10
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let addButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FASBackgroundColor
        
        addButton.setTitle("Добавить продукт", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = Constants.buttonCornerRadius
        addButton.titleEdgeInsets = UIEdgeInsets(top: Constants.edgeInsets,
                                                 left: Constants.edgeInsets,
                                                 bottom: Constants.edgeInsets,
                                                 right: Constants.edgeInsets)
        addButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        setTableView()
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 189),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 37),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureButton() {
            addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        }

        @objc private func addButtonTapped() {
//            let emptyProductViewController = EmptyProductViewController()
//            navigationController?.pushViewController(emptyProductViewController, animated: true)
        }
    
    private func setTableView() {
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .FASBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OneProductCell.self, forCellReuseIdentifier: "\(OneProductCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func searchButtonTapped() {
        let newProductVC = AddProducrViewController()
        self.navigationController?.pushViewController(newProductVC, animated: true)
    }
}


extension ListOfMyProductsController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OneProductCell.self)", for: indexPath) as? OneProductCell else {
            return UITableViewCell()
        }
        
        cell.name.text = listOfProducts[indexPath.row].name
        cell.image.image = UIImage(named: listOfProducts[indexPath.row].image)
        cell.date.text = listOfProducts[indexPath.row].explorationDate

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
