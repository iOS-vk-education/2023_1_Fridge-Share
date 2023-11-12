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
        
        let vc1 = UINavigationController(rootViewController: FloorViewController())

        
        viewControllers = [vc1]
        
    }
}
