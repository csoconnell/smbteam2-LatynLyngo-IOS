//
//  ChangePasswordVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/8/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ChangePasswordVC: UIViewController, GetRequestByTokenResult {
    @IBOutlet weak var newPasswrdField: UITextField!
    @IBOutlet weak var oldPasswrdField: UITextField!
    var loaderStart : Bool = false
    let newPasswordCall = GetRequestByToken()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK:- ChangePasswordButton Action
    @IBAction func changePasswordClicked(_ sender: UIButton) {
        self.newPasswrdField.resignFirstResponder()
        self.oldPasswrdField.resignFirstResponder()
        let retrievedStringPassword: String? = KeychainWrapper.standard.string(forKey: "password")
        if  oldPasswrdField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || oldPasswrdField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Current password field is empty")
        }
        else if oldPasswrdField.text != retrievedStringPassword{
            self.oldPasswrdField.text = ""
            self.newPasswrdField.text = ""
            self.showAlertView(withTitle: "Alert", withMessage: "Incorrect Current Password")
        }
        else  if  newPasswrdField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || newPasswrdField.text?.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "New password field is empty")
        }
        else if (newPasswrdField.text!.count) < 5
        {
            self.showAlertView(withTitle: "Alert", withMessage: "New password is too short")
        }
        else
        {
            startLoader(view: self.view, loadtext: "")
            loaderStart = true
            let parameters:[String: Any] = [
                "function": "change_password",
                "parameters": ["password":self.newPasswrdField.text!,"user_id":SharedInstance.sharedInstance.userId],
                "token":""
            ]
            newPasswordCall.delegate = self
            newPasswordCall.tokenServiceCall(param: parameters as NSDictionary, header: SharedInstance.sharedInstance.userAuthToken as! String)
        }
    }
    
    // MARK:- Server Response Delegate
    func tokenServiceResponse(param json:NSDictionary)
    {
        loaderStart = false
        stopLoader()
        if json.count > 0 {
            print(json)
            let status = json.value(forKey: "status") as! Bool
            if status{
                _ = KeychainWrapper.standard.set(self.newPasswrdField.text!, forKey: "password")
                _ = navigationController?.popViewController(animated: true)
            }
            else{
                self.showAlertView(withTitle: "Alert", withMessage: json.value(forKey: "message") as! String)
            }
        }else{
            self.showAlertView(withTitle: "Network Error", withMessage: "Please check your network connection")
        }
    }
    
    // MARK: Back Navigation Function
    @IBAction func back(_ sender: UIButton) {
        _  = navigationController?.popViewController(animated: true)
    }
    
    // MARK: AlertView functions
    func showAlertView(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            //Set your custom code here as per index.
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Done"],
                                             strTitle: withTitle)
        
    }
    
    func showAlertViewDone(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            _ = self.navigationController?.popToRootViewController(animated: true)
            //Set your custom code here as per index.
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Done"],
                                             strTitle: withTitle)
        
    }
    
}
