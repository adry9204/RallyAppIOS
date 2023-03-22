//
//  ApiResponse.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable{
    var success: Int
    var message: String
    var data: [T]
}

