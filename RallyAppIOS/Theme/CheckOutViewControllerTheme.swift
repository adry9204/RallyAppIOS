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
        greetingsLabel.textColor = theme.primaryText
        tagLineLabel.textColor = theme.primaryText
        
        cartItemsTitle.textColor = theme.primaryText
        checkOutOrderListTableView.backgroundColor = theme.backgoundColor
        
        addressTitle.textColor = theme.primaryText
        checkOutAddressTableView.backgroundColor = theme.backgoundColor
        
        addAddressButton.tintColor = theme.primaryColor
        addAddressButton.setTitleColor(theme.textOnPrimary, for: .normal)
        
        totalPriceLabel.textColor = theme.primaryText
        totalPriceValue.textColor = theme.primaryText
        
        taxPriceLabel.textColor = theme.primaryText
        taxPricValue.textColor = theme.primaryText
        
        grandTotalLabel.textColor = theme.primaryText
        grandTotalValue.textColor = theme.primaryText
        
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
