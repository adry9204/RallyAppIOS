//
//  OrderModels.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
protocol EitherIntOrUser {}
extension Int: EitherIntOrUser {}
extension User: EitherIntOrUser {}

struct Order<T: Decodable>: Decodable {
    let id: Int
    let totalPrice, beforeTaxPrice, taxPrice: String
    let stripePaymentIntent: String?
    let paid: Bool
    let status: String
    let user: T
    let orderDetails: [OrderDetail]
    let address: Address?
    
    enum CodingKeys: CodingKey {
        case id
        case totalPrice
        case beforeTaxPrice
        case taxPrice
        case stripePaymentIntent
        case paid
        case status
        case user
        case orderDetails
        case address
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Order<T>.CodingKeys> = try decoder.container(keyedBy: Order<T>.CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: Order<T>.CodingKeys.id)
        self.totalPrice = try container.decode(String.self, forKey: Order<T>.CodingKeys.totalPrice)
        self.beforeTaxPrice = try container.decode(String.self, forKey: Order<T>.CodingKeys.beforeTaxPrice)
        self.taxPrice = try container.decode(String.self, forKey: Order<T>.CodingKeys.taxPrice)
        self.stripePaymentIntent = try container.decodeIfPresent(String.self, forKey: Order<T>.CodingKeys.stripePaymentIntent)
        self.paid = try container.decode(Bool.self, forKey: Order<T>.CodingKeys.paid)
        self.status = try container.decode(String.self, forKey: Order<T>.CodingKeys.status)
        self.user = try container.decode(T.self, forKey: Order<T>.CodingKeys.user)
        self.orderDetails = try container.decode([OrderDetail].self, forKey: Order<T>.CodingKeys.orderDetails)
        self.address = try container.decodeIfPresent(Address.self, forKey: Order<T>.CodingKeys.address) ?? nil
    }
}

struct OrderDetail: Decodable {
    let id: Int?
    let price: String
    let quantity: Int
    let menu: Menu
}

