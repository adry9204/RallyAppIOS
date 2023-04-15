//
//  ThemeManager.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-04-14.
//

import Foundation
import UIKit

extension UIColor {
    
    static func colorFromHexString(_ hex: String) -> UIColor{
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 1
                    
                    return self.init(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        return UIColor.gray
    }
    
    static var primaryOrange: UIColor{
        return UIColor.colorFromHexString("#FE8E3A")
    }
    
    static var minimalOrange: UIColor{
        return UIColor.colorFromHexString("#CD8A39")
    }
    
    static var minimalDarkBackGround: UIColor{
        return UIColor.colorFromHexString("#121212")
    }
    
    static var minimalLightGreen: UIColor{
        return UIColor.colorFromHexString("#90EE90")
    }
    
    static var darkGreen: UIColor{
        return UIColor.colorFromHexString("#0A333C")
    }
    
    static var minimalLightGray: UIColor{
        return UIColor.colorFromHexString("#D3D3D3")
    }
    
    static var minimalDarkGray: UIColor{
        return UIColor.colorFromHexString("#928f9a")
    }
    
    static var midGreen: UIColor {
        return UIColor.colorFromHexString("#266B1C")
    }
    
    static var yellowGreen: UIColor {
        return UIColor.colorFromHexString("#DBD76A")
    }
}

enum Theme: Int{
    
    case dark, light, boldWhite, minimalDark
    
    var backgoundColor: UIColor {
        switch self {
        case .light:
            return .white
        case.dark:
            return .black
        case .boldWhite:
            return .white
        case .minimalDark:
            return .minimalDarkBackGround
        }
    }
    
    var primaryText: UIColor {
        switch self {
        case.light:
            return.black
        case.dark:
            return.white
        case.boldWhite:
            return.black
        case.minimalDark:
            return .white
        }
    }
    
    var primaryColor: UIColor {
        switch self{
        case .light:
            return .primaryOrange
        case .dark:
            return .primaryOrange
        case .boldWhite:
            return .black
        case .minimalDark:
            return .minimalOrange
        }
    }
    
    
    var textOnPrimary: UIColor {
        return .white
    }
    
    var secondaryTextColor: UIColor {
        switch self {
        case .light:
            return .darkGreen
        case .dark:
            return .primaryOrange
        case .boldWhite:
            return .minimalDarkGray
        case .minimalDark:
            return .minimalLightGreen
        }
    }
    
    var secondaryColor: UIColor {
        switch self{
        case .light:
            return .darkGreen
        case .dark:
            return .midGreen
        case .boldWhite:
            return .minimalLightGray
        case .minimalDark:
            return .minimalLightGreen
        }
    }
    
    var textOnSecondary: UIColor{
        switch self{
        case .light:
            return .white
        case .dark:
            return .yellowGreen
        case .boldWhite:
            return .black
        case .minimalDark:
            return .black
        }
    }
    
    var toggleColor: UIColor{
        switch self{
        case .light:
            return .darkGreen
        case .dark:
            return .minimalLightGreen
        case .boldWhite:
            return .black
        case .minimalDark:
            return .minimalLightGreen
        }
    }
    
    var placeholderColor: UIColor {
        switch self {
        case .light:
            return .minimalDarkGray
        case .dark:
            return .minimalLightGray
        case .boldWhite:
            return .minimalDarkGray
        case .minimalDark:
            return .minimalLightGray
        }
    }
    
    var textfiledOutlines: UIColor {
        switch self {
        case .light:
            return .minimalDarkGray
        case .dark:
            return .minimalLightGray
        case .boldWhite:
            return .minimalDarkGray
        case .minimalDark:
            return .minimalLightGray
        }
    }
    
    var tabBarColor: UIColor {
        switch self {
        case .light:
            return .darkGreen
        case .dark:
            return .primaryOrange
        case .boldWhite:
            return .black
        case .minimalDark:
            return .minimalOrange
        }
    }
    
    var statusBar: UIStatusBarStyle {
        switch self {
        case .light:
            return .darkContent
        case .dark:
            return .lightContent
        case .boldWhite:
            return .darkContent
        case .minimalDark:
            return .lightContent
        }
    }
}


class ThemeManager{
    
    static let SELECTED_THEME_KEY = "selected_theme_key"
    
    static func currentTheme() -> Theme {
        if let storeTheme = (UserDefaults.standard.value(forKey: SELECTED_THEME_KEY) as AnyObject).integerValue {
            return Theme(rawValue: storeTheme)!
        }else{
            return .light
        }
    }
    
    static func applyTheme(theme: Theme){
        UserDefaults.standard.setValue(theme.rawValue, forKey: SELECTED_THEME_KEY)
        UserDefaults.standard.synchronize()
        
        //        let sharedApplication = UIApplication.shared
        //        sharedApplication.delegate?.window??.tintColor = theme.backgoundColor
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = theme.tabBarColor
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
