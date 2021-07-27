//
//  LoginViewModel.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/21.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

class LoginViewModel{
    
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let isLoadingSignIn = BehaviorRelay(value: false)
    
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
    
    func signIn(email: String, password: String) -> Observable<(AuthDataResult?, Error?)> {
        Observable.create { observer in
            self.isLoadingSignIn.accept(true)
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                self.isLoadingSignIn.accept(false)
                observer.onNext((user, error))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
