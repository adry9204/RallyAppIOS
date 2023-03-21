//
//  UserViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var fullNameEditText: UITextField!
    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var usernameEditText: UITextField!
    @IBOutlet weak var passwordEditText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //update db here
    @IBAction func saveChangesBttnPressed(_ sender: UIButton) {
    }
    
    //perform all API log out token actions here
    @IBAction func logOutBttnPressed(_ sender: UIButton) {
    }
    
}
