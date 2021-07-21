//
//  ProfileViewController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    var user : [String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user ?? "A")
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    @IBAction func logoutPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(loginNavController)
    }
}
