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
    
    @IBOutlet weak var loginButton: UIButton!
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
            let defaults = UserDefaults.standard
            defaults.set(usernameTextInput.text, forKey: "Username")
            
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let username = usernameTextInput.text!
        let password = passwordTextInput.text!
        
        loginUser(username: username, password: password)
    }
    
    func loginUser(username: String, password: String){
        let userServices = UserServices()
        Task {
            do{
                let userLoginResponse = try await userServices.loginUser(username: username, password: password)
                if(userLoginResponse.success == 1){
                    UserAuth.userId = userLoginResponse.data[0].userID
                    UserAuth.token = userLoginResponse.data[0].token
                    performSegue(withIdentifier: "goToHomeScene", sender: self)
                }else{
                    createAlertBox(titlte: "Login Failed", message: "Incorrect Username or Password")
                }
            }catch {
                print(error)
                createAlertBox(titlte: "Login Failed", message: "Trouble connecting to server")
            }
        }
    }
    
    func createAlertBox(
        titlte: String,
        message: String
    ){
        // Create new Alert
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func unwindToLogIn(unwindSegue: UIStoryboardSegue){
    
    }
    
}
