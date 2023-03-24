//
//  WebSocketManager.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import SocketIO

class WebSocketManager{
    static let shared = WebSocketManager()
    let manager = SocketManager(socketURL: URL(string: "https:\\localhost:800")!)
    var socket: SocketIOClient!
    
    func establishConnection(userId: Int){
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect){ data, ack in
            
        }
    }
}
