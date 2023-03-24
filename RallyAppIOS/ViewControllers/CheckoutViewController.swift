//
//  CheckoutViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import UIKit
import StripeCore
import StripePaymentSheet

class CheckoutViewController: UIViewController, CartTableViewDelegate {
    
    
    
    static var identifier = "goToCheckOut"
    
    let orderListTableViewAdapter = OrderlistTableViewAdapter()
    let addressTableViewAdapter = AddressTableViewAdapter()
    
    @IBOutlet weak var checkOutOrderListTableView: UITableView!
    @IBOutlet weak var checkOutAddressTableView: UITableView!
    
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var paymentSheet: PaymentSheet?
    
    var order: Order<Int>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOrderListTableView()
        setUpAddressTableView()
        setUpPriceLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addressTableViewAdapter.getUsersAddressFromApi()
    }
    
    private func setUpPriceLabels(){
        if(order != nil){
            totalPriceLabel.text = "$\(order!.beforeTaxPrice)"
            taxPriceLabel.text = "$\(order!.taxPrice)"
            grandTotalLabel.text = "$\(order!.totalPrice)"
        }
    }
    
    private func setUpOrderListTableView(){
        orderListTableViewAdapter.tableView = checkOutOrderListTableView
        checkOutOrderListTableView.delegate = orderListTableViewAdapter
        checkOutOrderListTableView.dataSource = orderListTableViewAdapter
        checkOutOrderListTableView.register(
            OrderItemCell.nib(),
            forCellReuseIdentifier: OrderItemCell.identifier
        )
        if(order != nil){
            orderListTableViewAdapter.setData(data: order!.orderDetails)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToAddAddress"){
            let destinationVC = segue.destination as? AddAddressViewController
            destinationVC?.order = order
        }
    }
    
    
    @IBAction func addAddressPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToAddAddress", sender: self)
    }
    

    func itemSelectedAtIndex(dataAtIndex: CartModel, indexPath: IndexPath){
        print("selected")
    }
    
    @IBAction func placeOrderButtonPressed(_ sender: Any) {
        if(addressTableViewAdapter.selectedAddressId != nil){
            makePayment(addressId: addressTableViewAdapter.selectedAddressId!)
        }
    }
    
    func makePayment(addressId: Int){
        
        let orderService = OrderServices()
        Task {
            do{
                let paymentResponse = try await orderService.makePayment(orderId: order!.id, addressId: addressId, token: UserAuth.token!)
                
                if(paymentResponse.success == 1){
                    let paymentConfigData = paymentResponse.data[0]
                    STPAPIClient.shared.publishableKey = paymentConfigData.publishableKey
                    var configuration = PaymentSheet.Configuration()
                    configuration.merchantDisplayName = "Rally Restaurant"
                    configuration.customer = .init(id: paymentConfigData.customer, ephemeralKeySecret: paymentConfigData.ephemeralKey)
                    self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentConfigData.paymentIntent, configuration: configuration)
                    
                    paymentSheet?.present(from: self) { paymentResult in
                        // MARK: Handle the payment result
                        switch paymentResult {
                        case .completed:
                            self.placeOrder(orderId: self.order!.id)
                        case .canceled:
                            AlertManager.makeAlertWithOkButton(
                                title: "Issues",
                                message: "PaymentCanceled",
                                viewController: self
                            ){
                                print("OK Pressed")
                            }
                        case .failed(let error):
                            AlertManager.makeAlertWithOkButton(
                                title: "Issues",
                                message: "Payment Failed \(error)",
                                viewController: self
                            ){
                                print("OK Pressed")
                            }
                        }
                    }
                }else{
                    AlertManager.makeAlertWithOkButton(
                        title: "Issues",
                        message: paymentResponse.message,
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
    
    func placeOrder(orderId: Int){
        let orderService = OrderServices()
        Task{
            do{
                let response = try await orderService.placeOrder(orderId: orderId, token: UserAuth.token!)
                if(response.success == 1){
                    performSegue(withIdentifier: "gotBackToTabBarController", sender: self)
                }
            }catch{
                print(error)
            }
        }
    }
    
}
