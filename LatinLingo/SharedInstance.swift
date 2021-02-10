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
    
    var userId: NSString = ""
    var userEmail: NSString = ""
    var userFullName: NSString = ""
    var userName: NSString = ""
    var userLastName: NSString = ""
    var userProfilepic: NSString = ""
    var userAuthToken: NSString? = ""
    var login1st: NSString = ""
    var RegisterBakHide: Bool! = false
    var userProfileUpdate: Bool! = false
    var userContantAdd: Bool! = false
    var userCountry: NSString = ""
    var userState: NSString = ""
    var userLat: NSString = ""
    var userLon: NSString = ""
    var ModeValue: Int = 0
    var numberOfEmergencyContants: Int = 0
    var FontSizePicker : CGFloat = 35
    var fontStylePicker : NSString = "TrebuchetMS" //"corbel"
    var dataload : NSString = ""
    var dataloadPass : NSString = ""
    var reloadedData : Bool  = false
    var DbUpdated : NSString = ""
    var meaningList: [WordMeaningInfo] = []
    
    func userAuthTokenFun(passString: String)
    {
        userAuthToken = ""
        userAuthToken = passString as NSString?
        
    }
    
    func userLogin(passString: NSDictionary)
    {
        print(passString)
        userId  = ""
        userEmail = ""
        userFullName = ""
        userId = passString["user_id"]  as? NSString ?? ""
        userEmail = passString["email"] as? NSString ?? ""
        userFullName = passString["username"] as? NSString ?? ""
        _ = KeychainWrapper.standard.set(userFullName ?? "", forKey: "username")
        userProfilepic = passString["image_url"] as? NSString ?? ""
        DbUpdated = passString["db_updated"] as? NSString ?? ""
        print(DbUpdated)
        
        
    }
    
    func logout()
    {
        
        userId = ""
        userEmail  = ""
        userFullName = ""
        userName = ""
        userLastName = ""
        userProfilepic = ""
        userAuthToken = ""
        login1st = ""
        RegisterBakHide = false
        userProfileUpdate = false
        userContantAdd = false
        userCountry = ""
        userState = ""
        userLat = ""
        userLon = ""
    }
    
}
