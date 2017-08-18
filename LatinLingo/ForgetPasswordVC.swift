//
//  ForgetPasswordVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/8/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
class ForgetPasswordVC: UIViewController,GetRequestResult {
    @IBOutlet weak var emailField: UITextField!
    let forgotPasswordCall = GetRequest()
    var loaderStart : Bool = false
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    func rotated(){
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
    
    // MARK: ChangePassword Button Action
    @IBAction func changePasswordClicked(_ sender: UIButton) {
        self.emailField.resignFirstResponder()
        if  emailField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" || emailField.text?.characters.count == 0
        {
            self.showAlertView(withTitle: "Alert", withMessage: "Email field is empty")
        }
        else
        {
            if (HelperClass.isValidEmail(testStr: emailField.text!))
            {
                startLoader(view: self.view, loadtext: "")
                loaderStart = true
                let parameters:[String: Any] = [
                    "function": "forgot_password",
                    "parameters": ["email":self.emailField.text!],
                    "token":""]
                forgotPasswordCall.delegate = self
                forgotPasswordCall.getServiceCall(param: parameters as NSDictionary)
            }
            else{
                self.showAlertView(withTitle: "Alert", withMessage: "Email is not valid")
            }
        }
    }
    
    // MARK: Server response Delegates
    func getServiceResponse(param json:NSDictionary,header:NSString)
    {
        loaderStart = false
        stopLoader()
        if json.count > 0 {
            let status = json.value(forKey: "status") as! Bool
            if status{
                self.showAlertView(withTitle: "Alert", withMessage: json.value(forKey: "message") as! String)
            }
            else{
                self.showAlertView(withTitle: "Alert", withMessage: json.value(forKey: "message") as! String)
            }
        }
        else{
            self.showAlertView(withTitle: "Network Error", withMessage: "Please check your network connection")
        }
    }
    
    // MARK: Back navigation Function
    @IBAction func back(_ sender: UIButton) {
        _  = navigationController?.popViewController(animated: true)
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
    
    func showAlertViewDone(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            _ = self.navigationController?.popToRootViewController(animated: true)
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Done"],
                                             strTitle: withTitle)
    }
}
