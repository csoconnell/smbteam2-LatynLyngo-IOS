//
//  ServerRequest.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/8/17.
//  Copyright © 2016 NewAgeSMB. All rights reserved.
//

import UIKit
import Alamofire


protocol GetRequestResult: class
{
    func getServiceResponse(param:NSDictionary,header:NSString)
}

class GetRequest: NSObject
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: GetRequestResult?
    var shared = SharedInstance.sharedInstance
    
    func getServiceCall(param:NSDictionary)
    {
        if Reachability.isConnectedToNetwork() == true {
            Alamofire.request(kBaseURLCommon, method: .post, parameters: param as? [String : AnyObject], encoding: JSONEncoding.default, headers: nil)
                
                .responseJSON
                {response in
                    print(response.result)
                    switch(response.result) {
                    case .success(_):
                        if let data = response.result.value{
                            let json = data as! NSDictionary
                            let status = json.value(forKey: "status") as! Bool
                            if (status)
                            {
                                if let Authentication1 = response.response?.allHeaderFields["AuthToken"] as? String {
                                    self.shared.userAuthTokenFun(passString: Authentication1)
                                    self.delegate?.getServiceResponse(param: json as NSDictionary,header: Authentication1 as NSString)
                                    
                                }else{
                                    self.delegate?.getServiceResponse(param: json as NSDictionary,header: "")
                                }
                            }
                            else{
                                self.delegate?.getServiceResponse(param: json as NSDictionary,header: "")
                            }
                        }else{
                            
                            self.delegate?.getServiceResponse(param: [:],header: "")
                        }
                        break
                        
                    case .failure(_):
                        self.delegate?.getServiceResponse(param: [:],header: "")
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
