//
//  OrdersViewControllerTheme.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension UserOrdersViewController{
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        view.backgroundColor = theme.backgoundColor
        headerStackView.backgroundColor = theme.backgoundColor
        headerTagLine.textColor = theme.primaryText
        helloLabel.textColor = theme.primaryText
        orderListTableView.backgroundColor = theme.backgoundColor
        orderListTableView.separatorColor = theme.primaryText
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
