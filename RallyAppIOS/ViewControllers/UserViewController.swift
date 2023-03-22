//
//  UserViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var fullNameEditText: UITextField!
    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var usernameEditText: UITextField!
    @IBOutlet weak var passwordEditText: UITextField!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
        
    }

    //update db here
    @IBAction func saveChangesBttnPressed(_ sender: UIButton) {
    }
    
    //perform all API log out token actions here
    @IBAction func logOutBttnPressed(_ sender: UIButton) {
    }
    
}
