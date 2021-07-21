//
//  LoginViewModel.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool>{
        Observable.combineLatest(
            emailSubject.asObserver().startWith(""),
            passwordSubject.asObserver().startWith("")).map { email, password in
                if(email.isEmpty || password.isEmpty){
                    return false
                }
                return true
        }.startWith(false)
    }
    
}
