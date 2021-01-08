//
//  RegistrationViewController.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/3/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class RegistrationViewController: UIViewController , UIGestureRecognizerDelegate ,GetRequestResult{
    @IBOutlet weak var logoCenter: NSLayoutConstraint!
    @IBOutlet weak var registrationView: UIView!
    @IBOutlet weak var registrViewBottom: NSLayoutConstraint!
    @IBOutlet weak var registrViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwrdField: UITextField!
    @IBOutlet weak var conformPswrdField: UITextField!
    var acceptTerm = false
    var tapgesture = UITapGestureRecognizer()
    private var currentLoginData : NSDictionary?
    let loginCall = GetRequest()
    var shared = SharedInstance.sharedInstance
    var loaderStart : Bool = false
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.hideViews(_:)))
        self.view.addGestureRecognizer(tapgesture)
        tapgesture.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.logoCenter.constant = -120
            self.registrViewBottom.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
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
    
    // MARK:- Back Navigation function
    @IBAction func back(sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpbtnClicked(sender: UIButton) {
        self.nameField.resignFirstResponder()
        self.passwrdField.resignFirstResponder()
        self.conformPswrdField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        if nameField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || nameField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Name field is empty")
        }
        else if  emailField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || emailField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Email field is empty")
        }
        else if (!HelperClass.isValidEmail(testStr: emailField.text!))
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Email is not valid")
        }
        else if passwrdField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" ||
            passwrdField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Password field is empty")
        }
        else if (passwrdField.text!.count) < 5
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Password is too short")
        }
        else if conformPswrdField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" ||
            conformPswrdField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Confirm password field is empty")
        }
        else if conformPswrdField.text! != passwrdField.text!
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Passwords do not match")
        }
        else
        {
            if acceptTerm {
                loaderStart = true
                startLoader(view: self.view, loadtext: "")
                let loginCalldata =  RegstrationModel(email: emailField.text!, name: nameField.text!, password: passwrdField.text!, device_token: "")
                currentLoginData = loginCalldata.RegstrationserviceCallrepesantation()
                loginCall.delegate = self
                loginCall.getServiceCall(param: currentLoginData!)
            }else{
                self.showAlertView(withTitle: "Alert", withMessage: "Please accept the Terms and Conditions")
            }
        }
    }
    
    // MARK: ServerResponse Delegate
    func getServiceResponse(param json:NSDictionary,header:NSString)
    {
        loaderStart = false
        stopLoader()
        if json.count > 0 {
            if header == ""
            {
                let message = json.value(forKey: "message") as! String
                self.showAlertView(withTitle: "Alert", withMessage: message )
            }else
            {
                let passDict = json.value(forKey: "data") as! NSDictionary
                self.shared.userLogin(passString: passDict)
                _ = KeychainWrapper.standard.set(self.emailField.text!, forKey: "email")
                _ = KeychainWrapper.standard.set(self.passwrdField.text!, forKey: "password")
                self.performSegue(withIdentifier: "RegistrationSuccess", sender: self)
            }
        }else{
            self.showAlertView(withTitle: "Network Error", withMessage: "Please check your network connection")
        }
    }
    
    //MARK: TapGesture
    @objc func hideViews(_ tapgesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // MARK: TextfieldDelegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        if textField == nameField {
            emailField.becomeFirstResponder()
        }else if textField == emailField {
            passwrdField.becomeFirstResponder()
        }else if textField == passwrdField {
            conformPswrdField.becomeFirstResponder()
        }
        return true;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "termsNservice"{
            let view : AboutVc = segue.destination as! AboutVc
            view.loadData = 0
        }
    }
    // MARK: Rating Button Action
    @IBAction  func ratingButtonTapped(_ button: UIButton) {
        if acceptTerm {
            acceptTerm = false
            button.setImage(UIImage(named: "unchecked"), for: .normal)
        }else{
            acceptTerm = true
            button.setImage( UIImage(named: "checked"), for: .normal)
        }
    }
    
    //MARK: UIAlertView functions
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
