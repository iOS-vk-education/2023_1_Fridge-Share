//
//  TabBarController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 12.11.2023.
//

import UIKit

final class TabBarController : UITabBarController {
    private enum Constants {
        static let iconHouse = "house"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dormitoryViewController = DormitoryViewController()
        let dormitoryTabBarItem = UITabBarItem()
        dormitoryTabBarItem.image = UIImage(systemName: Constants.iconHouse)
        dormitoryViewController.tabBarItem = dormitoryTabBarItem
        
        
        let vc1 = UINavigationController(rootViewController: dormitoryViewController)

        
        viewControllers = [vc1]
        
    }
}
