//
//  NotificationManager.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate{
    
    static let shared = NotificationManager()
    let center = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        center.delegate = self
    }
    
    func displaySimpleNotification(title: String, body: String){
        print("NotificationManger -> DisplaySimpleNotification")
        isCentreAuthorized {authorized in
            if(authorized){
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = UNNotificationSound.default
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                self.center.add(request)
            }else{
                self.requestAuthorization()
            }
        }
    }
    
    func isCentreAuthorized(callback: @escaping (_ authorized: Bool)-> Void){
        center.getNotificationSettings{setting in
            if setting.authorizationStatus == .authorized{
                print("authorized")
                callback(true)
            }else{
                callback(false)
            }
        }
    }
    
    func requestAuthorization(){
        isCentreAuthorized { authorized in
            if(authorized){
                return
            }
            self.center.requestAuthorization(options: [.alert,.sound]){ granted, error in
                if let error = error {
                    print("Error requesting notification authorization: \(error.localizedDescription)")
                } else if granted {
                    print("Notification authorization granted")
                } else {
                    print("Notification authorization denied")
                }
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let options: UNNotificationPresentationOptions = [.banner, .list, .sound]
        completionHandler(options)
    }
}
