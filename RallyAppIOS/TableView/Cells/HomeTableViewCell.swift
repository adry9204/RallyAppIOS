//
//  TableViewCell.swift
//  RallyAppIOS
//
//  Created by Aurela Bala on 2023-03-21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    // identifier for the cell
    static let identifier = "rallyTableCell"
    

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    // returns UINib for the table cell
    static func nib()->UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    

    
    // populates the cell with given data
    func populatTableCell(data: Menu){
        nameLabel.text = data.name
        priceLabel.text = "$\(data.price)"
        let description = (data.description.isEmpty) ? "No description" : data.description
        productDescription.text = description
        let imageUrl = URL(string: data.image)!
        ImageLoader.downloadImage(from: imageUrl, view: productImage)
        selectionStyle = .none
        applyTheme()
    }
    
}

