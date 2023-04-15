//
//  CartViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
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

class CartViewController: UIViewController {
    var username = ""
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartViewControllerHeaderStackView: UIStackView!
    @IBOutlet weak var cartViewControllerTagLine: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var order: Order<Int>? = nil
    
    let cartTableViewAdapter = CartTableViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        applyTheme()
        
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
        
        cartTableViewAdapter.tableView = cartTableView
        
        cartTableView.register(CartItemTableCell.nib(), forCellReuseIdentifier: CartItemTableCell.identifier)
        
        cartTableView.delegate = cartTableViewAdapter
        cartTableView.dataSource = cartTableViewAdapter
        
        cartTableViewAdapter.getCartsFromApi(userId: UserAuth.userId!, token: UserAuth.token!)
    }
    
    
    @IBAction func checkOutButtonClicked(_ sender: Any) {
        if(!cartTableViewAdapter.data.isEmpty){
            makeOrder()
        }else{
            AlertManager.makeAlertWithOkButton(
                title: "Unable to Checout",
                message: "Your cart seems to be empty",
                viewController: self) {
                    self.tabBarController?.selectedIndex = 0
                }
        }
       
    }
    
    private func makeOrder(){
        let orderServices = OrderServices()
        orderServices.makeOrderForUser(
            userId: UserAuth.userId!,
            token: UserAuth.token!
        ){ response in
            if(response.success == 1){
                self.order = response.data[0]
                self.performSegue(withIdentifier: CheckoutViewController.identifier, sender: self)
            }else{
                AlertManager.makeAlertWithOkButton(
                    title: "Failed to make order",
                    message: "There was an issue while making your order. Please try again!s",
                    viewController: self
                ){}
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CheckoutViewController.identifier {
            let destinationVC = segue.destination as? CheckoutViewController
            destinationVC?.order = order
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartTableViewAdapter.getCartsFromApi(userId: UserAuth.userId!, token: UserAuth.token!)
    }


}
