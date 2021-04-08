//
//  CommonData.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 09/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

let appVerion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


var activityIndicator: ActivityIndicatorHelper = ActivityIndicatorHelper(view: UIApplication.shared.keyWindow!)


//Font
let appRegular14Font = UIFont(name: "TrebuchetMS", size: 14) //TrebuchetMS   trebuc
let appRegular24Font = UIFont(name: "TrebuchetMS", size: 24)
let appRegular50Font = UIFont(name: "TrebuchetMS-Bold", size: 20)

//Color
//let AppButtonColor = UIColor(named: "ButtonColor")IconBgColor
    //UIColor(red: 249/255, green: 162/255, blue: 46/255, alpha: 1.0)


func anyToStringConverter(dict: [String:Any], key: String) -> String {
    if let value = dict[key]  {
        if String(describing: value) != "<null>" && String(describing: value) != "" {
            return String(describing: value)
        } else {
            return ""
        }
    } else {
        return ""
    }
}
