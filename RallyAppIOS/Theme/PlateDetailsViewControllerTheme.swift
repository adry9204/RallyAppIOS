//
//  PlateDetailViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension PlateDetailsViewController{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        view.backgroundColor = theme.backgoundColor
        
        productName.textColor = theme.primaryText
        productDescription.textColor = theme.primaryText
        productDescription.backgroundColor = theme.backgoundColor
        quantityLabel.textColor = theme.primaryText
        productPriceLabel.textColor = theme.secondaryTextColor
        
        addToCartButton.tintColor = theme.primaryColor
        addToCartButton.setTitleColor(theme.textOnPrimary, for: .normal)
        
        cancelButton.tintColor = theme.secondaryColor
        addToCartButton.setTitleColor(theme.textOnSecondary, for: .normal)
        addToCartButton.titleLabel?.attributedText = NSAttributedString(
            string: addToCartButton.titleLabel!.text!,
            attributes:
                [NSAttributedString.Key.foregroundColor: theme.textOnSecondary]
        )
        
        
        productPriceTitle.textColor = theme.primaryText
        
        quantityDecreaseButton.tintColor = theme.secondaryColor
        quantityIncreaseButton.imageView?.tintColor = theme.secondaryColor
        
        quantityIncreaseButton.tintColor = theme.secondaryColor
        quantityIncreaseButton.imageView?.tintColor = theme.secondaryColor
        
        quantityTitle.textColor = theme.primaryText
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
    
}
