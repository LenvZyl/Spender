//
//  RegisterViewController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/27.
//
import Foundation
import UIKit
import RxCocoa
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private let registerViewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        emailTextField.placeholder = "Email"
        emailTextField.returnKeyType = .next
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Password"
        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true
        passwordConfirmTextField.delegate = self
        passwordConfirmTextField.placeholder = "Confirm Password"
        passwordConfirmTextField.returnKeyType = .done
        passwordConfirmTextField.isSecureTextEntry = true
        registerButton.layer.cornerRadius = 5
        
        emailTextField.rx.text.map { $0 ?? ""}.bind(to: registerViewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: registerViewModel.passwordSubject).disposed(by: disposeBag)
        passwordConfirmTextField.rx.text.map { $0 ?? ""}.bind(to: registerViewModel.passwordConfirmSubject).disposed(by: disposeBag)
        registerViewModel.isValid().bind(to: registerButton.rx.isEnabled).disposed(by: disposeBag)
        registerViewModel.isValid().map { $0 ? 1 : 0.2}.bind(to: registerButton.rx.alpha).disposed(by: disposeBag)
        registerViewModel.isLoadingRegister.bind(to: registerButton.rx.isHidden).disposed(by: disposeBag)
//        registerViewModel.isLoadingSignIn.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
//        registerViewModel.isLoadingSignIn.map(!).bind(to: activityIndicator.rx.isHidden).disposed(by: disposeBag)
        
    }
    @IBAction func registerPressed(_ sender: Any) {
        self.registerViewModel.register(email: emailTextField.text!, password: passwordTextField.text!).bind(onNext: { [weak self] auth, err in
            guard let strongSelf = self else {
                return
            }
            guard err == nil else {
                let alert = UIAlertController(title:"Registration failed", message: err?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in}))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            passwordConfirmTextField.becomeFirstResponder()
        } else if textField == passwordConfirmTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
