//
//  PlateDetailsViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
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


class PlateDetailsViewController: UIViewController {
    
    static let segueIdentifier = "goToPlateDetailScreen"
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    
    @IBOutlet weak var quantityDecreaseButton: UIButton!
    @IBOutlet weak var quantityIncreaseButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityTitle: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPriceTitle: UILabel!
    
    var menuItem: Menu? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        if(menuItem != nil){
            productName.text = menuItem?.name
            productDescription.text = menuItem?.description
            productPriceLabel.text = "$\(menuItem!.price)"
            let imageURL = URL(string: menuItem!.image)!
            ImageLoader.downloadImage(from: imageURL, view: productImage)
        }
    }

    
    @IBAction func addToCartPressed(_ sender: Any) {
       addItemToCart()
    }
    
    func addItemToCart(){
        let cartServices = CartServices()
        cartServices.addItemToCart(
            userId: UserAuth.userId!,
            menuId: menuItem!.id,
            quantity: Int(quantityLabel.text!) ?? 1,
            token: UserAuth.token!
        ){ response in
            
            if(response.success == 0){
                DispatchQueue.main.async {
                    AlertManager.makeAlertWithOkButton(
                        title: "Failed",
                        message: response.message,
                        viewController: self
                    ){}
                }
                return
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func decreaseButtonPressed(_ sender: Any) {
        var currentNumber = Int(quantityLabel.text!) ?? 0
        if(currentNumber > 1){
            currentNumber -= 1
        }
        quantityLabel.text = String(currentNumber)
    }
    
    @IBAction func increaseButtonPressed(_ sender: Any) {
        var currentNumber = Int(quantityLabel.text!) ?? 0
        currentNumber += 1
        quantityLabel.text = String(currentNumber)
    }
    
}
