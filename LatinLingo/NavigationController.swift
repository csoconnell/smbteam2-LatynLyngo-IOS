//
//  NavigationController.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 3/2/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    var meaningList: [WordMeaningInfo] = []
    var shared = SharedInstance.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    override var shouldAutorotate: Bool {
//        return false
//    }
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        return .landscapeLeft // code in next VC's viewWillAppear to work in iOS 13
//    }
}
