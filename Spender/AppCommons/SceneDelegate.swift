//
//  SceneDelegate.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var user: [String: String]?
//        = [
//        "userName": "Lenx",
//        "password": "0848248850",
//        "id": "1"
//    ]


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if(user != nil){
            let customTabBar = storyboard.instantiateViewController(identifier: "MainTabBar") as! MainTabBarController
            customTabBar.user = user
            window?.rootViewController = customTabBar
            window?.makeKeyAndVisible()
        }else{
            let loginNC = storyboard.instantiateViewController(identifier: "LoginNavigationController")
            window?.rootViewController = loginNC
            window?.makeKeyAndVisible()
        }
    }
    
    func setRootViewController(_ vc: UIViewController, _ user: [String: String]? = nil) {
        if let window = self.window {
            if let mainTabBar = vc as? MainTabBarController {
                mainTabBar.user = user
            }
            window.rootViewController = vc
            UIView.transition(with: window,
                                    duration: 0.8,
                                    options: .curveEaseIn,
                                    animations: nil)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

