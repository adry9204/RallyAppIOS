//
//  OrderServices.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

class OrderServices{
    
    func makeOrderForUser(userId: Int, token: String) async throws -> ApiResponse<Order<Int>> {
        
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
        let decoded = try JSONDecoder().decode(ApiResponse<Order<Int>>.self, from: data)
        
        return decoded
    }
    
    func makePayment(orderId: Int, addressId: Int, token: String) async throws -> ApiResponse<PaymentModel>{
        
        let url = URL(string: "http://localhost:8000/api/orders/makepayment")
        

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // Create a dictionary to hold the request body data
        let params: [String: Any] = [
            "orderId": orderId,
            "addressId": addressId
        ]

        // Serialize the dictionary to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])

        // Set the request body data
        request.httpBody = jsonData

        // Add the request headers
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ApiResponse<PaymentModel>.self, from: data)
        
        return decoded
    }
    
    func placeOrder(orderId: Int, token: String) async throws -> ApiResponse<Order<Int>>{
        let url = URL(string: "http://localhost:8000/api/orders/placeorder")
        

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // Create a dictionary to hold the request body data
        let params: [String: Any] = [
            "orderId": orderId,
        ]

        // Serialize the dictionary to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])

        // Set the request body data
        request.httpBody = jsonData

        // Add the request headers
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ApiResponse<Order<Int>>.self, from: data)
        
        return decoded
    }
    
    func getUsersOrder(userId: Int, token: String) async throws -> [Order<User>] {
        let url = URL(string: "http://localhost:8000/api/orders/user/\(userId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        // Add the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(data)
        let decoded = try JSONDecoder().decode(ApiResponse<Order<User>>.self, from: data)
        print(decoded.success, decoded.message, decoded.data)
        return decoded.data
    }
}
