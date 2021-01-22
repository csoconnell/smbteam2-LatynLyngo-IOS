//
//  LoginService.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/16/17.
//  Copyright © 2016 NewAgeSMB. All rights reserved.
//

import UIKit
import Alamofire


protocol LoginServiceResult: class
{
    func LoginServiceResponse(param:NSDictionary)
}

class LoginService: NSObject {
    
    var delegate: LoginServiceResult?
    var shared = SharedInstance.sharedInstance
    
    func LoginServiceCall(serverUrl:NSString)
    {
         Alamofire.request("http://10.10.10.254/latin_lingo/api/client/get_word_list").response {
            response in
            do {
                let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String:AnyObject]
                
                print(responseObject)
                self.delegate?.LoginServiceResponse(param:responseObject as NSDictionary)
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
            
            
        }
        
    }
}
