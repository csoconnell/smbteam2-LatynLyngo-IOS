//
//  AboutVc.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/8/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit

class AboutVc: UIViewController {
    
    @IBOutlet weak var headLbl: UILabel!
    @IBOutlet weak var loadWebData: UIWebView!
    var loadData : Int = 0
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL (string: "")
        if loadData == 0 {
            headLbl.text =  "Terms of Use"
            url = NSURL (string: kBaseURLCommon + "terms_of_use")
        }else{
            headLbl.text =  "Privacy"
            url = NSURL (string: kBaseURLCommon + "privacy_policy")
        }
        let requestObj = URLRequest(url: url! as URL)
        loadWebData.loadRequest(requestObj)
    }
    // MARK:- Back Navigation function
    @IBAction func back(_ sender: UIButton) {
        _  = navigationController?.popViewController(animated: true)
    }
}
