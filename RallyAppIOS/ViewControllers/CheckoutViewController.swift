//
//  CheckoutViewController.swift
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


import UIKit
import StripeCore
import StripePaymentSheet

class CheckoutViewController: UIViewController, CartTableViewDelegate {
    
    
    
    static var identifier = "goToCheckOut"
    
    let orderListTableViewAdapter = OrderlistTableViewAdapter()
    let addressTableViewAdapter = AddressTableViewAdapter()
    
    @IBOutlet weak var headerStackView: UIStackView!
    
    @IBOutlet weak var checkOutOrderListTableView: UITableView!
    @IBOutlet weak var checkOutAddressTableView: UITableView!
    
    @IBOutlet weak var grandTotalValue: UILabel!
    @IBOutlet weak var taxPricValue: UILabel!
    @IBOutlet weak var totalPriceValue: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    
    
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    
    @IBOutlet weak var cartItemsTitle: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var addAddressButton: UIButton!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var checkoutViewScrollView: UIScrollView!
    @IBOutlet weak var scrollViewSubView: UIView!
    
    var paymentSheet: PaymentSheet?
    
    var order: Order<Int>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        setUpOrderListTableView()
        setUpAddressTableView()
        setUpPriceLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addressTableViewAdapter.getUsersAddressFromApi()
    }
    
    private func setUpPriceLabels(){
        if(order != nil){
            totalPriceValue.text = "$\(order!.beforeTaxPrice)"
            taxPricValue.text = "$\(order!.taxPrice)"
            grandTotalValue.text = "$\(order!.totalPrice)"
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
        }else{
            AlertManager.makeAlertWithOkButton(
                title: "Missing field",
                message: "Please select an address",
                viewController: self
            ){}
        }
    }
    
    func makePayment(addressId: Int){
        let orderService = OrderServices()
        orderService.makePayment(orderId: order!.id, addressId: addressId, token: UserAuth.token!){ response in
            if(response.success != 1){
                AlertManager.makeAlertWithOkButton(
                    title: "Issues",
                    message: response.message,
                    viewController: self
                ){
                    print("OK Pressed")
                }
                return
            }
            let paymentConfigData = response.data[0]
            STPAPIClient.shared.publishableKey = paymentConfigData.publishableKey
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Rally Restaurant"
            configuration.customer = .init(id: paymentConfigData.customer, ephemeralKeySecret: paymentConfigData.ephemeralKey)
            self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentConfigData.paymentIntent, configuration: configuration)
                
            self.paymentSheet?.present(from: self, completion: self.handlerPaymentResult)
        }
    }
    
    private func handlerPaymentResult(paymentResult: PaymentSheetResult){
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
    
    func placeOrder(orderId: Int){
        let orderService = OrderServices()
        orderService.placeOrder(orderId: order!.id, token: UserAuth.token!){ response in
            if(response.success == 1){
                self.performSegue(withIdentifier: "gotBackToTabBarController", sender: self)
            }else{
                AlertManager.makeAlertWithOkButton(
                    title: "Failed to place order",
                    message: "There was an issue placing your order",
                    viewController: self
                ){
                    self.performSegue(withIdentifier: "gotBackToTabBarController", sender: self)
                }
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let orderServices = OrderServices()
        print("canecel")
        orderServices.cancelOrder(orderId: order!.id, token: UserAuth.token!){ response in
            if(response.success == 1){
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    AlertManager.makeAlertWithOkButton(
                        title: "Isuue canceling Order",
                        message: response.message,
                        viewController: self
                    ){
                        print("Ok Pressed")
                    }
                }
            }
        }
    }
    
    
}
