//
//  LogInViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
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
//
import UIKit

class LogInViewController: UIViewController {

    //the white view that has all the elements inside
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    //TextFields for the credentials
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    
    @IBOutlet weak var rallyLogoImageView: UIImageView!
    @IBOutlet weak var loginScreenTitle: UILabel!
    @IBOutlet weak var loginScreenSubtitle: UILabel!
    @IBOutlet weak var registerTItle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
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
        showLoading()
        let userServices = UserServices()
        userServices.loginUser(
            username: username,
            password: password
        ){ response in
            self.stopLoading()
            if(response.success == 1){
                UserAuth.userId = response.data[0].userID
                UserAuth.token = response.data[0].token
                WebSocketManager.shared.establishConnection(userId: response.data[0].userID)
                NotificationManager.shared.displaySimpleNotification(title: "User Loged in", body: "\(response.data[0].userName)")
                
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "goToHomeScene", sender: self)
                }
            }else{
                DispatchQueue.main.async{
                    AlertManager.makeAlertWithOkButton(
                        title: "Login Failed",
                        message: "Incorrect username or password",
                        viewController: self
                    ){}
                }
            }
        }
    }
    
    func applyTheme(){
        let theme = ThemeManager.currentTheme()
        
        
        loginView.backgroundColor = theme.backgoundColor
        
        if(theme == .boldWhite){
            loginScreenTitle.textColor = theme.primaryTextColor
        }else{
            loginScreenTitle.textColor = theme.secondaryTextColor
        }
       
        loginScreenSubtitle.textColor = theme.standardColor
        
        registerTItle.setAttributedTitle(
            NSAttributedString(
                string: "Dont have an account yet?",
                attributes:
                    [NSAttributedString.Key.foregroundColor: theme.primaryTextColor]
            ), for: .normal)
        
        if(theme == .boldWhite){
            loginButton.tintColor = theme.primaryColor
        }else{
            loginButton.tintColor = theme.secondaryColor
        }
                
        
    }
    
    func showLoading(){
        view.isUserInteractionEnabled = false
        loadingWheel.isHidden = false
    }
    
    func stopLoading(){
        view.isUserInteractionEnabled = true
        loadingWheel.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
