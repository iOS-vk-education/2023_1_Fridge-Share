//
//  floor.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 12.11.2023.
//

//import UIKit
//
//final class DormitoryViewController: UIViewController, UITableViewDelegate {
//    private enum Constants {
//        static let title = "Общежитие"
//        static let tableViewCornerRadius: CGFloat = 16
//    }
//    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = Constants.title
//
//        view.backgroundColor = .FASBackgroundColor
//
//        setTableView()
//
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func setTableView() {
//        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
//        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        tableView.isScrollEnabled = true
//        tableView.backgroundColor = .FASBackgroundColor
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.rowHeight = UITableView.automaticDimension
//    }
//
//}
//
//extension DormitoryViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 25
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.textLabel?.text = "Этаж \(indexPath.row + 1)"
//
//        return cell
//    }
//
//    // MARK: - Table view delegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destination = OneFloorController()
//        navigationController?.pushViewController(destination, animated: true)
//        destination.title = "Этаж \(indexPath.row + 1)"
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}


import UIKit

final class DormitoryViewController: UIViewController {
    private enum Constants {
        static let title = "Общежитие"
        static let cellIdentifier = "cell"
        static let cellHeight: CGFloat = 70
        static let cellCornerRadius: CGFloat = 15
        static let cellMargin: CGFloat = 10
        static let cellPadding: CGFloat = 8
    }

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        view.backgroundColor = .FASBackgroundColor
        
        setTableView()
        layoutTableView()
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.cellMargin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.cellMargin),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setTableView() {
        tableView.backgroundColor = .FASBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.cellHeight
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Constants.cellPadding, bottom: 0, right: Constants.cellPadding)
        tableView.layer.cornerRadius = Constants.cellCornerRadius
        tableView.clipsToBounds = true
    }
}

// MARK: - UITableViewDataSource
extension DormitoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Этаж \(indexPath.row + 1)"
        cell.backgroundColor = .clear
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = Constants.cellCornerRadius
        cell.backgroundView = backgroundView
        
        // Для сохранения эффекта нажатия
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        selectedBackgroundView.layer.cornerRadius = Constants.cellCornerRadius
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DormitoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = OneFloorController()
        navigationController?.pushViewController(destination, animated: true)
        destination.title = "Этаж \(indexPath.row + 1)"
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
