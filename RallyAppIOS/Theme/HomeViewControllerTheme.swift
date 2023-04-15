//
//  HomeViewControllerThemeHelper.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension HomeViewController{

    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        self.view.backgroundColor = theme.backgoundColor
        self.helloLabel.textColor = theme.primaryText
        self.homeViewControllerHeaderTagLine.textColor = theme.primaryText
        self.rallyTableView.backgroundColor = theme.backgoundColor
        rallyTableView.separatorColor = theme.primaryText
        homeViewControllerSettingsButton.tintColor = theme.primaryText
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
