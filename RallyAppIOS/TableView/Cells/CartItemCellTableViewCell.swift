//
//  CartItemCellTableViewCell.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import UIKit

class CartItemCellTableViewCell: UITableViewCell {
    
    // identifier for the cell
    static let identifier = "cartItemCell"
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    static func nib()->UINib{
        return UINib(nibName: "CartItemCellTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCellWithData(data: CartModel){
        productName.text = data.menu.name
        productDescription.text = data.menu.description
        quantityLabel.text = "Qty: \(data.quantity)"
        productPrice.text = "$\(data.menu.price)"
        
        let url = URL(string: data.menu.image)!
        ImageLoader.downloadImage(from: url, view: productImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
