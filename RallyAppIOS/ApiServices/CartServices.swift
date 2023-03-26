//
//  CartServices.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class CartServices{
    
    func addItemToCart(
        userId: Int,
        menuId: Int,
        quantity: Int,
        token: String,
        completetionHandler: @escaping(_ response: ApiResponse<CartModel>) -> Void
    ) {
        
        let url = URL(string: "http://localhost:8000/api/cart/")
        let session = URLSession.shared
        
        let request = RequestBuilder(url: url!)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "userId", value: userId)
            .addParams(key: "menuId", value: menuId)
            .addParams(key: "quantity", value: quantity)
            .addToken(token: UserAuth.token!)
            .setContentTypeJson()
            .build()
        
        print(request!)
        if(request == nil){
            return
        }
        
        let task = session.dataTask(with: request!){ (data, response, error) in
            do{
                if let _ = error {
                    print("RegisterFailed")
                    return
                }
                guard let data = data else {
                    print("Api call failed")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<CartModel>.self, from: data)
                completetionHandler(decoded)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getCartFromTheApi(
        userId: Int,
        token: String,
        completionHandler: @escaping(_ response: ApiResponse<CartModel>) -> Void
    ){
        let url = ServerConfig.makeUrl(endpoint: "/api/cart/user/\(userId)")
        let session = URLSession.shared
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .GET)
            .setContentTypeJson()
            .addToken(token: UserAuth.token!)
            .build()
        
        if(request == nil){
            return
        }
        
        let task = session.dataTask(with: request!){ (data, response, error) in
            do{
                if let _ = error{
                    print("failed")
                    return
                }
                guard let data = data else {
                    print("Api call failed")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<CartModel>.self, from: data)
                completionHandler(decoded)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func removeItemFromCart(
        cartId: Int,
        token: String,
        completionHandler: @escaping(_ response: ApiResponse<CartModel>) -> Void
    ){
        let url = ServerConfig.makeUrl(endpoint: "/api/cart/\(cartId)")
        let session = URLSession.shared
        
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .DELETE)
            .setContentTypeJson()
            .addToken(token: UserAuth.token!)
            .build()
        
        if(request == nil){
            return
        }
        
        let task = session.dataTask(with: request!){ (data, response, error) in
            do{
                if let _ = error{
                    print("failed")
                    return
                }
                guard let data = data else {
                    print("Api call failed")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<CartModel>.self, from: data)
                completionHandler(decoded)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
