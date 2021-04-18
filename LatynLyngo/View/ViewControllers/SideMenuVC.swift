//
//  SideMenuVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 26/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    var didTapMenuType: ((Int) -> Void)?
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Actions
    @IBAction func closeBTNTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            
            self?.didTapMenuType?(1)
        }
        //dismissTransitionVC()
    }
    
    @IBAction func menuBTNTapped(_ sender: UIButton) {
       
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(sender.tag)")
            self?.didTapMenuType?(sender.tag)
        }
       
    }
}
