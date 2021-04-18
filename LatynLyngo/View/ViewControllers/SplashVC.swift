//
//  SplashVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 15/04/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  activityIndicator.startAnimaton()
        NetworkManager.shared.fetchingResponse(from: URLs.welcomeMessage, parameters: [:], method: .get, encoder: .urlEncoding) { (responseData, responseDic, message, status) in
            // activityIndicator.stopAnimaton()
            let storeVersion = responseDic?["version"] as? String ?? ""
            WordModel.shared.appStoreVersion = storeVersion
            
            if let dataObject = responseDic?["data"] as? String {
                print(Date())
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                nextVC.contentText = dataObject
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        }
    }
    
}
