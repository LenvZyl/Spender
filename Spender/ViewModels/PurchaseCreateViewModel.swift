//
//  PurchaseCreateViewModel.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import Foundation
import RxSwift
import RxCocoa

class PurchaseCreateViewModel{
    
    let descriptionSubject = PublishSubject<String>()
    let amountSubject = PublishSubject<String>()
    let dateStringSubject = PublishSubject<String>()
    var purchase: Purchase?
    
    func isValid() -> Observable<Bool>{
        Observable.combineLatest(
            descriptionSubject.asObserver().startWith(""),
            amountSubject.asObserver().startWith(""),
            dateStringSubject.asObserver().startWith("")).map { description, amount, date in
                if(description.isEmpty || amount.isEmpty || date.isEmpty || Double(amount) == nil){
                    return false
                }
                self.purchase = Purchase(amount: Double(amount) ?? 0.0, date: date, description: description)
                return true
        }.startWith(false)
    }

    func savePurchase(){
        do {
            let purchaseData = try JSONEncoder().encode(purchase)
            let str = String(decoding: purchaseData, as: UTF8.self)
            print(str)
        } catch  {
            print("No purchase Created")
        }
    }
}
