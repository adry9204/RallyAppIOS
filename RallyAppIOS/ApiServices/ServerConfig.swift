//
//  ServerConfig.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-26.
//

import Foundation

class ServerConfig{
    static let SERVER = "https://still-brushlands-66800.herokuapp.com"
    
    static func makeUrl(endpoint: String) -> URL{
        let urlString = ServerConfig.SERVER + endpoint
        let url = URL(string: urlString)!
        return url
    }
}
