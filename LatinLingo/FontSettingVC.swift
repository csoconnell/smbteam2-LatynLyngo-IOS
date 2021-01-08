//
//  FontSettingVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/24/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit

class FontSettingVC: UIViewController, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var demoLbl: UILabel!
    @IBOutlet weak var fontPicker: UIPickerView!
    @IBOutlet weak var stylePicker: UIPickerView!
    @IBOutlet weak var ViewBottomConstraint: NSLayoutConstraint!
    
    var sizeBtnClicked = false
    var intvalSize: Int = 0
    var intvalStyle: Int = 0
    var FontSizeArr = ["25", "26", "27","28", "29", "30","31", "32", "33","34", "35", "36","37", "38", "39", "40","41", "42", "43","44", "45", "46","47", "48", "49","50"]
    var fontStyleArr : [String] = ["corbel","AmericanTypewriter-Condensed","TrebuchetMS","Harrington","Verdana","Helvetica","Papyrus-Condensed","GillSans","ChalkboardSE-Regular","ArialRoundedMTBold","BanglaSangamMN"]
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontCustom = FontHelper.defaultBoldCorbalFontWithSize(size: SharedInstance.sharedInstance.FontSizePicker,fontType :SharedInstance.sharedInstance.fontStylePicker)
        demoLbl.font = fontCustom
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.hideViews(_:)))
        self.view.addGestureRecognizer(tapgesture)
        tapgesture.delegate = self
    }
    
    @IBAction func changeFontBtnClicked(_ sender: UIButton) {
        
        let x: CGFloat = SharedInstance.sharedInstance.FontSizePicker
        let stringfnt = "\(x)"
        let endIndex = stringfnt.index(stringfnt.endIndex, offsetBy: -2)
        let truncated = stringfnt.substring(to: endIndex)
        
        if let i = FontSizeArr.index(of:truncated){
            intvalSize = i
        }else{
            intvalSize = 0
        }
        
        print(intvalSize)
        self.stylePicker.isHidden = true
        self.sizeBtnClicked = true
        self.fontPicker.isHidden = false
        self.fontPicker.reloadComponent(0)
        self.fontPicker.selectRow(intvalSize, inComponent: 0, animated: true)
        UIView.animate(withDuration: 1, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.ViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    @IBAction func changeStyleBtnClicked(_ sender: UIButton) {
        let pickData:String = SharedInstance.sharedInstance.fontStylePicker as String
        
        if let i = fontStyleArr.index(of: pickData){
            intvalStyle = i
        }else{
            intvalStyle = 0
        }
        print(intvalStyle)
        self.fontPicker.isHidden = true
        self.stylePicker.isHidden = false
        self.sizeBtnClicked = false
        self.stylePicker.reloadComponent(0)
        self.stylePicker.selectRow(intvalStyle, inComponent: 0, animated: true)
        
        UIView.animate(withDuration: 1, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.ViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.ViewBottomConstraint.constant = -400
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    // MARK:- Back Navigation function
    
    @IBAction func Back(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    //MARK: TapGesture
    @objc func hideViews(_ tapgesture: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.ViewBottomConstraint.constant = -400
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if sizeBtnClicked{
            return FontSizeArr.count
        }else{
            return fontStyleArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if sizeBtnClicked{
            return FontSizeArr[row]
        }else{
            return fontStyleArr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if sizeBtnClicked == true{
            if let n = NumberFormatter().number(from: FontSizeArr[row]) {
                let f = CGFloat(n)
                let fontCustom = UIFont(name:"\(SharedInstance.sharedInstance.fontStylePicker)", size: CGFloat(f))
                print("\(SharedInstance.sharedInstance.fontStylePicker)")
                demoLbl.font = fontCustom
                SharedInstance.sharedInstance.FontSizePicker = CGFloat(f)
                
            }
        }
        else{
            let fontCustom = UIFont(name: fontStyleArr[row], size: SharedInstance.sharedInstance.FontSizePicker)
            demoLbl.font = fontCustom
            SharedInstance.sharedInstance.fontStylePicker = fontStyleArr[row] as NSString
            
        }
        
    }
}

