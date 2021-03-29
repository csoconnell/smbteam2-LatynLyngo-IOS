//
//  URLs.swift
//  Sportable
//
//  Created by NewAgeSMB on 03/08/20.
//  Copyright © 2020 NewAgeSMB. All rights reserved.
//

import UIKit

//let kBaseURLClient = "http://10.10.10.254/latin_lingo/api/"
//let baseURL = "http://newagesme.com/latin_lingo/api/"

let baseURL = "http://ogr.msx.mybluehost.me/latin_lingo/api/"
let baseURLClient = baseURL + "client/"
let baseURLCommon = baseURL + "common/"

struct URLs {
    static let terms = URL(string: baseURLCommon + "terms_of_use")!
    static let privacy = URL(string: baseURLCommon + "privacy_policy")!
    
    static let welcomeMessage = URL(string: baseURLCommon + "welcome_message")!
    static let getWordList = URL(string: baseURLClient + "get_word_list")!
    static let instruction = URL(string: baseURLCommon + "instruction")!
    static let grammer = URL(string: baseURLCommon + "grammer")!
}



