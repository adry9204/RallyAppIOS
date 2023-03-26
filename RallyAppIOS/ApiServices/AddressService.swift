//
//  AddressService.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

class AddressService{
    
    func getUsersAddress(
        userId: Int,
        token: String,
        completionHandler: @escaping(_ response: ApiResponse<Address>) -> Void
    ){
        let url = ServerConfig.makeUrl(endpoint: "/api/address/user/\(userId)")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .GET)
            .setContentTypeJson()
            .addToken(token: token)
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
                let decoded = try JSONDecoder().decode(ApiResponse<Address>.self, from: data)
                completionHandler(decoded)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func addNewAddressForUser(
        userId: Int,
        token: String,
        name: String,
        line1: String,
        line2: String,
        country: String,
        province: String,
        postalCode: String,
        completionHandler: @escaping(_ response: ApiResponse<Address>) -> Void
    ){
        
        let url = ServerConfig.makeUrl(endpoint: "/api/address/")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "userId", value: userId)
            .addParams(key: "name", value: name)
            .addParams(key: "line1", value: line1)
            .addParams(key: "line2", value: line2)
            .addParams(key: "country", value: country)
            .addParams(key: "province", value: province)
            .addParams(key: "postalCode", value: postalCode)
            .addToken(token: token)
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
                let decoded = try JSONDecoder().decode(ApiResponse<Address>.self, from: data)
                completionHandler(decoded)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
