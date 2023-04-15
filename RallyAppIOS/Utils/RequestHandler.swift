//
//  RequestHandler.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation

class RequestHandler{
    
    static let shared = RequestHandler()

    func makeRequest(
        request: URLRequest,
        completetionHandler: @escaping (_ data: Data?) -> Void
    ){
        let session = URLSession.shared
        let task = session.dataTask(with: request){(data, response, error) in
            if let _ = error {
                print("RegisterFailed")
                return
            }
            guard let data = data else {
                print("Api call failed")
                return
            }
            completetionHandler(data)
        }
        task.resume()
    }
}
