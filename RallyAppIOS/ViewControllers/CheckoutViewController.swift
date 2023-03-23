//
//  CheckoutViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import UIKit

class CheckoutViewController: UIViewController, CartTableViewDelegate {
    
    
    
    static var identifier = "goToCheckOut"
    
    let orderListTableViewAdapter = OrderlistTableViewAdapter()
    let addressTableViewAdapter = AddressTableViewAdapter()
    
    @IBOutlet weak var checkOutOrderListTableView: UITableView!
    @IBOutlet weak var checkOutAddressTableView: UITableView!
    
    let order: Welcome? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOrderListTableView()
        setUpAddressTableView()
        setDataOnTableView()
    }
    
    private func setUpOrderListTableView(){
        orderListTableViewAdapter.tableView = checkOutOrderListTableView
        checkOutOrderListTableView.delegate = orderListTableViewAdapter
        checkOutOrderListTableView.dataSource = orderListTableViewAdapter
        checkOutOrderListTableView.register(
            OrderItemCell.nib(),
            forCellReuseIdentifier: OrderItemCell.identifier
        )
    }
    
    private func setUpAddressTableView(){
        addressTableViewAdapter.tableView = checkOutAddressTableView
        
        checkOutAddressTableView.delegate = addressTableViewAdapter
        checkOutAddressTableView.dataSource = addressTableViewAdapter
        
        checkOutAddressTableView.register(
            AddressItemCell.nib(),
            forCellReuseIdentifier: AddressItemCell.identifier
        )
    }
    
    func setDataOnTableView(){
        
        var data =  Array<OrderDetail>()
        for _ in 0...10{
            let category = Category(id: 1, category: "food")
            let menu = Menu(id: 2, name: "Menu Item", description: "desc", price: "10", image: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80", category: category)
            let orderDetails = OrderDetail(id: 1, price: "20", quantity: 3, menu: menu)
            data.append(orderDetails)
        }
        print(data)
        orderListTableViewAdapter.setData(data: data)
    }
    
    func itemSelectedAtIndex(dataAtIndex: CartModel, indexPath: IndexPath) {
        print("selected")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
