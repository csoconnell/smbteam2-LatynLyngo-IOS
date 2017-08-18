//
//  InstuctionVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/21/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//


import UIKit
class InstructionVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textView1Height: NSLayoutConstraint!
    @IBOutlet weak var textView2Height: NSLayoutConstraint!
    @IBOutlet weak var textView3Height: NSLayoutConstraint!
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var textView3: UITextView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var instnLbl: UILabel!
    var pushFrom : NSString?
    @IBOutlet weak var webview: UIWebView!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL (string: "")
        if pushFrom == "instVC" || pushFrom == "grammerVC"{
            backBtn.isHidden = false
            menuButton.isHidden = true
            if pushFrom == "instVC"{
                url = NSURL (string: kBaseURLCommon + "instruction")
                instnLbl.text = "Instructions For Use"
            }
            else{
                instnLbl.text = "Grammer For Use"
                url = NSURL (string: kBaseURLCommon + "grammer")
            }
        }
        else{
            url = NSURL (string: kBaseURLCommon + "instruction")
            instnLbl.text = "Instructions For Use"
            backBtn.isHidden = true
            menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
        }
        let requestObj = URLRequest(url: url! as URL)
        webview.loadRequest(requestObj)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.8
        scrollView.maximumZoomScale = 6.0
        NotificationCenter.default.addObserver(self, selector: #selector(self.ViewLoads), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        UITableView.appearance().separatorColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ViewLoads()
    }
    
    func ViewLoads(){
        textView1Height.constant = self.widthForView(text: self.textView1.text, txtView: textView1)
        textView2Height.constant = self.widthForView(text: self.textView2.text, txtView: textView2)
        textView3Height.constant = self.widthForView(text: self.textView3.text, txtView: textView3)
        self.mainViewHeight.constant = 179 + textView1Height.constant + textView2Height.constant + textView3Height.constant+100
    }
    
    func widthForView(text : String, txtView: UITextView) -> CGFloat{
        let label =  UITextView(frame: CGRect(x: 0, y: 0, width: txtView.frame.size.width, height: txtView.frame.size.height))
        label.font = UIFont(name: "Harrington", size: 17.0)
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return self.mainView
    }
    
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}