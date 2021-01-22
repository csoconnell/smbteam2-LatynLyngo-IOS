//
//  LoaderHelper.swift
//  LatinLingo
//
//  Created by smb on 1/13/17.
//  Copyright © 2016 smb. All rights reserved.
//

import UIKit
import NVActivityIndicatorView




let activityViewSize: CGFloat = 35.0
var overLay:UIView = UIView()
var label = UILabel()
var nvactivityIndicator:NVActivityIndicatorView!
var blurEffectView : UIVisualEffectView = UIVisualEffectView()


func startLoader (view: UIView, loadtext: String) {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    blurEffectView.alpha = 0.5
    view.addSubview(blurEffectView)
    if UIDevice.current.orientation.isLandscape {
        overLay.frame = CGRect(x:0,y:0,width:screen_size.height,height:screen_size.width)
        let frame = CGRect(x: view.center.x-20, y: view.center.y-20, width: 40, height: 40)
        nvactivityIndicator = NVActivityIndicatorView(frame: frame,
                                                      type: .ballSpinFadeLoader)
        
    } else {
        overLay.frame = CGRect(x:0,y:0,width:screen_size.width,height:screen_size.height)
        nvactivityIndicator = NVActivityIndicatorView(frame:CGRect(x: view.center.x-20, y: view.center.y-20,width:activityViewSize,height:activityViewSize), type: .ballSpinFadeLoader)
        
    }
    print(screen_size.width)
    
    overLay.backgroundColor = UIColor .clear
    overLay.alpha = 0.5
    
    label = UILabel(frame: CGRect(x:0,y:0,width:400,height: 21))
    label.center = CGPoint(x: view.center.x,y :view.center.y+40 )
    label.textAlignment = NSTextAlignment.center
    
    label.textColor=UIColor.white
    
    
    let animation: CATransition = CATransition()
    animation.duration = 3.0
    animation.type = CATransitionType.fade
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    label.layer.add(animation, forKey: "changeTextTransition")
    label.text = loadtext
    
    view.addSubview(overLay)
    overLay.addSubview(label)
    view.addSubview(nvactivityIndicator)
    view.isUserInteractionEnabled = false
    nvactivityIndicator .startAnimating()
}
func stopLoader()
{
    nvactivityIndicator .stopAnimating()
    nvactivityIndicator .removeFromSuperview()
    overLay .removeFromSuperview()
    label.removeFromSuperview()
    blurEffectView.removeFromSuperview()
    
}
