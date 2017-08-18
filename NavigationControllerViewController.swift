//
//  NavigationControllerViewController.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 3/22/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit

class NavigationControllerViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    
    
}
