//
//  OrderServices.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

class OrderServices{
    
    func makeOrderForUser(
        userId: Int,
        token: String,
        completionHandler: @escaping(_ response: ApiResponse<Order<Int>>) -> Void
    ){
        
        let url = ServerConfig.makeUrl(endpoint: "/api/orders/")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "userId", value: userId)
            .addToken(token: token)
            .setContentTypeJson()
            .build()
        
        if(request == nil){
            print("Unable to make request")
            return
        }
        
        RequestHandler.shared.makeRequest(request: request!){ data in
            do{
                let decoded = try JSONDecoder().decode(ApiResponse<Order<Int>>.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(decoded)
                }
            }catch{
                print(error)
            }
        }
    }
    
    func makePayment(
        orderId: Int,
        addressId: Int,
        token: String,
        completionHandler: @escaping(_ response: ApiResponse<PaymentModel>) -> Void
    ){
        
        let url = ServerConfig.makeUrl(endpoint: "/api/orders/makepayment")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "orderId", value: orderId)
            .addParams(key: "addressId", value: addressId)
            .addToken(token: token)
            .setContentTypeJson()
            .build()
        
        if(request == nil){
            return
        }
        
        RequestHandler.shared.makeRequest(request: request!){ data in
            do{
                let decoded = try JSONDecoder().decode(ApiResponse<PaymentModel>.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(decoded)
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func placeOrder(
        orderId: Int,
        token: String,
        completionHandler: @escaping (_ response: ApiResponse<Order<Int>>) -> Void
    ){
        
        let url = ServerConfig.makeUrl(endpoint: "/api/orders/placeorder")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .POST)
            .addParams(key: "orderId", value: orderId)
            .addToken(token: token)
            .setContentTypeJson()
            .build()
        
        if(request == nil){
            return
        }
        
        RequestHandler.shared.makeRequest(request: request!){ data in
            if(data == nil){
                print("makeRequest funcontion passed nil")
                return
            }
            do{
                let decoded = try JSONDecoder().decode(ApiResponse<Order<Int>>.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(decoded)
                }
            }catch{
                print(error)
            }
        }
    }
    
    func getUsersOrder(
        userId: Int,
        token: String,
        completionHandler: @escaping (_ response: ApiResponse<Order<User>>) -> Void
    ) {
      
        
        let url = ServerConfig.makeUrl(endpoint: "/api/orders/user/\(userId)")
        let request = RequestBuilder(url: url)
            .addToken(token: token)
            .setContentTypeJson()
            .build()
        
        RequestHandler.shared.makeRequest(request: request!){ data in
            if(data == nil){
                print("RequestHandler::makeFunction passed nil to callback function")
                return
            }
            do{
                let decoded = try JSONDecoder().decode(ApiResponse<Order<User>>.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(decoded)
                }
            }catch{
                print(error)
            }
        }
        
    }
    
    func cancelOrder(
        orderId: Int,
        token: String,
        completionHandler: @escaping (_ response: ApiResponse<Order<User>>) -> Void
    ){
        
        let url = ServerConfig.makeUrl(endpoint: "/api/orders/\(orderId)")
        let request = RequestBuilder(url: url)
            .setHttpMethod(httpMethod: .DELETE)
            .addToken(token: token)
            .build()
        
        
        RequestHandler.shared.makeRequest(request: request!) { data in
            do{
                if(data == nil){
                    print("RequestHandler::makeFunction passed nil to callback function")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<Order<User>>.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(decoded)
                }
            }catch{
                print(error)
            }
        }
    }
}
