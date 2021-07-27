//
//  LoginViewController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    var user: [String: String]? = [
        "userName": "Lenx",
        "password": "0848248850",
        "id": "1"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        emailTextField.placeholder = "Email"
        emailTextField.returnKeyType = .next
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Password"
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 5
        
        emailTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordSubject).disposed(by: disposeBag)
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.2}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
        loginViewModel.isLoadingSignIn.bind(to: loginButton.rx.isHidden).disposed(by: disposeBag)
        loginViewModel.isLoadingSignIn.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        loginViewModel.isLoadingSignIn.map(!).bind(to: activityIndicator.rx.isHidden).disposed(by: disposeBag)
        
    }
    @IBAction func loginPressed(_ sender: Any) {
        self.loginViewModel.signIn(email: emailTextField.text!, password: passwordTextField.text!).bind(onNext: { [weak self] auth, err in
            guard let strongSelf = self else {
                return
            }
            guard err == nil else {
                let alert = UIAlertController(title:"Invalid Login", message: err?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in}))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBar") as! MainTabBarController
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainTabBarController, self?.user ?? nil)
        }).disposed(by: disposeBag)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
