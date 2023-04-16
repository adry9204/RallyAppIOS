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
        self.nameLabel.textColor = theme.primaryTextColor
        self.priceLabel.textColor = theme.secondaryTextColor
        self.productDescription.textColor = theme.standardTextColor
        self.productDescription.backgroundColor = theme.backgoundColor
    }
}
