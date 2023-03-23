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
    
    var order: Order<Int>? = nil
    
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
       makeOrder()
    }
    
    private func makeOrder(){
        let orderServices = OrderServices()
        Task {
            do{
                let orderResponse = try await orderServices.makeOrderForUser(
                    userId: UserAuth.userId!,
                    token: UserAuth.token!)
                if(orderResponse.success == 1){
                    order = orderResponse.data[0]
                    performSegue(withIdentifier: CheckoutViewController.identifier, sender: self)
                }else{
                    AlertManager.makeAlertWithOkButton(
                        title: "Issues",
                        message: orderResponse.message,
                        viewController: self
                    ){
                        print("OK Pressed")
                    }
                }
            
            }catch {
                print(error)
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
