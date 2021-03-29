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

    @IBOutlet weak var webView: WKWebView!
    
    var contentData = "Instruction" //Instruction Privacy Terms
    
     // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
     // MARK: - Methods
    func initialSettings() {
        var url = URLs.instruction
        if contentData == "Privacy" {
            url = URLs.privacy
        } else if contentData == "Terms" {
            url = URLs.terms
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
