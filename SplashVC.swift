//
//  SplashVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 13/01/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (Timer) in
            let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }    
}
