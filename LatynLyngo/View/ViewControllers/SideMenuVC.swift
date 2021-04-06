//
//  SideMenuVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 26/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Actions
    @IBAction func closeBTNTapped(_ sender: UIButton) {
        dismissTransitionVC()
    }
    
    @IBAction func menuBTNTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
        if sender.tag == 1 {
            dismissTransitionVC()
        } else if sender.tag == 2 {
            // default - Instruction
        } else if sender.tag == 3 {
            nextVC.contentData = "Hints"
        } else if sender.tag == 4 {
           nextVC.contentData = "Packages"
        } else if sender.tag == 5 {
            nextVC.contentData = "Privacy"
        }  else {
            nextVC.contentData = "Terms"
        }
        if sender.tag != 1 {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
