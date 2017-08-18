//
//  loginModel.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/18/17.
//  Copyright © 2016 NewAgeSMB. All rights reserved.
//

import Foundation

class loginModel: NSObject
{
    var email : String!
    var password : String!
    var device_token : String!
    
    init(email: String, password: String,  device_token: String )
    {
        super.init()
        self.email = email
        self.password = password
        self.device_token = device_token
    }
    override var description: String
    {
        return "email: \(email)" +
            "password: \(password)" +
        "apns_token: \(device_token)"
    }
    
}
extension loginModel
{
    func loginserviceCallrepesantation() -> NSDictionary
    {
        
        let parameters:[String: Any] = [
            "function": "user_login",
            "parameters": ["email":email,"password":password,"apns_token":device_token],
            "token":""
        ]
        
        return parameters as NSDictionary
    }
}
