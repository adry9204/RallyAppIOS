//
//  CartViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//


import UIKit

class CartViewController: UIViewController {
    var username = ""
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    let cartTableViewAdapter = CartTableViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
        
        cartTableViewAdapter.tableView = cartTableView
        
        cartTableView.register(CartItemCellTableViewCell.nib(), forCellReuseIdentifier: CartItemCellTableViewCell.identifier)
        
        cartTableView.delegate = cartTableViewAdapter
        cartTableView.dataSource = cartTableViewAdapter
        
        cartTableViewAdapter.getCartsFromApi(userId: UserAuth.userId!, token: UserAuth.token!)
    }
    
    @IBAction func checkOutButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: CheckoutViewController.identifier, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartTableViewAdapter.getCartsFromApi(userId: UserAuth.userId!, token: UserAuth.token!)
    }


}
