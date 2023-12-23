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
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let addButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FASBackgroundColor
        
        addButton.setTitle("Добавить продукт", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 8
        addButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
            print("blinb(")
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
