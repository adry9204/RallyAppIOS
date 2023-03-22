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
        Task {
            do{
                let menus = try await menuService.getMenuFromTheApi()
                data = menus
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.populatTableCell(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(delegate != nil){
            delegate?.tableItemSelected(dataAtCell: data[indexPath.row], indexPath: indexPath)
        }
    }
    
    
}
