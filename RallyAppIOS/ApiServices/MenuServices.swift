//
//  MenuServices.swift
//  Api_Test_App
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class MenuServices {
    
    func getMenuFromTheApi(
        completetionHandler: @escaping (_ response: ApiResponse<Menu>) -> Void
    ){
        let url = ServerConfig.makeUrl(endpoint: "/api/menu")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url){ (data, response, error) in
            do{
                if let _ = error {
                    print("RegisterFailed")
                    return
                }
                guard let data = data else {
                    print("Api call failed")
                    return
                }
                let decoded = try JSONDecoder().decode(ApiResponse<Menu>.self, from: data)
                completetionHandler(decoded)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
