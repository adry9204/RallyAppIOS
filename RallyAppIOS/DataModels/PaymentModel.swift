//
//  PaymentModel.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

struct PaymentModel: Codable {
    let orderID: Int
    let paymentIntent, ephemeralKey, customer, publishableKey: String

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case paymentIntent, ephemeralKey, customer, publishableKey
    }
}
