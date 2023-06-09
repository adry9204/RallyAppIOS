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
    @IBOutlet weak var itemCountContainer: UIView!
    
    static func nib()->UINib{
        return UINib(nibName: "OrderTableCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCellWithData(data: Order<User>){
        applyTheme()
        orderTitle.text = data.orderDetails[0].menu.name
        let itemCount = makeItemCountLabelFromOrderDetails(orderDetails: data.orderDetails)
        
        if(itemCount != ""){
            itemCountContainer.isHidden = false
        }else{
            itemCountContainer.isHidden = true
        }
        
        itemCountLabel.text = itemCount
        orderStatusLabel.text = makeOrderLabel(status: data.status)
        orterTotalLabel.text = "$\(data.totalPrice)"
    }
    
    func makeOrderLabel(status: String)-> String{
        let status = OrderStatus(rawValue: status)!
        var message = ""
        switch(status){
            case.pending:
                message = "pending"
            case .rejected:
                message = "rejected"
            case .preparing:
                message = "preparing"
            case OrderStatus.waitingForPickup:
                message = "waiting for pickup"
            case OrderStatus.onTheWay:
                message = "on the way"
            case .completed :
                message = "delivered"
        }
        return message
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
