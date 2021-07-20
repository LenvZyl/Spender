//
//  PurchaseListViewModel.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//


import Foundation
import RxCocoa
import RxSwift

struct PurchaseListViewModel {
    let purchaseViewModel: [PurchaseViewModel]
}

extension PurchaseListViewModel {
    init(_ purchases: [Purchase]) {
        self.purchaseViewModel = purchases.compactMap(PurchaseViewModel.init)
    }
}

extension PurchaseListViewModel {
    func purchaseAt(_ index: Int) -> PurchaseViewModel {
        return self.purchaseViewModel[index]
    }
    func purchaseCount() -> Int {
        return self.purchaseViewModel.count
    }
}

