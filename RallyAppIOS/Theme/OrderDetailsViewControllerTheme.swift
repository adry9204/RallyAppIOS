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
        pageTitle.textColor = theme.primaryText
        orderSummaryTitle.textColor = theme.primaryText
        
        totalLabel.textColor = theme.primaryText
        taxLabel.textColor = theme.primaryText
        grandTotatLabel.textColor = theme.primaryText
        
        totalPriceValue.textColor = theme.primaryText
        taxPriceValue.textColor = theme.primaryText
        grandTotalValue.textColor = theme.primaryText
        
        backButton.backgroundColor = theme.secondaryColor
        backButton.setTitleColor(.black, for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
