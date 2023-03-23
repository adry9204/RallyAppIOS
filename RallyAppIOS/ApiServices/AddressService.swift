//
//  AddressService.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

class AddressService{
    
    func getUsersAddress(userId: Int, token: String) async throws -> [Address]{
        let url = URL(string: "http://localhost:8000/api/address/user/\(userId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        print(token, userId)
        print(request)
        // Add the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(data)
        let decoded = try JSONDecoder().decode(ApiResponse<Address>.self, from: data)
        print(decoded.success, decoded.message, decoded.data)
        return decoded.data
    }
}
