//
//  TableViewCell.swift
//  RallyAppIOS
//
//  Created by Aurela Bala on 2023-03-21.
//

import UIKit

class CartCell: UITableViewCell {
    
    
    // identifier for the cell
    static let identifier = "cartCell"
    

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var quantity = 0
    var price = 0
    
    // returns UINib for the table cell
    static func nib()->UINib{
        return UINib(nibName: "CartCell", bundle: nil)
    }
    

    @IBAction func addButtonClick(_ sender: UIButton)
    {
        quantity = Int(String(quantityLabel.text!))! + 1
        quantityLabel.text = String(Int(quantity))
       // price = Int(String(priceLabel.text!))! + Int(String(priceLabel.text!))!
        //priceLabel.text = String(Int(price))
    }
    
    
    @IBAction func substructBttnClick(_ sender: Any)
    {
        quantity = Int(String(quantityLabel.text!))! - 1
        quantityLabel.text = String(Int(quantity))
       // price = Int(String(priceLabel.text!))! - Int(String(priceLabel.text!))!
       // priceLabel.text = String(Int(price))
        
    }
    
    // populates the cell with given data
    func populatTableCell(data: RallyData){
    
        nameLabel.text = "Hamburger"
        priceLabel.text = "$20"
    }
    
   
    

}

