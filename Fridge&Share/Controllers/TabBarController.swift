//
//  TabBarController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 12.11.2023.
//

import UIKit

final class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let floorViewController = FloorViewController()
        let floorTabBarItem = UITabBarItem()
        floorTabBarItem.title = "Dormitory"
        floorTabBarItem.image = UIImage(systemName: "house")
        floorViewController.tabBarItem = floorTabBarItem
        
        let vc1 = UINavigationController(rootViewController: floorViewController)

        
        viewControllers = [vc1]
        
    }
}
