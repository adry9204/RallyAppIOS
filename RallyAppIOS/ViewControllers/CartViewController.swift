//
//  CartViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//


import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var username = ""
    
    var cartDataSource: CartDataSource? = CartDataSource()
    
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
        
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        cartDataSource?.loadData()
        print(cartDataSource!.dataSource)
        
        
        
        cartTableView.register(CartCell.nib(), forCellReuseIdentifier: CartCell.identifier)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as! CartCell
       // cell.populatTableCell(data: rallyDataSource(at: indexPath.row))
        return cell
    }


}
