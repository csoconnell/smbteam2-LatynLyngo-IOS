//
//  PostRequest.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/8/17.
//  Copyright © 2016 NewAgeSMB. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

protocol PostRequestResult: class
{
    func PostResponse(param:NSDictionary)
}

class PostRequest: NSObject
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: PostRequestResult?
    var shared = SharedInstance.sharedInstance
    func upDateprofile(imageData:UIImage)
    {                let user_id = shared.userId
        var parameters = [String:AnyObject]()
        parameters = ["user_id":user_id!]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let inspireImageData = imageData.jpegData(compressionQuality: 0.7)
            multipartFormData.append(inspireImageData!, withName: "image", fileName: "pic.jpg", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append((value.data(using: String.Encoding.utf8.rawValue)!), withName: key)
            }
        }, to: UPLOADED_API , encodingCompletion: { (result) in
            print(result)
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    print(response.result)
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        
                        let json = JSON as! NSDictionary
                        
                        self.delegate?.PostResponse(param: json as NSDictionary)
                        
                    }else{
                        
                        self.delegate?.PostResponse(param: [:])
                        
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                self.delegate?.PostResponse(param: [:])
            }
            
        })
        
    }
    
    
}
