//
//  TextViewVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 08/04/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

func lend<T> (closure:(T)->()) -> T where T:NSObject {
    let orig = T()
    closure(orig)
    return orig
}

class TextViewVC: UIViewController {
    
    @IBOutlet var tv : UITextView!
    @IBOutlet var tv2 : UITextView!
    var lm : NSLayoutManager!
    var ts : NSTextStorage!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NetworkManager.shared.fetchingResponse(from: URLs.welcomeMessage, parameters: [:], method: .get, encoder: .urlEncoding) { (responseData, responseDic, message, status) in
            
           if let dataObject = responseDic?["data"] as? String {
               let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                              .documentType: NSAttributedString.DocumentType.html
                          ]
                          let contentAttrString = try! NSAttributedString(
                              data: dataObject.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                              options: options,
                              documentAttributes: nil)
            var which : Int { return 1 }
                    switch which {
                    case 1:
                        
                        let r = self.tv.frame
                        let r2 = self.tv2.frame
                        
                        let ts1 = NSTextStorage(attributedString:contentAttrString)
                        let lm1 = NSLayoutManager()
                        ts1.addLayoutManager(lm1)
                        let tc1 = NSTextContainer(size:r.size)
                        lm1.addTextContainer(tc1)
                        let tv = UITextView(frame:r, textContainer:tc1)
            //            tv.scrollEnabled = false
                        
                        let tc2 = NSTextContainer(size:r2.size)
                        lm1.addTextContainer(tc2)
                        let tv2 = UITextView(frame:r2, textContainer:tc2)
            //            tv2.scrollEnabled = false
                        
                        self.tv.removeFromSuperview()
                        self.tv2.removeFromSuperview()
                        tv.backgroundColor = .yellow
                        tv2.backgroundColor = .yellow
                        self.view.addSubview(tv)
                        self.view.addSubview(tv2)
                        self.tv = tv
                        self.tv2 = tv2
                        
                    case 2:
                        let r = self.tv.frame
                        let r2 = self.tv2.frame
                        
                        let ts1 = NSTextStorage(attributedString:contentAttrString)
                        let lm1 = NSLayoutManager()
                        ts1.addLayoutManager(lm1)
                        let lm2 = NSLayoutManager()
                        ts1.addLayoutManager(lm2)
                        
                        let tc1 = NSTextContainer(size:r.size)
                        let tc2 = NSTextContainer(size:r2.size)
                        lm1.addTextContainer(tc1)
                        lm2.addTextContainer(tc2)
                        
                        let tv = UITextView(frame:r, textContainer:tc1)
                        let tv2 = UITextView(frame:r2, textContainer:tc2)

                        self.tv.removeFromSuperview()
                        self.tv2.removeFromSuperview()
                        tv.backgroundColor = .yellow
                        tv2.backgroundColor = .yellow
                        self.view.addSubview(tv)
                        self.view.addSubview(tv2)
                        self.tv = tv
                        self.tv2 = tv2

                    default:break
                    }
            }
            
        }
//        let path = Bundle.main.path(forResource: "brillig", ofType: "txt")!
//        let s = try! String(contentsOfFile:path)
//     //   let s2 = s.replacingOccurrences(of:"\n", with: "")
//        let contentAttrString = NSMutableAttributedString(string:s, attributes:[
//            .font: UIFont(name:"GillSans", size:14)!
//            ])
//
//        contentAttrString.addAttribute(.paragraphStyle,
//            value:lend() {
//                (para:NSMutableParagraphStyle) in
//                para.alignment = .left
//                para.lineBreakMode = .byWordWrapping
//                para.hyphenationFactor = 1
//            },
//            range:NSMakeRange(0,1))
        
        
    }

}
