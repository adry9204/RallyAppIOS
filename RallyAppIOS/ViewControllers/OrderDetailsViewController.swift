//
//  OrderDetailsViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//  Authors
//  --------------------------------------
//  Adriana Diaz Toress
//  301157161
//
//  Aurela Bala
//  301279255
//  Abraham Alfred Babu
//  Student ID : 301270598
//
//  Pia Mae Obias
//  Student ID: 301283632
//
//  Satender Yadav
//  Student ID: 301293305
//

import UIKit

class OrderDetailsViewController: UIViewController {

    static let identifier = "goToOrderDetails"
    
    let orderListTableViewAdapter = OrderlistTableViewAdapter()
    
    
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderDetailsTableView: UITableView!
    
    var orders: Order<User>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOrderListTableView()
        setUpSummaryLabels()
    }
    
    func setUpOrderListTableView(){
        orderListTableViewAdapter.tableView = orderDetailsTableView
        orderDetailsTableView.delegate = orderListTableViewAdapter
        orderDetailsTableView.dataSource = orderListTableViewAdapter
        orderDetailsTableView.register(OrderItemCell.nib(), forCellReuseIdentifier: OrderItemCell.identifier)
        
        if(orders != nil){
            orderListTableViewAdapter.setData(data: orders!.orderDetails)
        }
    }
    
    func setUpSummaryLabels(){
        if(orders != nil){
            totalPriceLabel.text = "$\(orders!.beforeTaxPrice)"
            taxPriceLabel.text = "$\(orders!.taxPrice)"
            grandTotalLabel.text = "$\(orders!.totalPrice)"
        }
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
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
