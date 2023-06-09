//
//  CartViewControllerThemeAdapter.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension CartViewController{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        helloLabel.textColor = theme.standardTextColor
        cartViewControllerTagLine.textColor = theme.standardTextColor
        view.backgroundColor = theme.backgoundColor
        checkoutButton.tintColor = theme.primaryColor
        checkoutButton.setTitleColor(theme.textOnPrimary, for: .normal)
        
        cartViewControllerHeaderStackView.backgroundColor = theme.backgoundColor
        cartTableView.backgroundColor = theme.backgoundColor
        
        cartTableView.separatorColor = theme.standardTextColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
