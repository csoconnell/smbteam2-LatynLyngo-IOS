//
//  passDataVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 3/20/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
class passDataVC: UIViewController,listRefreshDataAgain {
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "passAnyData", sender: self)
    }
    
    func loadDataFunctionAgain() {
        self.navigationController!.popViewController(animated: false)
        self.performSegue(withIdentifier: "passAnyData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view : splitedPickerAny = segue.destination as! splitedPickerAny
        view.delegate=self
    }
}
