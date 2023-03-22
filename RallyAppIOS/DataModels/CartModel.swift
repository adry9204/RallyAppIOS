//
//  CartModel.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

struct CartModel: Decodable {
    let id, quantity: Int
    let price: String
    let user: User
    let menu: Menu
}
