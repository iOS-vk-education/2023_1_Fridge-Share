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
        static let iconPerson = "person"
        static let iconGlass = "magnifyingglass"
        static let titleDormitory = "Общежитие"
        static let titleProfile = "Профиль"
        static let titleSearch = "Поиск"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        let dormitoryViewController = DormitoryViewController()
        let dormitoryTabBarItem = UITabBarItem()
        dormitoryTabBarItem.image = UIImage(systemName: Constants.iconHouse)
        dormitoryTabBarItem.title = Constants.titleDormitory
        dormitoryViewController.tabBarItem = dormitoryTabBarItem
        
        let categoriesViewController = CategoriesViewController()
        let categoriesTabBarItem = UITabBarItem()
        categoriesTabBarItem.image = UIImage(systemName: Constants.iconGlass)
        categoriesTabBarItem.title = Constants.titleSearch
        categoriesViewController.tabBarItem = categoriesTabBarItem
        
        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem()
        profileTabBarItem.image = UIImage(systemName: Constants.iconPerson)
        profileTabBarItem.title = Constants.titleProfile
        profileViewController.tabBarItem = profileTabBarItem
        
        let vc1 = UINavigationController(rootViewController: dormitoryViewController)
        let vc2 = UINavigationController(rootViewController: categoriesViewController)
        let vc3 = UINavigationController(rootViewController: profileViewController)
        
        viewControllers = [vc1, vc2, vc3]
        
    }
}


extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let vc = viewController as? UINavigationController
        vc?.popToRootViewController(animated: true)
          return true
    }
}
