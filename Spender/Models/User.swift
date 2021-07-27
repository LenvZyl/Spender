//
//  User.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/26.
//

import Foundation

struct User: Decodable {
    let email: String
    let uid: String
    let password: String
}
