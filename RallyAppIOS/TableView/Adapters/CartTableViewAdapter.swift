//
//  CartTableViewAdapter.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation
import UIKit

class CartTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var data: Array<CartModel>
    var tableView: UITableView!
    
    weak var delegate: CartTableViewDelegate?
    
    override init() {
        data = Array<CartModel>()
        super.init()
    }
    
    func getCartsFromApi(userId: Int, token: String){
        let cartService = CartServices()
        Task {
            do{
                let carts = try await cartService.getCartFromTheApi(userId: userId, token: token)
                data = carts
                tableView.reloadData()
            }catch {
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCellTableViewCell.identifier, for: indexPath) as! CartItemCellTableViewCell
        
        cell.populateCellWithData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(delegate != nil){
            delegate?.itemSelectedAtIndex(dataAtIndex: data[indexPath.row], indexPath: indexPath)
        }
    }
    
}
