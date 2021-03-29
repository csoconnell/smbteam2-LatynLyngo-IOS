//
//  WelcomeCVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 16/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class WelcomeCVC: UICollectionViewCell {
    
    @IBOutlet weak var contentLBL: UILabel!
    
    func setCellValues(text: NSAttributedString, row: Int) {
        contentLBL.attributedText = text
    }
}
