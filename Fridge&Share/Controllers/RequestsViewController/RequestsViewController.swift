//
//  RequestsViewController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 23.12.2023.
//

import UIKit

var listOfRequests: [RequestItem] = []
var listOfAnswers: [AnswerItem] = [] {
    didSet {
        print(listOfAnswers)
    }
}

final class RequestsViewController: UIViewController {
    private enum Constants {
        static let myRequestsLabel = "Мои запросы"
        static let myAnswersLabel = "Мои ответы"
        static let tableViewCornerRadius: CGFloat = 16
        static let requestTableTag = 101
        static let answerTableTag = 102
    }
    
    private let devider = UIView()
    private let requestsLabel = UILabel()
    private let answersLabel = UILabel()
    
    private let requestTableView = UITableView()
     let answerTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FASBackgroundColor
        
        setupUI()
        
        view.addSubview(devider)
        view.addSubview(requestsLabel)
        view.addSubview(answersLabel)
        view.addSubview(requestTableView)
        view.addSubview(answerTableView)
        
        setupConstraints()
    }
    
    private func setupUI() {
        requestsLabel.text = Constants.myRequestsLabel
        requestsLabel.textColor = .black
        requestsLabel.font = UIFont(name: "normal", size: 20)
        requestsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        answersLabel.text = Constants.myAnswersLabel
        answersLabel.textColor = .black
        answersLabel.font = UIFont(name: "normal", size: 20)
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        requestTableView.layer.cornerRadius = Constants.tableViewCornerRadius
        requestTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        requestTableView.isScrollEnabled = true
        requestTableView.backgroundColor = .FASBackgroundColor
        requestTableView.translatesAutoresizingMaskIntoConstraints = false
        requestTableView.register(RequestCell.self, forCellReuseIdentifier: "\(RequestCell.self)")
        requestTableView.dataSource = self
        requestTableView.delegate = self
        requestTableView.tag = Constants.requestTableTag
        requestTableView.rowHeight = UITableView.automaticDimension
        
        answerTableView.layer.cornerRadius = Constants.tableViewCornerRadius
        answerTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        answerTableView.isScrollEnabled = true
        answerTableView.backgroundColor = .FASBackgroundColor
        answerTableView.translatesAutoresizingMaskIntoConstraints = false
        answerTableView.register(AnswerCell.self, forCellReuseIdentifier: "\(AnswerCell.self)")
        answerTableView.dataSource = self
        answerTableView.delegate = self
        answerTableView.tag = Constants.answerTableTag
        answerTableView.rowHeight = UITableView.automaticDimension

        devider.backgroundColor = .systemGray
        devider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            devider.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale),
            devider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            devider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            devider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            requestsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            answersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answersLabel.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 20),
            
            requestTableView.topAnchor.constraint(equalTo: requestsLabel.bottomAnchor, constant: 20),
            requestTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            requestTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            requestTableView.bottomAnchor.constraint(equalTo: devider.topAnchor, constant: -20),
            
            answerTableView.topAnchor.constraint(equalTo: answersLabel.bottomAnchor, constant: 20),
            answerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            answerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            answerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}


extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == Constants.requestTableTag {
            return listOfRequests.count
        } else {
            let filteredListOfAnswers = listOfAnswers.filter { item in
                return item.answer == .noanswer
            }
            return filteredListOfAnswers.count
            return listOfAnswers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == Constants.requestTableTag {
            guard let requestCell = tableView.dequeueReusableCell(withIdentifier: "\(RequestCell.self)", for: indexPath) as? RequestCell else {
                return UITableViewCell()
            }
            requestCell.name.text = listOfRequests[indexPath.section].product.name
            requestCell.image.image = UIImage(named: listOfRequests[indexPath.section].product.image)
            requestCell.date.text = listOfRequests[indexPath.section].product.explorationDate
            
            if listOfRequests[indexPath.section].result == true {
                requestCell.backgroundColor = .lightGreen
            } else {
                requestCell.backgroundColor = .lightRed
            }
            
            return requestCell
        } else {
            
            
            let filteredListOfAnswers = listOfAnswers.filter { item in
                return item.answer == .noanswer
            }

            guard let answerCell = tableView.dequeueReusableCell(withIdentifier: "\(AnswerCell.self)", for: indexPath) as? AnswerCell else {
                return UITableViewCell()
            }
            
            answerCell.name.text = filteredListOfAnswers[indexPath.section].product.name
            answerCell.image.image = UIImage(named: filteredListOfAnswers[indexPath.section].product.image)
            answerCell.date.text = filteredListOfAnswers[indexPath.section].product.explorationDate
            answerCell.configureCell(id: filteredListOfAnswers[indexPath.section].id ?? "", delegate: self)
            
            return answerCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            let item = listOfRequests[indexPath.section]
            FireBase.shared.deleteRequest(documentId: item.id ?? "0")
            listOfRequests.removeAll()
            FireBase.shared.getAllRequests { listOfRequests in
                
            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        item.image = UIImage(systemName: "trash.fill")
        item.backgroundColor = .systemRed
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
        return swipeActions
    }

}


extension RequestsViewController: AnswerViewControllerDelegate {
    func reloadDataForTable() {
        
        self.answerTableView.reloadData()
    }
}
//extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView.tag == Constants.requestTableTag {
//            guard let requestCell = tableView.dequeueReusableCell(withIdentifier: "\(RequestCell.self)", for: indexPath) as? RequestCell else {
//                return UITableViewCell()
//            }
//            requestCell.name.text = listOfProducts[indexPath.row].name
//            requestCell.image.image = UIImage(named: listOfProducts[indexPath.row].image)
//            requestCell.date.text = listOfProducts[indexPath.row].explorationDate
//            requestCell.backgroundColor = .FASBackgroundColor
//            if indexPath.row % 2 != 0 {
//                requestCell.contentView.backgroundColor = .lightGreen
//            } else {
//                requestCell.contentView.backgroundColor = .lightRed
//            }
//
//            return requestCell
//        } else {
//            guard let answerCell = tableView.dequeueReusableCell(withIdentifier: "\(AnswerCell.self)", for: indexPath) as? AnswerCell else {
//                return UITableViewCell()
//            }
//            answerCell.name.text = listOfProducts[indexPath.row].name
//            answerCell.image.image = UIImage(named: listOfProducts[indexPath.row].image)
//            answerCell.date.text = listOfProducts[indexPath.row].explorationDate
//            answerCell.backgroundColor = .FASBackgroundColor
//            return answerCell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        // Создаем футер
//        let footerView = UIView()
//        footerView.backgroundColor = .FASBackgroundColor
//        return footerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return Constants.cellMargin
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? 0 : Constants.cellMargin
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//}
