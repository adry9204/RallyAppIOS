//
//  UserViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//
//  Authors
//  --------------------------------------
//  Adriana Diaz Toress
//  301157161
//
//  Aurela Bala
//  301279255q
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

class UserOrdersViewController: UIViewController, OrderTableDelegate {
    
    let orderTableViewAdapter = OrdersTableViewAdapter()
    
    @IBOutlet weak var headerTagLine: UILabel!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var orderListTableView: UITableView!
    
    var username = ""
    
    var selectedOrder: Order<User>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        applyTheme()
        
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
        
        setUpOrdersTableView()
        
    }
    
    private func setUpOrdersTableView(){
        orderTableViewAdapter.tableView = orderListTableView
        orderListTableView.dataSource = orderTableViewAdapter
        orderListTableView.delegate = orderTableViewAdapter
        orderTableViewAdapter.delgate = self
        orderListTableView.register(OrderTableCell.nib(), forCellReuseIdentifier: OrderTableCell.identifier)
        orderTableViewAdapter.getUsersOrdersFromApi()
    }
    
    func itemSelectedAtIndex(dataAtIndex: Order<User>, indexPath: IndexPath) {
        selectedOrder = dataAtIndex
        performSegue(withIdentifier: OrderDetailsViewController.identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == OrderDetailsViewController.identifier){
            let destinationVC = segue.destination as! OrderDetailsViewController
            destinationVC.orders = selectedOrder
            selectedOrder = nil
        }
    }
    
}
