//
//  UserAuth.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

class UserAuth{
    static var userId: Int?;
    static var token: String?;
    
    static func isUserLoggedIn() -> Bool{
        if(userId == nil || token == nil){
            return true
        }else{
            return false
        }
    }
}
