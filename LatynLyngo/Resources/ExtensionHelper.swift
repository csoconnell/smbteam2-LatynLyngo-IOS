//
//  ExtensionHelper.swift
//  Latyn Lyngo
//
//  Created by NewAgeSMB on 09/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

// MARK: - UIDevice
extension UIDevice {
    static func vibrate() {
        // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

// MARK: - UIView
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
extension UIView {
  /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
  /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
  func bindFrameToSuperviewBounds() {
    guard let superview = self.superview else {
      print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
      return
    }

    self.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: superview.topAnchor),
      self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
      self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
    ])
  }
}
@IBDesignable class ViewInStack: UIView {

    @IBInspectable var width: CGFloat = 1.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: 170.0)
        // if using in, say, a vertical stack view, the width is ignored
    }

    override func prepareForInterfaceBuilder() {
         invalidateIntrinsicContentSize()
    }
}
@IBDesignable class WelcomeViewInStack: UIView {

    @IBInspectable var height: CGFloat = 1.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.bounds.width, height: height)
        // if using in, say, a vertical stack view, the width is ignored
    }

    override func prepareForInterfaceBuilder() {
         invalidateIntrinsicContentSize()
    }
}
// MARK: - UIViewController
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
// MARK: - UITextView
//@IBDesignable extension UITextView {
//    @IBInspectable var isEmptyRowsHidden: Bool = true {
//        didSet {
//            self.layer.shadowColor = self.shadowColor.cgColor
//        }
//    }
//}
