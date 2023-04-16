//
//  CartTableViewThemeAdpater.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation

extension CartItemTableCell{
    
    func applyThemes(){
        let theme = ThemeManager.currentTheme()
        contentView.backgroundColor = theme.backgoundColor
        productDescription.textColor = theme.standardTextColor
        productDescription.backgroundColor = theme.backgoundColor
        productName.textColor = theme.primaryTextColor
        quantityLabel.textColor = theme.textOnStandard
        productPrice.textColor = theme.secondaryTextColor
    }
}
