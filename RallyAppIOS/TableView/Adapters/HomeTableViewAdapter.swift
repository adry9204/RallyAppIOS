//
//  HomeTableViewAdapter.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation
import UIKit

class HomeTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var data: Array<Menu>
    var tableView: UITableView!
    
    weak var delegate: HomeTableViewDelegate?
    
    override init() {
        data = Array<Menu>()
        super.init()
    }
    
    func getMenuFromApi(){
        let menuService = MenuServices()
        menuService.getMenuFromTheApi(){ response in
            if(response.success == 1){
                print("Data->" , response.data)
                self.data = response.data
            }
            print(response.success)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addToCartAction = UIContextualAction(style: .normal, title: "", handler: { (action, sourceView, completionHandler) in
            let cartServices = CartServices()
            cartServices.addItemToCart(
                userId: UserAuth.userId!,
                menuId: self.data[indexPath.row].id,
                quantity: 1,
                token: UserAuth.token!
            ){ response in
                if(response.success == 0){
                    if(self.delegate != nil){
                        DispatchQueue.main.async {
                            self.delegate?.makeAlert(
                                title: "Failed to add to Cart",
                                message: response.message
                            )
                        }
                    }
                    completionHandler(false)
                    return
                }
                DispatchQueue.main.async {
                    if(self.delegate != nil){
                        self.delegate?.makeAlert(title: "Added To Cart", message: "Item added to cart successfully")
                    }
                    completionHandler(true)
                }
            }
        })
        
        addToCartAction.backgroundColor = .rallyGreen
        addToCartAction.image = UIImage(systemName: "cart.fill.badge.plus")
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [addToCartAction])
        return swipeActionConfiguration
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.populatTableCell(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(delegate != nil){
            delegate?.tableItemSelected(dataAtCell: data[indexPath.row], indexPath: indexPath)
        }
    }
    
    
}
