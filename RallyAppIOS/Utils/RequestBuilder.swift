//
//  RequestBuilder.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-26.
//

import Foundation

enum httpMethods: String{
    case POST = "POST"
    case GET = "GET"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
    case PUT = "PUT"
}

class RequestBuilder{
    var request: URLRequest
    var params = [String : Any]()
    
    init(url: URL){
        request = URLRequest(url: url)
    }
    
    func setHttpMethod(httpMethod: httpMethods)->RequestBuilder{
        request.httpMethod = httpMethod.rawValue
        return self
    }
    
    func addParams(key: String, value: Any)->RequestBuilder{
        params[key] = value
        return self
    }
    
    func addToken(token: String) -> RequestBuilder{
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return self
    }
    
    func setContentTypeJson() -> RequestBuilder {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return self
    }
    
    func build() -> URLRequest?{
        if(!(params.isEmpty)){
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = jsonData
            }catch{
                print(error)
                return nil
            }
        }
        return request
    }
}
