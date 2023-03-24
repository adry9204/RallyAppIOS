//
//  NotificationManager.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import UserNotifications

class NotificationManager{
    
    static let shared = NotificationManager()
    let userNotificationCurrentObject = UNUserNotificationCenter.current()
    
    func displaySimpleNotification(title: String, body: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        userNotificationCurrentObject.add(request)
    }
}
