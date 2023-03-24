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
    
    func addNewAddressForUser(
        userId: Int,
        token: String,
        name: String,
        line1: String,
        line2: String,
        country: String,
        province: String,
        postalCode: String
    ) async throws -> ApiResponse<Address>{
        
        let url = URL(string: "http://localhost:8000/api/address/")
        

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // Create a dictionary to hold the request body data
        let params: [String: Any] = [
            "userId": userId,
            "name": name,
            "line1": line1,
            "line2": line2,
            "country": country,
            "province": province,
            "postalCode": postalCode
        ]

        // Serialize the dictionary to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])

        // Set the request body data
        request.httpBody = jsonData

        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Add the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ApiResponse<Address>.self, from: data)
        
        return decoded
    }
}
