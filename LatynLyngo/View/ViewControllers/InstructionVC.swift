//
//  InstructionVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 27/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit
import WebKit

class InstructionVC: UIViewController {
    
    @IBOutlet weak var headerLBL: UILabel!
    @IBOutlet weak var emptyLBL: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var contentData = "Instruction" //Instruction Privacy Terms Hints Packages
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    // MARK: - Methods
    func initialSettings() {
        webView.isHidden = false
        emptyLBL.isHidden = true
        var url = URLs.instruction
        if contentData == "Privacy" {
            headerLBL.text = "Privacy Policy"
            url = URLs.privacy
        } else if contentData == "Terms" {
            headerLBL.text = "Terms of Use"
            url = URLs.terms
        } else if contentData == "Hints" {
            headerLBL.text = "Helpful Hints"
            url = URLs.grammer
        } else if contentData == "Packages" {
            headerLBL.text = "Packages"
            webView.isHidden = true
            emptyLBL.isHidden = false
        } else {
            headerLBL.text = "Instructions"
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
// MARK: - WKNavigation Delegate
extension InstructionVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimaton()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimaton()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimaton()
    }
}
