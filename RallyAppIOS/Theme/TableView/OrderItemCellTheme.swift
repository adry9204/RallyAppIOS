//
//  OrderItemCellTheme.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation

extension OrderItemCell {
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        contentView.backgroundColor = theme.backgoundColor
        productName.textColor = theme.primaryTextColor
        quantityLabel.textColor = theme.textOnStandard
        priceLabel.textColor = theme.secondaryTextColor
    }
}
