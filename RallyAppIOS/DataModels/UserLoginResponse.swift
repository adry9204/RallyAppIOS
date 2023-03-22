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

