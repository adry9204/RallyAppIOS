//
//  OrdersTableViewAdapter.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import UIKit

class OrdersTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var data: Array<Order<User>>
    var tableView: UITableView!
    
    weak var delgate: OrderTableDelegate?
    
    override init() {
        data = Array<Order<User>>()
        super.init()
    }
    
    func getUsersOrdersFromApi(){
        let orderServices = OrderServices()
        orderServices.getUsersOrder(
            userId: UserAuth.userId!,
            token: UserAuth.token!
        ){ response in
            if(response.success == 1){
                self.data = response.data
                self.tableView.reloadData()
            }else{
                print(response)
            }
        }
//        Task {
//            do{
//                let orders = try await orderServices.getUsersOrder(userId: UserAuth.userId!, token: UserAuth.token!)
//                data = orders
//                tableView.reloadData()
//            }catch {
//                print(error)
//            }
//        }
    }
    
    func setData(data: Array<Order<User>>){
        print(data)
        self.data = data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableCell.identifier, for: indexPath) as! OrderTableCell
        cell.populateCellWithData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(delgate != nil){
            delgate?.itemSelectedAtIndex(dataAtIndex: data[indexPath.row], indexPath: indexPath)
        }
    }
    
}
