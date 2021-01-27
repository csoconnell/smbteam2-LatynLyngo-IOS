//
//  passVc.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 3/2/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
class passVc: UIViewController,listRefresh {
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "passData", sender: self)
    }
    
    func loadData() {
        self.navigationController!.popViewController(animated: false)
        self.performSegue(withIdentifier: "passData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //   if SharedInstance.sharedInstance.ModeValue == 2 {
            let view : SplitedPicker = segue.destination as! SplitedPicker
            view.delegate=self
      //  }
    }
}
