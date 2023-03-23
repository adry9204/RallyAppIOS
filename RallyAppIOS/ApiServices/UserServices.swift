//
//  UserServices.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class UserServices{
    
    func loginUser(username: String, password: String) async throws -> ApiResponse<UserLoginResponse> {
        
        let url = URL(string: "http://localhost:8000/api/users/login")
        

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // Create a dictionary to hold the request body data
        let params: [String: Any] = [
            "userName": username,
            "password": password
        ]

        // Serialize the dictionary to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])

        // Set the request body data
        request.httpBody = jsonData


        // Add the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ApiResponse<UserLoginResponse>.self, from: data)
        
        return decoded
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
    
}