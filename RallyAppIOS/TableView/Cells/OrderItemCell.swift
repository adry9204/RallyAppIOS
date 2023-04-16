//
//  OrderItemCell.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import UIKit

class OrderItemCell: UITableViewCell {
    
    static let identifier = "orderItemCell"
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static func nib()->UINib{
        return UINib(nibName: "OrderItemCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }
    
    func populateCellWithData(data: OrderDetail){
        productName.text = data.menu.name
        quantityLabel.text = "\(data.quantity)"
        priceLabel.text = "$\(data.menu.price)"
        
        ImageLoader.downloadImage(from: URL(string: data.menu.image)!, view: productImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
