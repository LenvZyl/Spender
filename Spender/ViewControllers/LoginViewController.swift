//
//  LoginViewController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    var user: [String: String]? = [
        "userName": "Lenx",
        "password": "0848248850",
        "id": "1"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBar") as! MainTabBarController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainTabBarController, user ?? nil)
    }
}
