//
//  AddressTableView.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation

extension AddressItemCell{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        
        contentView.backgroundColor = theme.backgoundColor
        addressLine1.textColor  = theme.standardTextColor
        addressName.textColor = theme.standardTextColor
        
        addressSelectedToggle.onTintColor = theme.toggleColor
    }
}
