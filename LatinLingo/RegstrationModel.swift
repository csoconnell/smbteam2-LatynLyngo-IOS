//
//  RegstrationModel.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/7/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import Foundation
class RegstrationModel: NSObject
{
    var email : String!
    var name : String!
    var password : String!
    var device_token : String!
    
    init(email: String, name: String, password: String,  device_token: String )
    {
        super.init()
        self.email = email
        self.name = name
        self.password = password
        self.device_token = device_token
    }
    override var description: String
    {
        return "email: \(email)" +
            "password: \(password)" + "username: \(name)" +
        "apns_token: \(device_token)"
    }
    
}
extension RegstrationModel
{
    func RegstrationserviceCallrepesantation() -> NSDictionary
    {
        let parameters:[String: Any] = [
            "function": "registration",
            "parameters": ["email":email,"password":password,"username":name,"apns_token":device_token],
            "token":""
        ]
        
        return parameters as NSDictionary
    }
}
