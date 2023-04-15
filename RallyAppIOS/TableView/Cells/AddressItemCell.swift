//
//  AddressItemCell.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import UIKit

class AddressItemCell: UITableViewCell {
    
    static let identifier = "addressItemCell"
    
    @IBOutlet weak var addressLine1: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var addressSelectedToggle: UISwitch!
    
    static func nib()->UINib{
        return UINib(nibName: "AddressItemCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }
    
    func populateCellWithData(data: Address){
        addressLine1.text = data.line1
        addressName.text = data.name
        addressSelectedToggle.isOn = data.selected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
