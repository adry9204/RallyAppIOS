//
//  UserModel.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

struct User: Decodable {
    let id: Int
    let fullName, userName, password, email: String
    let verified, admin: Bool
    let stripeCustomerID: String?

    enum CodingKeys: String, CodingKey {
        case id, fullName, userName, password, email, verified, admin
        case stripeCustomerID = "stripeCustomerId"
    }
}
