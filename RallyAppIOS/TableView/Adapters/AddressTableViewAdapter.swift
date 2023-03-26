//
//  AddressTableViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation
import UIKit

class AddressTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    
    var data: Array<Address>
    var tableView: UITableView!
    var lastSelectedIndex: Int? = nil
    var selectedAddressId: Int? = nil
    
    override init() {
        data = Array<Address>()
        super.init()
        getUsersAddressFromApi()
    }
    
    func setData(data: Array<Address>){
        print(data)
        self.data = data
        tableView.reloadData()
    }
    
    func getUsersAddressFromApi(){
        let addressService = AddressService()
        addressService.getUsersAddress(
            userId: UserAuth.userId!,
            token: UserAuth.token!
        ){ response in
            if(response.success == 1){
                self.data = response.data
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressItemCell.identifier, for: indexPath) as! AddressItemCell
        cell.populateCellWithData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setAddressAtIndexSelected(indexPath: indexPath)
    }
    
    func setAddressAtIndexSelected(indexPath: IndexPath){
        if(lastSelectedIndex != nil){
            data[lastSelectedIndex!].selected = false
        }
        lastSelectedIndex = indexPath.row
        data[indexPath.row].selected = true
        selectedAddressId = data[indexPath.row].id
        tableView.reloadData()
    }
    
}
