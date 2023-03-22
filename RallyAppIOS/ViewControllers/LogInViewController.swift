//
//  LogInViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//

import UIKit

class LogInViewController: UIViewController {

    //the white view that has all the elements inside
    @IBOutlet weak var containerView: UIView!
    
    //TextFields for the credentials
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 15
 
    }
    
    //checking the credential before loging in
    //sending the username to the Home Scene
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeScene" {
            
            //check if credentials are good here
            
            //storing the username in Defaults
            let defaults = UserDefaults.standard
            defaults.set(usernameTextInput.text, forKey: "Username")
            
        }
    }

    @IBAction func unwindToLogIn(unwindSegue: UIStoryboardSegue){
    
    }
    
}
