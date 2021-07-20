//
//  PurchaseViewModel.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import Foundation
import RxCocoa
import RxSwift


struct PurchaseViewModel {
    let purchase: Purchase
    init(_ purchase: Purchase) {
        self.purchase = purchase
    }
}

extension PurchaseViewModel {
    var description: Observable<String> {
        return Observable<String>.just(purchase.description)
    }
    var amount: Observable<String> {
        return Observable<String>.just(String(purchase.amount))
    }
    var date: Observable<String> {
        return Observable<String>.just(purchase.date)
    }
}
