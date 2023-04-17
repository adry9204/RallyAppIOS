//
//  UserServices.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class UserServices{
    
    func loginUser(
        username: String,
        password: String,
        completionHandler: @escaping(_ response: ApiResponse<UserLoginResponse>) -> Void
    ){
        
        let url = ServerConfig.makeUrl(endpoint: "/api/users/login")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "userName", value: username)
            .addParams(key: "password", value: password)
            .setContentTypeJson()
            .build()
            
        if(request == nil){
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request!){(data, response, error) in
            do{
                if let _ = error {
                    print("RegisterFailed")
                    return
                }
                guard let data = data else {
                    print("Api call failed")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<UserLoginResponse>.self, from: data)
                DispatchQueue.main.async{
                    completionHandler(decoded)
                }
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func registerUser(
        fullName: String,
        username: String,
        email: String,
        password: String,
        completionHandler: @escaping(_ response:ApiResponse<UserResgisterModel>)->Void
    ) {
        
        let url = ServerConfig.makeUrl(endpoint: "/api/users/register")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "fullName", value: fullName)
            .addParams(key: "userName", value: username)
            .addParams(key: "email", value: email)
            .addParams(key: "password", value: password)
            .setContentTypeJson()
            .build()
        
        if(request == nil){
            return
        }
        
        let session = URLSession.shared
        let task =  session.dataTask(with: request!) { (data, response, error) in
            do{
                if let _ = error {
                    print("RegisterFailed")
                    return
                }
                guard let data = data else {
                    print("Api call failed")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<UserResgisterModel>.self, from: data)
                completionHandler(decoded)
            }catch{
                print(error)
            }

        }
        // Start the task
        task.resume()
    }
    
}
