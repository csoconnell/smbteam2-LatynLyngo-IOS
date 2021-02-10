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
    @IBOutlet weak var contentDetailTxtView: UITextView!
    @IBOutlet weak var contentDetailTextViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentLBL.text = "A Morpheme based\n Slot-machine style\n Vocabulary learning game"//"A Morpheme* based\n Slot~machine* style\n Vocabulary* learning game"
        contentDetailTxtView.text = """
        Morphemes are the smallest meaningful
        parts of a word. They can be used together
        (prefix, root, suffix) to build words.
        A Few morphemes build a Lot of words.
        Latyn Lyngo is a vocabulary learning app.
        You will use morphemes
        (the smallest meaningful parts of words; prefixes, roots, suffixes)
        to build words.
        Once you know the parts you will be able to build many more words from those parts. Some morpheme roots build hundreds of words.

        You can study by choosing a morpheme and concentrating on that word part.
        You can choose the Random word study.
        Finally, you can use the Nonsense mode and have unrelated morphemes drop into the slots and you get to make up the word.
        Shakespeare was known as The Bard and was famous for making up words. Be the Bard!
        """
        
        let range = NSMakeRange(0, 0)
        contentDetailTxtView.scrollRangeToVisible(range)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
       // contentDetailTextViewHeightConstraint.constant = (80/667) * UIScreen.main.bounds.height
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
