//
//  AddAddressViewController.swift
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

class AddAddressViewController: UIViewController {

    @IBOutlet weak var addressPostalCode: UITextField!
    @IBOutlet weak var addressProvince: UITextField!
    @IBOutlet weak var addressCountry: UITextField!
    @IBOutlet weak var addressLine2: UITextField!
    @IBOutlet weak var addressLine1: UITextField!
    @IBOutlet weak var addressName: UITextField!
    @IBOutlet weak var addAddressTitle: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var order: Order<Int>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
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
    
   @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func saveAddress(){
        let addressService = AddressService()
        addressService.addNewAddressForUser(
            userId: UserAuth.userId!,
            token: UserAuth.token!,
            name: addressName.text!,
            line1: addressLine1.text!,
            line2: addressLine2.text!,
            city: "Toronto",
            country: addressCountry.text!,
            province: addressProvince.text!,
            postalCode: addressPostalCode.text!
        ){ addressResponse in
            
            if(addressResponse.success == 1){
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "goBackToCheckOutScreen", sender: self)
                }
            }else{
                DispatchQueue.main.async{
                    AlertManager.makeAlertWithOkButton(
                        title: "Issues",
                        message: addressResponse.message,
                        viewController: self
                    ){}
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goBackToCheckOutScreen"){
            let destinationVC = segue.destination as? CheckoutViewController
            destinationVC!.order = order!
        }
    }
    
}
