//
//  TabBarController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

class TabBarController: UITabBarController{
    override func viewDidLoad() {
        applyTheme()
    }
    
    private func applyTheme(){
        let theme = ThemeManager.currentTheme()
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: theme.primaryColor], for:.selected)
    }
}
