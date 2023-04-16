//
//  OrderDetailsViewControllerTheme.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension OrderDetailsViewController{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        view.backgroundColor = theme.backgoundColor
        orderDetailsTableView.backgroundColor = theme.backgoundColor
        pageTitle.textColor = theme.standardTextColor
        orderSummaryTitle.textColor = theme.standardTextColor
        
        totalLabel.textColor = theme.standardTextColor
        taxLabel.textColor = theme.standardTextColor
        grandTotatLabel.textColor = theme.standardTextColor
        
        totalPriceValue.textColor = theme.standardTextColor
        taxPriceValue.textColor = theme.standardTextColor
        grandTotalValue.textColor = theme.standardTextColor
        
        backButton.backgroundColor = theme.secondaryColor
        backButton.setTitleColor(.black, for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
