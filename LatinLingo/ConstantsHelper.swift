//
//  ConstantsHelper.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/21/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import Foundation
//let kBaseURLClient = "http://10.10.10.254/latin_lingo/api/client/"
let kBaseURLClient = "http://newagesme.com/latin_lingo/api/client/"
let LOGIN_API = kBaseURLClient + "get_word_list"
//let kBaseURLCommon = "http://10.10.10.254/latin_lingo/api/common/"
let kBaseURLCommon = "http://newagesme.com/latin_lingo/api/common/"
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
