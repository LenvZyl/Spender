//
//  RegisterViewModel.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/27.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

class RegisterViewModel{
    
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let passwordConfirmSubject = PublishSubject<String>()
    let isLoadingRegister = BehaviorRelay(value: false)
    
    func isValid() -> Observable<Bool>{
        Observable.combineLatest(
            emailSubject.asObserver().startWith(""),
            passwordSubject.asObserver().startWith(""),
            passwordConfirmSubject.asObserver().startWith("")).map { email, password, passwordConfirm in
                if(email.isEmpty || password.isEmpty || passwordConfirm.isEmpty){
                    return false
                }
                if(password != passwordConfirm){
                    return false
                }
                return true
        }.startWith(false)
    }
    
    func register(email: String, password: String) -> Observable<(AuthDataResult?, Error?)> {
        Observable.create { observer in
            self.isLoadingRegister.accept(true)
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                self.isLoadingRegister.accept(false)
                observer.onNext((user, error))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

