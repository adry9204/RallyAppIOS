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
    weak var viewController: UIViewController?
    
    override init() {
        data = Array<CartModel>()
        super.init()
    }
    
    func getCartsFromApi(userId: Int, token: String){
        let cartService = CartServices()
        cartService.getCartFromTheApi(userId: UserAuth.userId!, token: UserAuth.token!){response in
            if(response.success == 1){
                self.data = response.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableCell.identifier, for: indexPath) as! CartItemTableCell
        
        cell.populateCellWithData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(delegate != nil){
            delegate?.itemSelectedAtIndex(dataAtIndex: data[indexPath.row], indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let uploadedAction = UIContextualAction(style: .normal, title: "", handler: {
                (action, sourceView, completionHandler) in
            
            self.deleteCartItem(cartId: self.data[indexPath.row].id){ apiResponse in
                if(apiResponse.success == 1){
                    self.getCartsFromApi(userId: UserAuth.userId!, token: UserAuth.token!)
                    completionHandler(true)
                    return
                }
                if(self.viewController == nil){
                    completionHandler(false)
                    return
                }
                AlertManager.makeAlertWithOkButton(
                    title: "Failed",
                    message: "Failed to delete cart item",
                    viewController: self.viewController
                ){
                    print("pressed ok")
                }
                completionHandler(false)
            }
        })
        
        // Show Current Cloud Upload Status
        uploadedAction.backgroundColor = .red
        uploadedAction.image = UIImage(systemName: "trash")
        // end uploadedAction
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [uploadedAction])
        return swipeConfiguration
    }
    
    func deleteCartItem(cartId: Int, callback: @escaping(_ apiResponse: ApiResponse<CartModel>) -> Void){
        let cartService = CartServices()
        cartService.removeItemFromCart(
            cartId: cartId,
            token: UserAuth.token!
        ){ response in
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
}
