//
//  CartServices.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class CartServices{
    
    func addItemToCart(userId: Int, menuId: Int, quantity: Int, token: String) async throws -> [CartModel] {
        
        let url = URL(string: "http://localhost:8000/api/cart/")
        

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // Create a dictionary to hold the request body data
        let params: [String: Any] = [
            "userId": userId,
            "menuId": menuId,
            "quantity": quantity
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
        let decoded = try JSONDecoder().decode(ApiResponse<CartModel>.self, from: data)
        
        return decoded.data
//        // Create a URLSessionDataTask to handle the request
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            guard let data = data else { return }
//            // Handle the response data
//            print(String(data: data, encoding: .utf8)!)
//        }
//
//        // Start the task
//        task.resume()
    }
    
    func getCartFromTheApi(userId: Int, token: String) async throws -> [CartModel]{
        let url = URL(string: "http://localhost:8000/api/cart/user/\(userId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        print(token, userId)
        print(request)
        // Add the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(data)
        let decoded = try JSONDecoder().decode(ApiResponse<CartModel>.self, from: data)
        print(decoded.success, decoded.message, decoded.data)
        return decoded.data
    }
    
    func removeItemFromCart(cartId: Int, token: String) async throws -> ApiResponse<CartModel>{
        let url = URL(string: "http://localhost:8000/api/cart/\(cartId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(data)
        let decoded = try JSONDecoder().decode(ApiResponse<CartModel>.self, from: data)
        print(decoded.success, decoded.message, decoded.data)
        return decoded
    }
}
