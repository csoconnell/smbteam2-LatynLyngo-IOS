//
//  SettingsVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/7/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


//
//  SettingsVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/7/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GetRequestByTokenResult {
    @IBOutlet weak var settingsTbl: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    var settigsItems : [String] = []
    var settigsImages : [UIImage] = []
    let logoutCall = GetRequestByToken()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //settigsItems = ["Profile", "Change Password", "Privacy", "Terms of use","Font Settings", "Logout"]
        settigsItems = ["Privacy", "Terms of use","Font Settings"]
        settigsImages = [#imageLiteral(resourceName: "icn2"), #imageLiteral(resourceName: "icn4"), #imageLiteral(resourceName: "dash2")]
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
    }
    
    // MARK: UITYableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settigsItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height/6
    }
    
    // MARK: UITYableView Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingsTbl.dequeueReusableCell(withIdentifier: "SidemenuCell") as! SidemenuCell?
        cell?.titleLbl.text = self.settigsItems[indexPath.row]
        cell?.titleLbl.textAlignment = NSTextAlignment.left
        cell?.titleImg.image = self.settigsImages[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "loadDataPrivacy", sender: self)
        } else if  indexPath.row == 1 {
            self.performSegue(withIdentifier: "loadDataterms", sender: self)
        } else {
            self.performSegue(withIdentifier: "ToFontSettings", sender: self)
        }
        //self.performSegue(withIdentifier: "ToProfile", sender: self)
        // self.performSegue(withIdentifier: "ToChangePassword", sender: self)
        // self.showAlertViewBtn(withTitle: "Logout", withMessage: " Are you sure you want to Logout ?")
    }
    
    // MARK: navigation Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loadDataPrivacy")
        {
            let view : AboutVc = segue.destination as! AboutVc
            view.loadData = 1
        }
        else if(segue.identifier == "loadDataterms")
        {
            let view : AboutVc = segue.destination as! AboutVc
            view.loadData = 0
        }
    }
    
    // MARK: Server response Delegates
    func tokenServiceResponse(param json:NSDictionary)
    {
        if json.count > 0 {
            print(json)
            let status = json.value(forKey: "status") as! Bool
            if status{
                self.showAlertView(withTitle: "Alert", withMessage: json.value(forKey: "message") as! String)
                let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "password")
                let removeSuccessful1: Bool = KeychainWrapper.standard.removeObject(forKey: "email")
                let removeSuccessful2: Bool = KeychainWrapper.standard.removeObject(forKey: "username")
                SharedInstance.sharedInstance.logout()
                print(removeSuccessful,removeSuccessful1,removeSuccessful2)
                _ = navigationController?.popToRootViewController(animated: true)
            }
            else{
                self.showAlertView(withTitle: "Alert", withMessage: json.value(forKey: "message") as! String)
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
    
    func showAlertViewBtn(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            if index == 1 {
                let parameters:[String: Any] = [
                    "function": "logout",
                    "parameters": ["user_id":SharedInstance.sharedInstance.userId],
                    "token":""
                ]
                self.logoutCall.delegate = self
                self.logoutCall.tokenServiceCall(param: parameters as NSDictionary, header: SharedInstance.sharedInstance.userAuthToken! as String)
            }
            
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Yes","No"],
                                             strTitle: withTitle)
        
    }
    
}

