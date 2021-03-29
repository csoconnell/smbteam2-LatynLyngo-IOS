//
//  ExtensionHelper.swift
//  Latyn Lyngo
//
//  Created by NewAgeSMB on 09/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

extension UIDevice {
    static func vibrate() {
        // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
extension UIViewController {
    
    func presentTransitionVC(vc: UINavigationController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        vc.modalPresentationStyle = .overCurrentContext
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false)
    }
    
    func dismissTransitionVC() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    @IBAction func backBTNTapped(_ sender: Any) {
        if self.isBeingPresented {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
