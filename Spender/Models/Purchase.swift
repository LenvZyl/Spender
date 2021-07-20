//
//  Purchase.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/20.
//

import Foundation

struct Purchase: Decodable, Encodable {
    let amount: Double
    let date: String
    let description: String
}
