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
        for _ in viewControllers {
            //set userId in ViewControllers
        }
    }
}
