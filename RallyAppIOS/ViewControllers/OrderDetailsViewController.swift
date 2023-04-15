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
    
    
    @IBOutlet weak var grandTotalValue: UILabel!
    @IBOutlet weak var taxPriceValue: UILabel!
    @IBOutlet weak var totalPriceValue: UILabel!
    
    @IBOutlet weak var orderDetailsTableView: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var orderSummaryTitle: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var grandTotatLabel: UILabel!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    var orders: Order<User>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
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
            totalPriceValue.text = "$\(orders!.beforeTaxPrice)"
            taxPriceValue.text = "$\(orders!.taxPrice)"
            grandTotalValue.text = "$\(orders!.totalPrice)"
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
