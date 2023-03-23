//
//  OrderServices.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

class OrderServices{
    
    func makeOrderForUser(userId: Int, token: String) async throws -> ApiResponse<Order> {
        
        let url = URL(string: "http://localhost:8000/api/orders/")
        

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // Create a dictionary to hold the request body data
        let params: [String: Any] = [
            "userId": userId,
        ]

        // Serialize the dictionary to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])

        // Set the request body data
        request.httpBody = jsonData

        // Add the request headers
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ApiResponse<Order>.self, from: data)
        
        return decoded
    }
}
