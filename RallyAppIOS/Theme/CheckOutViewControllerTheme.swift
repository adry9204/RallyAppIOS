//
//  CheckOutViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension CheckoutViewController{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        
        view.backgroundColor = theme.backgoundColor
        checkoutViewScrollView.backgroundColor = theme.backgoundColor
        scrollViewSubView.backgroundColor = theme.backgoundColor
        
        headerStackView.backgroundColor = theme.backgoundColor
        greetingsLabel.textColor = theme.standardTextColor
        tagLineLabel.textColor = theme.standardTextColor
        
        cartItemsTitle.textColor = theme.standardTextColor
        checkOutOrderListTableView.backgroundColor = theme.backgoundColor
        
        addressTitle.textColor = theme.standardTextColor
        checkOutAddressTableView.backgroundColor = theme.backgoundColor
        
        addAddressButton.tintColor = theme.primaryColor
        addAddressButton.setTitleColor(theme.textOnPrimary, for: .normal)
        
        totalPriceLabel.textColor = theme.standardTextColor
        totalPriceValue.textColor = theme.standardTextColor
        
        taxPriceLabel.textColor = theme.standardTextColor
        taxPricValue.textColor = theme.standardTextColor
        
        grandTotalLabel.textColor = theme.standardTextColor
        grandTotalValue.textColor = theme.standardTextColor
        
        placeOrderButton.tintColor = theme.primaryColor
        placeOrderButton.setTitleColor(theme.textOnPrimary, for: .normal)
        
        cancelButton.tintColor = theme.secondaryColor
        placeOrderButton.setTitleColor(theme.textOnSecondary, for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
