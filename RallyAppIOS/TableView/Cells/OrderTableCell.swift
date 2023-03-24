//
//  OrderTableCell.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import UIKit

class OrderTableCell: UITableViewCell {
    
    static let identifier = "orderTableItemCell"
    
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orterTotalLabel: UILabel!
    
    static func nib()->UINib{
        return UINib(nibName: "OrderTableCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCellWithData(data: Order<User>){
        orderTitle.text = data.orderDetails[0].menu.name
        itemCountLabel.text = makeItemCountLabelFromOrderDetails(orderDetails: data.orderDetails)
        orderStatusLabel.text = data.status
        orterTotalLabel.text = data.totalPrice
    }
    
    func makeItemCountLabelFromOrderDetails(orderDetails: [OrderDetail]) -> String{
        if(orderDetails.isEmpty || orderDetails.count == 1){
            return ""
        }
        return "+\(orderDetails.count - 1) items"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
