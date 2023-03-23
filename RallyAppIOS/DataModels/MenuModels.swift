//
//  MenuModels.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

struct Menu: Decodable {
    let id: Int
    let name, description, price: String
    let image: String
    let category: Category?
}

struct Category: Decodable {
    let id: Int
    let category: String
}
