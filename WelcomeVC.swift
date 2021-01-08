//
//  WelcomeVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 05/01/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var contentLBL: UILabel!
    @IBOutlet weak var contentDetailLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentLBL.text = " A Morpheme* based\n Slot~machine* style\n Vocabulary* learning game"
        contentDetailLBL.text = "*morpheme--morph (G) (shape, form)+ -eme (unit, sound)\n\n *slot-machine--a random combination of symbols on a dial, certain combinations create a win\n\n *Vocabulary--vocare (L) to name, call +-ary (of or belonging to, pertaining to)"

    }
    

    // MARK: - Button Actions
    @IBAction func getStartedBTNTapped(_ sender: UIButton) {
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func instructionBTNTapped(_ sender: UIButton) {
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
        secondVC.pushFrom = "WelcomeVC"
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
