//
//  LoginViewController.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/3/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

/*
 2021 updates
 WelcomeVC insted of LoginViewController
 Login,sighnup,passwords removed
 */

class LoginViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate,GetRequestResult {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginviewBottom: NSLayoutConstraint!
    @IBOutlet weak var logoCenter: NSLayoutConstraint!
    @IBOutlet weak var logoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    var tapgesture = UITapGestureRecognizer()
    private var currentLoginData : NSDictionary?
    var loaderStart : Bool = false
    let loginCall = GetRequest()
    var shared = SharedInstance.sharedInstance
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.hideViews(_:)))
        self.view.addGestureRecognizer(tapgesture)
        tapgesture.delegate = self
        let retrievedStringEmail: String? = KeychainWrapper.standard.string(forKey: "email")
        let retrievedStringPassword: String? = KeychainWrapper.standard.string(forKey: "password")
        usernameField.text = retrievedStringEmail
        passwordField.text = retrievedStringPassword
        if retrievedStringEmail != nil {
            if retrievedStringPassword != nil {
                LoginClicked(sender: "" as AnyObject)
                
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated(){
        if UIDevice.current.orientation.isLandscape {
            if loaderStart{
                stopLoader()
                startLoader(view: self.view, loadtext: "")
            }
        }
        else {
            if loaderStart{
                stopLoader()
                startLoader(view: self.view, loadtext: "")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.logoCenter.constant = -100
            self.loginviewBottom.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: Login Button Action
    @IBAction func LoginClicked(sender: AnyObject) {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        if  usernameField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || usernameField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Name field is empty")
        }
        else if passwordField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || passwordField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Password field is empty")
        }else if (passwordField.text!.count) < 5
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Password is too short")
        }
        else
        {
            if (HelperClass.isValidEmail(testStr: usernameField.text!))
            {
                startLoader(view: self.view, loadtext: "")
                loaderStart = true
                let loginCalldata =  loginModel(email: usernameField.text!, password: passwordField.text!, device_token: "")
                currentLoginData = loginCalldata.loginserviceCallrepesantation()
                loginCall.delegate = self
                print(currentLoginData! as NSDictionary)
                loginCall.getServiceCall(param: currentLoginData!)
            }else
            {
                self.showAlertView(withTitle: "Alert", withMessage: "Email is not valid")
            }
        }
    }
    
    //MARK: TapGesture
    @objc func hideViews(_ tapgesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // MARK: TextFieldDelegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        return true;
    }
    
    // MARK: Server Response Delegates
    func getServiceResponse(param json:NSDictionary,header:NSString)
    {
        stopLoader()
        loaderStart = false
        if json.count > 0 {
            if header == ""
            {
                let message = json.value(forKey: "message") as! String
                self.showAlertView(withTitle: "Alert", withMessage: message )
            }else
            {
                let passDict = json.value(forKey: "data") as! NSDictionary
                self.shared.userLogin(passString: passDict)
                let saveSuccessful: Bool = KeychainWrapper.standard.set(self.usernameField.text!, forKey: "email")
                let saveSuccessfulpass: Bool = KeychainWrapper.standard.set(self.passwordField.text!, forKey: "password")
                print(saveSuccessful,saveSuccessfulpass)
                usernameField.text = ""
                passwordField.text = ""
                self.performSegue(withIdentifier: "LoginSuccess", sender: self)
            }
        }else{
            self.showAlertView(withTitle: "Network Error", withMessage: "Please check your network connection")
        }
    }
    
    // MARK: AlertView functions
    func showAlertView(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Done"],
                                             strTitle: withTitle)
        
    }
}
