//
//  MainTabBarController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/21.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    var user: [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        guard let viewControllers = viewControllers else {return}
        for vc in viewControllers {
            if let homeNavigationController = vc as? HomeNavigationController {
                if let home = homeNavigationController.viewControllers.first as? HomeViewController {
                    home.user = user
                }
            }
            if let profileNavigationController = vc as? ProfileNavigationController {
                if let profile = profileNavigationController.viewControllers.first as? ProfileViewController {
                    profile.user = user
                }
            }
        }
    }
}
