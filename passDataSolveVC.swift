//
//  passDataSolveVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 3/22/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
class passDataSolveVC: UIViewController ,listRefreshData {
    var letpassData : Bool = false
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "passAnyDataPass", sender: self)
        letpassData = false
    }
    
    func loadDataFunction() {
        self.navigationController!.popViewController(animated: false)
        letpassData = true
        self.performSegue(withIdentifier: "passAnyDataPass", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view : splitedPickerWithReset = segue.destination as! splitedPickerWithReset
        view.delegate=self
        if letpassData{
            let shared = SharedInstance.sharedInstance
            shared.reloadedData = true
            view.reloadedDatafromList = shared.dataload as String
            view.reloadedDatafromKey = shared.dataloadPass as String
        }
    }
}


