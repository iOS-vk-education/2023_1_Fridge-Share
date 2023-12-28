//
//  ResultSearchViewController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 28.12.2023.
//

import UIKit

final class ResultViewController: UITableViewController {
    var resultProducts = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FASBackgroundColor
        tableView.isUserInteractionEnabled = true
        self.tableView.register(ResultTableCell.self, forCellReuseIdentifier: "\(ResultTableCell.self)")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ResultTableCell.self)", for: indexPath) as? ResultTableCell else {
            return UITableViewCell()
        }
        cell.name.text = self.resultProducts[indexPath.row].name
        cell.image.image = UIImage(named:self.resultProducts[indexPath.row].image)
        cell.date.text = self.resultProducts[indexPath.row].explorationDate
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = resultProducts[indexPath.row]
        let viewModel = ProductViewController.ProductViewModel(selectedImage: UIImage(named: product.image) ?? UIImage(),
                                                               caption: product.name,
                                                               explorationDate: product.explorationDate)
        
        let productViewController = ProductViewController()
        productViewController.setModel(viewModel)
        productViewController.configure(id: product.id ?? "")
        present(productViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
