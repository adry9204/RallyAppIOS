//
//  PlateDetailsViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
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
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var menuItem: Menu? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(menuItem != nil){
            productName.text = menuItem?.name
            productDescription.text = menuItem?.description
            productPriceLabel.text = "$\(menuItem!.price)"
            let imageURL = URL(string: menuItem!.image)!
            ImageLoader.downloadImage(from: imageURL, view: productImage)
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
