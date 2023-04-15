//
//  OrderTableCellTheme.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation

extension OrderTableCell{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        contentView.backgroundColor = theme.backgoundColor
        orderTitle.textColor = theme.primaryText
        itemCountLabel.textColor = theme.primaryColor
        orderStatusLabel.textColor = theme.secondaryTextColor
        orterTotalLabel.textColor = theme.secondaryTextColor
    }
}
