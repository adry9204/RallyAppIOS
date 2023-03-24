//
//  WebSocketManager.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import SocketIO

enum OrderStatus: String{
    case pending = "pending"
    case rejected = "rejected"
    case preparing = "preparing"
    case waitingForPickup = "waiting_for_pickup"
    case onTheWay = "on_the_way"
    case completed = "completed"
}

class WebSocketManager{
    static let shared = WebSocketManager()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:8000")!)
    var socket: SocketIOClient!
    
    func establishConnection(userId: Int){
        manager.config = [.log(true),
                         .compress,
                         .connectParams(["userId": userId])]
        
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect){ data, ack in
            print("connected")
        }
        
        socket.on("order_status_change"){ data, ack in
            do{
                let json = try JSONSerialization.data(withJSONObject: data)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedOrders = try decoder.decode([Order<User>].self, from: json)
                self.makeNotificaitonFromOrder(order: decodedOrders[0])
            }catch{
                print(error)
            }
            print("yeahhh boiii")
        }
        
        socket.connect()
    }
    
    private func makeNotificaitonFromOrder(order: Order<User>){
        let status = OrderStatus(rawValue: order.status)!
        var message = ""
        switch(status){
            case .preparing:
                message = "Your order is preparing"
            case OrderStatus.waitingForPickup:
                message = "Your order is Waiting for Pickup"
            case OrderStatus.onTheWay:
                message = "Your order is on the way"
            case .completed :
                message = "your order is delivered"
            default:
                return
        }
        NotificationManager.shared.displaySimpleNotification(title: "Order Update", body: message)
    }
    
    func disconnectSocket(){
        socket.disconnect()
    }
}
