//
//  PurchaseViewController.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PurchaseViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: LoadingButton!
    
    
    private let purchaseCreateViewModel = PurchaseCreateViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextField.delegate = self
        descriptionTextField.placeholder = "Description"
        descriptionTextField.returnKeyType = .next
        amountTextField.delegate = self
        amountTextField.placeholder = "Amount"
        amountTextField.returnKeyType = .done
        amountTextField.keyboardType = .numbersAndPunctuation
        saveButton.layer.cornerRadius = 5
        
        descriptionTextField.rx.text.map { $0 ?? ""}.bind(to: purchaseCreateViewModel.descriptionSubject).disposed(by: disposeBag)
        amountTextField.rx.text.map { $0 ?? ""}.bind(to: purchaseCreateViewModel.amountSubject).disposed(by: disposeBag)
        datePicker.rx.date.map { "\($0)"}.bind(to: purchaseCreateViewModel.dateStringSubject).disposed(by: disposeBag)
        purchaseCreateViewModel.isValid().bind(to: saveButton.rx.isEnabled).disposed(by: disposeBag)
        purchaseCreateViewModel.isValid().map { $0 ? 1 : 0.2}.bind(to: saveButton.rx.alpha).disposed(by: disposeBag)        
    }
    @IBAction func dateChanged(_ sender: Any) {
    }
    @IBAction func savePressed(_ sender: Any) {
        saveButton.loadIndicator(true)
        purchaseCreateViewModel.savePurchase()
        saveButton.loadIndicator(false)
    }
}


extension PurchaseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == descriptionTextField {
            textField.resignFirstResponder()
            amountTextField.becomeFirstResponder()
        } else if textField == amountTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

