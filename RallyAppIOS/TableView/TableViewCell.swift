//
//  TableViewCell.swift
//  RallyAppIOS
//
//  Created by Aurela Bala on 2023-03-21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    // identifier for the cell
    static let identifier = "rallyTableCell"
    

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // returns UINib for the table cell
    static func nib()->UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    

    
    // populates the cell with given data
    func populatTableCell(data: RallyData){
    
        nameLabel.text = "Hamburger"
        priceLabel.text = "$20"
    }
    
   
    

}

