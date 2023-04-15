//
//  HomeScreenTableViewThemeAdapter.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation

extension HomeTableViewCell{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        self.contentView.backgroundColor = theme.backgoundColor
        self.nameLabel.textColor = theme.primaryText
        self.priceLabel.textColor = theme.secondaryTextColor
        self.productDescription.textColor = theme.primaryText
        self.productDescription.backgroundColor = theme.backgoundColor
    }
}
