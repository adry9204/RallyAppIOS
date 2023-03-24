//
//  SignUpViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var passwordTextInput: UITextField!
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var emailInputTextBox: UITextField!
    @IBOutlet weak var firstNameTexIntput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 20
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if(verifyInput()){
            registerUser()
        }
    }
    
    private func registerUser(){
        let userService = UserServices()
        userService.registerUser(
            fullName: firstNameTexIntput.text!,
            username: usernameTextInput.text!,
            email: emailInputTextBox.text!,
            password: passwordTextInput.text!
        ){ response in
            if(response.success == 100){
                DispatchQueue.main.async {
                    AlertManager.makeAlertWithOkButton(
                        title: "Success",
                        message: "User registered successfully",
                        viewController: self
                    ){
                        print("success")
                        self.dismiss(animated: true)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    AlertManager.makeAlertWithOkButton(
                        title: "Failed",
                        message: response.message,
                        viewController: self
                    ){
                        print("failed")
                    }
                }
            }
        }
    }
    
    private func verifyInput() -> Bool{
        if(firstNameTexIntput.text!.isEmpty){
            makeFiledEmptyAlert(fieldName: "name")
            return false
        }
        
        if(emailInputTextBox.text!.isEmpty){
            makeFiledEmptyAlert(fieldName: "email")
            return false
        }
        
        if(usernameTextInput.text!.isEmpty){
            makeFiledEmptyAlert(fieldName: "username")
            return false
        }
        
        if(passwordTextInput.text!.isEmpty){
            makeFiledEmptyAlert(fieldName: "password")
            return false
        }
        
        return true
    }
    
    private func makeFiledEmptyAlert(fieldName: String){
        AlertManager.makeAlertWithOkButton(
            title: "Missing Fields",
            message: "Please enter a \(fieldName)",
            viewController: self
        ){
            print("Ok Pressed")
        }
    }
}

