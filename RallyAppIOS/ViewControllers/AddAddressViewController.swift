//
//  AddAddressViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import UIKit

class AddAddressViewController: UIViewController {

    @IBOutlet weak var addressPostalCode: UITextField!
    @IBOutlet weak var addressProvince: UITextField!
    @IBOutlet weak var addressCountry: UITextField!
    @IBOutlet weak var addressLine2: UITextField!
    @IBOutlet weak var addressLine1: UITextField!
    @IBOutlet weak var addressName: UITextField!
    
    var order: Order<Int>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func verifyInput() -> Bool{
        if(addressName.text!.isEmpty){
            makeFieldMissingAlert(field: "name")
            return false
        }
        
        if(addressLine1.text!.isEmpty){
            makeFieldMissingAlert(field: "address line 1")
            return false
        }
        
        if(addressLine2.text!.isEmpty){
            makeFieldMissingAlert(field: "address line 2")
            return false
        }
        
        if(addressCountry.text!.isEmpty){
            makeFieldMissingAlert(field: "country")
            return false
        }
        
        if(addressProvince.text!.isEmpty){
            makeFieldMissingAlert(field: "province")
            return false
        }
        
        if(addressPostalCode.text!.isEmpty){
            makeFieldMissingAlert(field: "postal code")
            return false
        }
        
        return true
    }
    
    func makeFieldMissingAlert(field: String){
        AlertManager.makeAlertWithOkButton(title: "Field Missing", message: "Please enter your \(field)", viewController: self){
            print("OK Pressed")
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if(verifyInput()){
            saveAddress()
        }
    }
    
    func saveAddress(){
        let addressService = AddressService()
        Task {
            do{
                let addressResponse = try await addressService.addNewAddressForUser(
                    userId: UserAuth.userId!,
                    token: UserAuth.token!,
                    name: addressName.text!,
                    line1: addressLine1.text!,
                    line2: addressLine2.text!,
                    country: addressCountry.text!,
                    province: addressProvince.text!,
                    postalCode: addressPostalCode.text!
                )
                
                if(addressResponse.success == 1){
                    performSegue(withIdentifier: "goBackToCheckOutScreen", sender: self)
                }else{
                    AlertManager.makeAlertWithOkButton(
                        title: "Issues",
                        message: addressResponse.message,
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
        if(segue.identifier == "goBackToCheckOutScreen"){
            let destinationVC = segue.destination as? CheckoutViewController
            destinationVC!.order = order!
        }
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
