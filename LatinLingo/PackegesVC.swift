//
//  PackegesVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/7/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
class PackegesVC: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var pushFrom : NSString?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if pushFrom == "instVC"{
            backBtn.isHidden = false
            menuButton.isHidden = true
        }
        else{
            backBtn.isHidden = true
            menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
        }
    }
    @IBAction func back(_ sender: UIButton) {
        _  = navigationController?.popViewController(animated: true)
    }
}
