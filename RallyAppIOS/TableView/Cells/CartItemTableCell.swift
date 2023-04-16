//
//  CartItemCellTableViewCell.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import UIKit

class CartItemTableCell: UITableViewCell {
    
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
        selectionStyle = SelectionStyle.none
        
    }
    
    func populateCellWithData(data: CartModel){
        applyThemes()
        
        productName.text = data.menu.name
        let description = (data.menu.description.isEmpty) ? "No description" : data.menu.description
        productDescription.text = description
        quantityLabel.text = "\(data.quantity)"
        productPrice.text = "$\(data.menu.price)"
        
        let url = URL(string: data.menu.image)!
        ImageLoader.downloadImage(from: url, view: productImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
