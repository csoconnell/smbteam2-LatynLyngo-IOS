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
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if sender.tag == 3 {
            
        } else if sender.tag == 4 {
           
        } else if sender.tag == 5 {
            nextVC.contentData = "Privacy"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }  else {
            nextVC.contentData = "Terms"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        /*
         if indexPath.row == 0 {
         self.performSegue(withIdentifier: "toHome", sender: self)
         } else if indexPath.row == 1 {
         //self.performSegue(withIdentifier: "toSettings", sender: self)
         self.performSegue(withIdentifier: "toInstuctions", sender: self)
         } else if indexPath.row == 2 {
         self.performSegue(withIdentifier: "toPackage", sender: self)
         } else if indexPath.row == 3 {
         let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVc") as! AboutVc
         secondVC.loadData = 1
         self.navigationController?.pushViewController(secondVC, animated: true)
         } else if indexPath.row == 4 {
         let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVc") as! AboutVc
         secondVC.loadData = 0
         self.navigationController?.pushViewController(secondVC, animated: true)
         }
         */
    }
}
