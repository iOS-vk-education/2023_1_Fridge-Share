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
        static let titleDormitory = "Dormitory"
        static let titleProfile = "Profile"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        
        let dormitoryViewController = DormitoryViewController()
        let dormitoryTabBarItem = UITabBarItem()
        dormitoryTabBarItem.image = UIImage(systemName: Constants.iconHouse)
        dormitoryTabBarItem.title = Constants.titleDormitory
        
        dormitoryViewController.tabBarItem = dormitoryTabBarItem
        
        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem()
        profileTabBarItem.image = UIImage(systemName: Constants.iconPerson)
        profileTabBarItem.title = Constants.titleProfile
        profileViewController.tabBarItem = profileTabBarItem
        
        let vc1 = UINavigationController(rootViewController: dormitoryViewController)
        let vc2 = UINavigationController(rootViewController: profileViewController)
        
        viewControllers = [vc1, vc2]
        
    }
}


// попытка при нажатии на домик возвращаться именно к общаге и экрану этажей
extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == Constants.titleDormitory {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
