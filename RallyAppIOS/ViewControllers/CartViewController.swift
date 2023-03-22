//
//  CartViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//


import UIKit

class CartViewController: UIViewController {
    var username = ""
    
    @IBOutlet weak var helloLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
    }


}
