//
//  SharedInstance.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/11/17.
//  Copyright © 2016 NewAgeSMB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SharedInstance: NSObject
{
    
    static let sharedInstance = SharedInstance()
    
    var userId: NSString! = nil
    var userEmail: NSString! = nil
    var userFullName: NSString! = nil
    var userName: NSString! = nil
    var userLastName: NSString! = nil
    var userProfilepic: NSString! = nil
    var userAuthToken: NSString! = ""
    var login1st: NSString! = nil
    var RegisterBakHide: Bool! = false
    var userProfileUpdate: Bool! = false
    var userContantAdd: Bool! = false
    var userCountry: NSString! = nil
    var userState: NSString! = nil
    var userLat: NSString! = nil
    var userLon: NSString! = nil
    var ModeValue: Int! = 0
    var numberOfEmergencyContants: Int! = 0
    var FontSizePicker : CGFloat! = 35
    var fontStylePicker : NSString = "corbel"
    var dataload : NSString = ""
    var dataloadPass : NSString = ""
    var reloadedData : Bool  = false
    var DbUpdated : NSString = ""
    var meaningList: [WordMeaningInfo] = []
    
    func userAuthTokenFun(passString: String)
    {
        userAuthToken = ""
        userAuthToken = passString as NSString!
        
    }
    
    func userLogin(passString: NSDictionary)
    {
        print(passString)
        userId  = ""
        userEmail = ""
        userFullName = ""
        userId = passString["user_id"]  as! NSString
        userEmail = passString["email"] as! NSString
        userFullName = passString["username"] as! NSString
        _ = KeychainWrapper.standard.set(userFullName, forKey: "username")
        userProfilepic = passString["image_url"] as! NSString
        DbUpdated = passString["db_updated"] as! NSString
        print(DbUpdated)
        
        
    }
    
    func logout()
    {
        
        userId = nil
        userEmail  = nil
        userFullName = nil
        userName = nil
        userLastName = nil
        userProfilepic = nil
        userAuthToken = nil
        login1st = nil
        RegisterBakHide = false
        userProfileUpdate = false
        userContantAdd = false
        userCountry = nil
        userState = nil
        userLat = nil
        userLon = nil
    }
    
}
