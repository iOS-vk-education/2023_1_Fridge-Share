//
//  floor.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 12.11.2023.
//

import UIKit

final class DormitoryViewController: UIViewController, UITableViewDelegate {
    private enum Constants {
        static let title = "Dormitory"
        static let tableViewCornerRadius: CGFloat = 16
    }
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        
        view.backgroundColor = .FASBackgroundColor
        
        setTableView()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension DormitoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Floor \(indexPath.row)"
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = OneFloorController()
        navigationController?.pushViewController(destination, animated: true)
        destination.title = "Frige \(indexPath.row)"
    }
}
