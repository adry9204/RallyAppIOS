//
//  OrderModels.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

struct Order: Decodable {
    let id: Int
    let totalPrice, beforeTaxPrice, taxPrice, stripePaymentIntent: String
    let paid: Bool
    let status: String
    let user: User
    let orderDetails: [OrderDetail]
}

struct OrderDetail: Decodable {
    let id: Int
    let price: String
    let quantity: Int
    let menu: Menu
}

