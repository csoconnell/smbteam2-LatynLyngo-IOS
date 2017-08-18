//
//  GetRequestByToken.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/8/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import Alamofire
protocol GetRequestByTokenResult: class
{
    
    func tokenServiceResponse(param:NSDictionary)
}

class GetRequestByToken: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: GetRequestByTokenResult?
    var shared = SharedInstance.sharedInstance
    
    func tokenServiceCall(param:NSDictionary, header:String)
    {
        if Reachability.isConnectedToNetwork() == true {
            
            Alamofire.request(kBaseURLClient, method: .post, parameters: param as? [String : AnyObject], encoding: JSONEncoding.default, headers: ["AuthToken":header as String]).validate(statusCode: 200 ..< 300).responseJSON { response in
                
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        let json = data as! NSDictionary
                        self.delegate?.tokenServiceResponse(param: json as NSDictionary)
                        
                        
                        
                    }else{
                        self.delegate?.tokenServiceResponse(param: [:])
                        
                    }
                    break
                    
                case .failure(_):
                    
                    self.delegate?.tokenServiceResponse(param: [:])
                    
                    
                    if let error = response.result.error as? URLError {
                        print("URLError occurred: \(error)")
                    } else {
                        print("Unknown error: \(response.result.error)")
                    }
                    break
                    
                }
                
            }
            
            
        }
        
        
    }
}
