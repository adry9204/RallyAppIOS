//
//  AddAddressViewControllerTheme.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension AddAddressViewController{
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        view.backgroundColor = theme.backgoundColor
        addAddressTitle.textColor = theme.standardTextColor
        
        setUITextFieldTheme(addressName, theme: theme)
        setUITextFieldTheme(addressLine1, theme: theme)
        setUITextFieldTheme(addressLine2, theme: theme)
        setUITextFieldTheme(addressCountry, theme: theme)
        setUITextFieldTheme(addressProvince, theme: theme)
        setUITextFieldTheme(addressPostalCode, theme: theme)
        
        saveButton.tintColor = theme.primaryColor
        saveButton.setTitleColor(theme.textOnPrimary, for: .normal)
        
        cancelButton.tintColor = theme.secondaryColor
        saveButton.setTitleColor(theme.textOnSecondary, for: .normal)
    }
    
    func setUITextFieldTheme(_ uiTExtField: UITextField, theme: Theme){
        uiTExtField.backgroundColor = theme.backgoundColor
        uiTExtField.textColor = theme.standardTextColor
        uiTExtField.tintColor = theme.primaryColor
        uiTExtField.attributedPlaceholder = NSAttributedString(
            string: uiTExtField.placeholder!,
            attributes:
                [NSAttributedString.Key.foregroundColor: theme.placeholderColor]
        )
        uiTExtField.layer.borderColor = theme.textfiledOutlines.cgColor
        uiTExtField.layer.borderWidth = 1.0
        uiTExtField.layer.cornerRadius = 10.0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        let theme = ThemeManager.currentTheme()
        return theme.statusBar
    }
}
