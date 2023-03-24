//
//  UserLoginResponse.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

struct UserLoginResponse: Decodable {
    let userID: Int
    let userName, email, token: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName, email, token
    }
}

struct UserResgisterModel: Decodable {
    let fullName, email, userName: String
    let verified: Bool
    let id: Int
}
