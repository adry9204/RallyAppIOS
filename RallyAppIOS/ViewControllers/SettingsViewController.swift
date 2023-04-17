//
//  LogInViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 4/14/23.
//  Authors
//  --------------------------------------
//  Adriana Diaz Toress
//  301157161
//
//  Aurela Bala
//  301279255
//  Abraham Alfred Babu
//  Student ID : 301270598
//
//  Pia Mae Obias
//  Student ID: 301283632
//
//  Satender Yadav
//  Student ID: 301293305

import UIKit

struct ThemeData {
    var theme: Theme
    var themeName: String
    
    init(_ theme: Theme, themeName: String) {
        self.theme = theme
        self.themeName = themeName
    }
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var selectThemeLabel: UILabel!
    @IBOutlet weak var themePicker: UIPickerView!
    
    @IBOutlet weak var homeButton: UIButton!
    var theme: Theme!
    
    var pickerData =  Array<ThemeData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        themePicker.delegate = self
        themePicker.dataSource = self
        
        pickerData.append(ThemeData(.light, themeName: "Classic theme"))
        pickerData.append(ThemeData(.dark, themeName: "Classic dark"))
        pickerData.append(ThemeData(.minimalDark, themeName: "Minimal dark"))
        pickerData.append(ThemeData(.boldWhite, themeName: "Contrast White"))
        
        
       
        setSelectedThemeOnThemePicker()
    }

    
    func setSelectedThemeOnThemePicker(){
        if let selectedRow = findSelectedRow(){
            themePicker.selectRow(selectedRow, inComponent: 0, animated: true)
        }
    }
    
    func findSelectedRow() -> Int?{
        for (index, data) in pickerData.enumerated(){
            if(data.theme == theme){
                return index
            }
        }
        return nil
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(
            string: pickerData[row].themeName,
            attributes: [NSAttributedString.Key.foregroundColor : theme.standardTextColor]
        )
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ThemeManager.applyTheme(theme: pickerData[row].theme)
        applyTheme()
        themePicker.reloadComponent(0)
        setSelectedThemeOnThemePicker()
    }
    

    
    
    func applyTheme(){
        theme = ThemeManager.currentTheme()
        
        self.view.backgroundColor = theme.backgoundColor
        
        settingsLabel.textColor = theme.standardTextColor
        selectThemeLabel.textColor = theme.standardTextColor
        
        themePicker.tintColor = theme.secondaryColor
        themePicker.backgroundColor = theme.backgoundColor
        
        homeButton.tintColor = theme.primaryColor
        homeButton.imageView?.tintColor = theme.textOnPrimary
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return theme.statusBar
    }
}
