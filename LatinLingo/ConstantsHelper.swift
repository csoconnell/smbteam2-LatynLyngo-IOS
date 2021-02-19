//
//  ConstantsHelper.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/21/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import Foundation
//let kBaseURLClient = "http://10.10.10.254/latin_lingo/api/"
//let baseURL = "http://newagesme.com/latin_lingo/api/"

let baseURL = "http://ogr.msx.mybluehost.me/latin_lingo/api/"
let kBaseURLClient = baseURL + "client/"
let kBaseURLCommon = baseURL + "common/"

let LOGIN_API = kBaseURLClient + "get_word_list"
let UPLOADED_API = kBaseURLClient + "upload_image"
let UPDATEPROFILE_API = kBaseURLClient + "update_profile"
let CHANGEPASSWORD_API = kBaseURLClient + "change_password"
let LOGOUT_API = kBaseURLClient + "logout"
let CHANGENOTIFICATION_API = kBaseURLClient + "change_notification"
let MYCONTACTS_API = kBaseURLClient + "my_contacts"
let MYCONTACTSREMOVE_API = kBaseURLClient + "remove_contact"
let ADDCONTACTS_API = kBaseURLClient + "add_contacts"
let LISTCONTACTS_API = kBaseURLClient + "contacts"

struct FontHelper {
    static func defaultBoldCorbalFontWithSize(size: CGFloat,fontType :NSString) -> UIFont {
        return UIFont(name: fontType as String, size: CGFloat(SharedInstance.sharedInstance.FontSizePicker))!
    }
    
    static func defaultCorbalFontWithSize(size: CGFloat,fontType :NSString) -> UIFont {
        return UIFont(name: fontType as String, size: CGFloat(SharedInstance.sharedInstance.FontSizePicker))!
    }
    
}
func checkSynonymSuccess() -> Bool {
    //save in user default for every 5th correct answer that the user gets on synonyms, a " confetti gif " has to appear.
    
    let synonymSuccessCount = UserDefaults.standard.object(forKey: "synonymSuccessCount") as? Int ?? 0
    if synonymSuccessCount == 4 {
        UserDefaults.standard.set(0, forKey: "synonymSuccessCount")
        UserDefaults.standard.synchronize()
        return true
    } else {
        UserDefaults.standard.set(synonymSuccessCount + 1, forKey: "synonymSuccessCount")
        UserDefaults.standard.synchronize()
        return false
    }
    
}
