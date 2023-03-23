//
//  AlertManager.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation
import UIKit

class AlertManager{
    
    static func makeAlertWithOkButton(title: String, message: String, viewController: UIViewController?, callback: @escaping ()->Void){
        // Create new Alert
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            callback()
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        
        viewController!.present(dialogMessage, animated: true, completion: nil)
    }

}
