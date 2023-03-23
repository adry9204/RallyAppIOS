//
//  OrderlistTableViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import UIKit

class OrderlistTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var data: Array<OrderDetail>
    var tableView: UITableView!
    
    override init() {
        data = Array<OrderDetail>()
        super.init()
    }
    
    func setData(data: Array<OrderDetail>){
        print(data)
        self.data = data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderItemCell.identifier, for: indexPath) as! OrderItemCell
        cell.populateCellWithData(data: data[indexPath.row])
        return cell
    }
}
