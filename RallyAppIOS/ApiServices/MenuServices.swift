//
//  MenuServices.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class MenuServices {
    func getMenuFromTheApi() async throws -> [Menu]{
        let url = URL(string: "http://localhost:8000/api/menu")
        
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        let decoded = try JSONDecoder().decode(ApiResponse<Menu>.self, from: data)
        
        return decoded.data
    }
}
