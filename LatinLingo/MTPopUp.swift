//
//  MTPopUp.swift
//  PopUpExample
//
//  Created by Devubha Manek on 6/17/16.
//  Copyright © 2016 Devubha Manek. All rights reserved.
//

import UIKit

class MTPopUp: UIView
{
    //MARK: - Variable
    //Screen Size
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    //Popup
    var scrollPopup:UIScrollView!
    var viewTransperant:UIView!
    var viewPopUpBG:UIView!
    var viewPopUp:UIView!
    var viewHeaderPopup:UIView!
    var viewFooterPopup:UIView!
    var imageView:UIImageView!
    
    var lblHeader:UILabel!
    var lblMessage:UILabel!
    
    var btnOk:UIButton!
    
    //Swipe Gesture
    var gestureDown:UISwipeGestureRecognizer!
    var gestureUp:UISwipeGestureRecognizer!
    var gestureLeft:UISwipeGestureRecognizer!
    var gestureRight:UISwipeGestureRecognizer!
    var panGesture: UIPanGestureRecognizer!
    
    //Popup Show Hide Direction
    var animation:NSString!
    
    //For Closure
    var handler : ((Int)->())?
    
    //MARK: - Life Cycle
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        //Screen Size
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        //Gesture Down
        gestureDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDown))
        gestureDown.direction = UISwipeGestureRecognizer.Direction.down
        self.addGestureRecognizer(gestureDown)
        
        //Gesture Left
        gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDown))
        gestureLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(gestureLeft)
        
        //Gesture Up
        gestureUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDown))
        gestureUp.direction = UISwipeGestureRecognizer.Direction.up
        self.addGestureRecognizer(gestureUp)
        
        //Gesture Right
        gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDown))
        gestureRight.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(gestureRight)
        
        //Transperant
        viewTransperant = UIView(frame: CGRect(x: 0,y: 0,width: screenWidth,height: screenHeight))
        viewTransperant.backgroundColor = UIColor.black
        viewTransperant.alpha = 0.0
        
        self.addSubview(viewTransperant)
        
        //PopUp Background
        viewPopUpBG = UIView(frame: CGRect(x: 0,y: 0,width: screenWidth,height: screenHeight))
        viewPopUpBG.backgroundColor = UIColor.clear
        self.addSubview(viewPopUpBG)
        
        //Scroll View
        scrollPopup = UIScrollView(frame: CGRect(x: 0,y: 20,width: screenWidth,height: screenHeight - 20))
        viewPopUpBG.addSubview(scrollPopup)
        
        //PopUp
        viewPopUp = UIView(frame: CGRect(x: screenWidth/2 - 140,y: screenHeight/2 - 75 , width: 280 , height: 150))
        viewPopUp.backgroundColor = UIColor(red: 254.0 / 255.0, green: 254.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)
        
        viewPopUp.layer.cornerRadius = 4
        viewPopUp.clipsToBounds = true
        scrollPopup.addSubview(viewPopUp)
        
        imageView = UIImageView(frame: CGRect(x:0,y: 0 , width: viewPopUp.frame.size.width , height: 150))
        imageView.image = #imageLiteral(resourceName: "popup_bg")
        viewPopUp.addSubview(imageView)
        
        
        
        //Popup Header
        viewHeaderPopup = UIView(frame: CGRect(x: 0 ,y: 0 , width: 280 , height: 0))
        viewHeaderPopup.backgroundColor = UIColor.clear
        viewPopUp.addSubview(viewHeaderPopup)
        
        lblHeader = UILabel(frame: CGRect(x: 10 ,y: 0 , width: 260 , height: 0))
        lblHeader.text = ""
        lblHeader.textAlignment = .center
        lblHeader.textColor = UIColor(red: 77.0/255.0, green: 38.0/255.0, blue: 14.0/255.0, alpha: 1)
        lblHeader.numberOfLines = 0
        lblHeader.font =  UIFont(name: "Harrington", size: 25.0)
        viewHeaderPopup.addSubview(lblHeader)
        
        //Popup Footer
        viewFooterPopup = UIView(frame: CGRect(x: 0 ,y: viewPopUp.frame.height - 40 , width: 280 , height: 40))
        viewFooterPopup.backgroundColor = UIColor.clear
        viewPopUp.addSubview(viewFooterPopup)
        
        //Message
        lblMessage = UILabel(frame: CGRect(x: 10 ,y: viewHeaderPopup.frame.size.height + 5 , width: 260 , height: viewPopUp.frame.size.height - viewHeaderPopup.frame.size.height - viewFooterPopup.frame.size.height - 10))
        lblMessage.text = ""
        lblMessage.textAlignment = .center
        lblMessage.numberOfLines = 0
        lblMessage.textColor = UIColor.white
        lblMessage.font = UIFont(name: "Harrington", size: 20.0)
        viewPopUp.addSubview(lblMessage)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Show Popup
    func show(complete : ((Int)->())? , view: UIView,animationType: NSString,strMessage: String,btnArray: NSArray,strTitle: String = "")
    {
        var rectOld:CGRect = CGRect(x: 15 ,y: 0 ,width: 0 ,height: 0)
        var counter = 0
        var isFrameChange:Bool = false
        
        for strBtnTitle in btnArray
        {
            counter += 1
            var widthLabel:CGFloat = ((btnArray.count == 1 && counter == 1) ? (viewPopUp.frame.size.width - 30 ) : (((btnArray.count == 2 &&  counter == 2) || (btnArray.count == 2 && counter == 1)) ? (viewPopUp.frame.size.width / 2) - 30 : (viewPopUp.frame.size.width - 30 )))
            
            let lblButtonNameDummy:UILabel = UILabel(frame: CGRect(x: 0 ,y: 0 ,width: widthLabel ,height: 20))
            lblButtonNameDummy.text = strBtnTitle as? String
            lblButtonNameDummy.numberOfLines = 0
            lblButtonNameDummy.font = UIFont(name: FontName.HelveticaNeue, size: 15)
            
            if widthLabel < lblButtonNameDummy.requiredWidth() || isFrameChange == true
            {
                isFrameChange = true
                widthLabel = (viewPopUp.frame.size.width - 30)
                lblButtonNameDummy.frame = CGRect(x: lblButtonNameDummy.frame.origin.x ,y: lblButtonNameDummy.frame.origin.y ,width: widthLabel ,height: lblButtonNameDummy.frame.size.height)
            }
            
            let rectNew:CGRect = CGRect(x: ((btnArray.count == 1  && counter == 1) ? rectOld.origin.x : ((btnArray.count == 2 && counter == 2 && isFrameChange == false) ? (viewPopUp.frame.size.width / 2) + 15 : rectOld.origin.x)) ,y: rectOld.origin.y ,width: widthLabel,height: lblButtonNameDummy.requiredHeight() + 10)
            
            btnOk = UIButton(frame: rectNew)
            btnOk.backgroundColor = UIColor.clear
            //  btnOk.titleLabel?.textColor = UIColor.red
            btnOk.setTitleColor(UIColor(red: 77.0/255.0, green: 38.0/255.0, blue: 14.0/255.0, alpha: 1), for: UIControl.State())
            btnOk.layer.borderWidth = 0
            btnOk.layer.borderColor = UIColor.black.cgColor
            btnOk.layer.cornerRadius = 0
            btnOk.titleLabel?.font =  UIFont(name: "Harrington", size: 20.0)
            btnOk.titleLabel?.numberOfLines = 0
            btnOk.titleLabel?.textAlignment = .center
            btnOk.addTarget(self, action: #selector(tappedOnOk), for: .touchUpInside)
            btnOk.setTitle(strBtnTitle as? String, for: UIControl.State())
            btnOk.setBackgroundImage(#imageLiteral(resourceName: "alertBtn-BG"), for: UIControl.State())
            btnOk.tag = counter
            viewFooterPopup.addSubview(btnOk)
            
            if (btnArray.count > 2 && btnArray.count != counter) || (isFrameChange == true && btnArray.count != counter)
            {
                rectOld = CGRect(x: rectNew.origin.x ,y: (rectNew.origin.y + rectNew.size.height) + 5 ,width: rectNew.size.width ,height: rectNew.size.height)
            }
            else
            {
                rectOld = rectNew
            }
        }
        
        viewFooterPopup.frame = CGRect(x: viewFooterPopup.frame.origin.x ,y: viewFooterPopup.frame.origin.y , width: viewFooterPopup.frame.size.width , height: rectOld.origin.y + rectOld.size.height + (btnArray.count > 0 ? 10 : 0))
        
        //Set Title
        lblHeader.text = strTitle
        viewHeaderPopup.frame = CGRect(x: viewHeaderPopup.frame.origin.x ,y: viewHeaderPopup.frame.origin.y , width: viewHeaderPopup.frame.size.width , height: (lblHeader.requiredHeight() > 1 ? lblHeader.requiredHeight() + 10 : 0))
        lblHeader.frame = CGRect(x: lblHeader.frame.origin.x ,y: lblHeader.frame.origin.y , width: lblHeader.frame.size.width , height: viewHeaderPopup.frame.size.height)
        
        //Set Popup Message
        lblMessage.text = strMessage
        lblMessage.frame = CGRect(x: lblMessage.frame.origin.x ,y: viewHeaderPopup.frame.size.height + 5 , width: lblMessage.frame.size.width , height: lblMessage.requiredHeight() > 70 ? lblMessage.requiredHeight() : 70)
        
        let popUpHeight:CGFloat = (lblMessage.frame.origin.y + lblMessage.frame.size.height + viewFooterPopup.frame.height + 5)
        
        let y: CGFloat
        if popUpHeight < screenHeight {
            let yStep1 = (lblMessage.frame.origin.y + lblMessage.frame.size.height + viewFooterPopup.frame.size.height) / 2
            let yStep2 = (self.screenHeight/2) - yStep1
            y = yStep2 - 20
        } else {
            y = 10
        }
        
        viewPopUp.frame = CGRect(x: (viewPopUp.frame.origin.x),
                                 y: y,
                                 width: viewPopUp.frame.size.width ,
                                 height: popUpHeight)
        
        viewFooterPopup.frame = CGRect(x: viewFooterPopup.frame.origin.x ,y: viewPopUp.frame.height - viewFooterPopup.frame.size.height , width: viewFooterPopup.frame.size.width , height: viewFooterPopup.frame.size.height)
        
        imageView.frame = CGRect(x:0,y: 0 , width: viewPopUp.frame.size.width , height: popUpHeight)
        
        
        
        if popUpHeight > screenHeight
        {
            scrollPopup.contentSize = CGSize(width: screenWidth, height: popUpHeight + 20)
        }
        
        animation = animationType
        handler = complete
        view.addSubview(self)
        
        //Move Animation
        if  animation.isEqual(to: MTAnimation.TopToMoveCenter as String) || animation.isEqual(to: MTAnimation.BottomToMoveCenter as String) || animation.isEqual(to: MTAnimation.LeftToMoveCenter as String) || animation.isEqual(to: MTAnimation.RightToMoveCenter as String)
        {
            if animation.isEqual(to: MTAnimation.TopToMoveCenter as String)
            {
                self.viewPopUpBG.frame = CGRect(x: 0,y: -self.screenHeight,width: self.screenWidth,height: self.screenHeight)
            }
            else if animation.isEqual(to: MTAnimation.BottomToMoveCenter as String)
            {
                self.viewPopUpBG.frame = CGRect(x: 0,y: self.screenHeight*2,width: self.screenWidth,height: self.screenHeight)
            }
            else if animation.isEqual(to: MTAnimation.LeftToMoveCenter as String)
            {
                self.viewPopUpBG.frame = CGRect(x: -self.screenWidth,y: 0,width: self.screenWidth,height: self.screenHeight)
            }
            else if animation.isEqual(to: MTAnimation.RightToMoveCenter as String)
            {
                self.viewPopUpBG.frame = CGRect(x: self.screenWidth,y: 0,width: self.screenWidth,height: self.screenHeight)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.viewTransperant.alpha = 0.7
                self.viewPopUpBG.frame = CGRect(x: 0,y: 0,width: self.screenWidth,height: self.screenHeight)
            }, completion: { (finished) in
                
            })
        }
            //Fade-In / Fade-Out Animation
        else if animation.isEqual(to: MTAnimation.FadeIn_FadeOut as String)
        {
            self.viewPopUpBG.alpha = 0.0
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.viewTransperant.alpha = 0.7
                self.viewPopUpBG.alpha = 1.0
            }, completion: { (finished) in
            })
        }
            //Zoom-In / Zoom-Out Animation
        else if animation.isEqual(to: MTAnimation.ZoomIn_ZoomOut as String)
        {
            self.viewPopUpBG.transform = CGAffineTransform(scaleX: 0.01, y: 0.01);
            UIView.animate(withDuration: 0.25 ,
                           animations: {
                            self.viewPopUpBG.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                            self.viewTransperant.alpha = 0.7
            },
                           completion: { finish in
                            
                            UIView.animate(withDuration: 0.15){
                                self.viewPopUpBG.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                UIView.animate(withDuration: 0.15){
                                    self.viewPopUpBG.transform = CGAffineTransform.identity
                                }
                            }
            })
        }
            //Expand View Animation
        else if animation.isEqual(to: MTAnimation.ExpandViewAnimation as String)
        {
            let rectOldFrame:CGRect = viewPopUp.frame
            viewPopUp.frame = CGRect(x: viewPopUp.frame.origin.x,y: viewPopUp.frame.origin.y,width: viewPopUp.frame.size.width,height: 0)
            
            UIView.animate(withDuration: 0.25 ,
                           animations: {
                            self.viewPopUp.frame = rectOldFrame
                            self.viewTransperant.alpha = 0.7
            },
                           completion: { finish in
                            
            })
        }
            //Rotation View Animation
        else if animation.isEqual(to: MTAnimation.RotationAnimation as String)
        {
            self.viewPopUpBG.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.viewPopUpBG.rotate360Degrees(duration: 0.25, completionDelegate: nil)
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                self.viewTransperant.alpha = 0.7
                self.viewPopUpBG.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.viewPopUpBG.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
        }
        else
        {
            self.viewPopUpBG.transform = CGAffineTransform(scaleX: 0.01, y: 0.01);
            UIView.animate(withDuration: 0.25 ,
                           animations: {
                            self.viewPopUpBG.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                            self.viewTransperant.alpha = 0.7
            },
                           completion: { finish in
                            UIView.animate(withDuration: 0.1){
                                self.viewPopUpBG.transform = CGAffineTransform.identity
                            }
            })
        }
    }
    //MARK: - Hide Popup
    func hide(_ indexHideDirection: Int,index: Int)
    {
        //Move Animation
        if  animation.isEqual(to: MTAnimation.TopToMoveCenter as String) || animation.isEqual(to: MTAnimation.BottomToMoveCenter as String) || animation.isEqual(to: MTAnimation.LeftToMoveCenter as String) || animation.isEqual(to: MTAnimation.RightToMoveCenter as String)
        {
            var animationDelay:TimeInterval!
            //Move Up
            if indexHideDirection == 1
            {
                animationDelay = 0.35
            }//Move Down
            else if (indexHideDirection == 2)
            {
                animationDelay = 0.35
            }//Move Left
            else if (indexHideDirection == 3)
            {
                animationDelay = 0.25
            }//Move Right
            else if (indexHideDirection == 4)
            {
                animationDelay = 0.25
            }
            
            UIView.animate(withDuration: animationDelay, animations: {
                
                //Move Up
                if indexHideDirection == 1
                {
                    self.viewPopUpBG.frame = CGRect(x: 0,y: -self.screenHeight,width: self.screenWidth,height: self.screenHeight)
                }//Move Down
                else if (indexHideDirection == 2)
                {
                    self.viewPopUpBG.frame = CGRect(x: 0,y: self.screenHeight,width: self.screenWidth,height: self.screenHeight)
                }//Move Left
                else if (indexHideDirection == 3)
                {
                    self.viewPopUpBG.frame = CGRect(x: -self.screenWidth,y: 0,width: self.screenWidth,height: self.screenHeight)
                }//Move Right
                else if (indexHideDirection == 4)
                {
                    self.viewPopUpBG.frame = CGRect(x: self.screenWidth,y: 0,width: self.screenWidth,height: self.screenHeight)
                }
                
                
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewTransperant.alpha = 0.0
                }, completion: { (finished) in
                    if self.handler != nil
                    {
                        self.handler!(index)
                    }
                    self.removeFromSuperview()
                })
            })
        }
            //Fade-In / Fade-Out Animation
        else if animation.isEqual(to: MTAnimation.FadeIn_FadeOut as String)
        {
            UIView.animate(withDuration: 0.2, animations: {
                self.viewPopUpBG.alpha = 0.0
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewTransperant.alpha = 0.0
                }, completion: { (finished) in
                    if self.handler != nil
                    {
                        self.handler!(index)
                    }
                    self.removeFromSuperview()
                })
            })
        }
            //Zoom-In / Zoom-Out Animation
        else if animation.isEqual(to: MTAnimation.ZoomIn_ZoomOut as String)
        {
            UIView.animate(withDuration: 0.1 ,
                           animations: {
                            self.viewPopUpBG.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                            
            },
                           completion: { finish in
                            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                                self.viewTransperant.alpha = 0.0
                                self.viewPopUpBG.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                            }, completion: { (finished) in
                                UIView.animate(withDuration: 0.1, animations: {
                                    self.viewTransperant.alpha = 0.0
                                }, completion: { (finished) in
                                    if self.handler != nil
                                    {
                                        self.handler!(index)
                                    }
                                    self.removeFromSuperview()
                                })
                            })
                            
            })
        }
            //Expand View Animation
        else if animation.isEqual(to: MTAnimation.ExpandViewAnimation as String)
        {
            UIView.animate(withDuration: 0.25 ,
                           animations: {
                            self.viewPopUp.frame = CGRect(x: self.viewPopUp.frame.origin.x,y: self.viewPopUp.frame.origin.y,width: self.viewPopUp.frame.size.width,height: 0)
            },
                           completion: { finish in
                            UIView.animate(withDuration: 0.1, animations: {
                                self.viewTransperant.alpha = 0.0
                            }, completion: { (finished) in
                                if self.handler != nil
                                {
                                    self.handler!(index)
                                }
                                self.removeFromSuperview()
                            })
            })
        }
            //Rotation View Animation
        else if animation.isEqual(to: MTAnimation.RotationAnimation as String)
        {
            self.viewPopUpBG.rotate360Degrees(duration: 0.25, completionDelegate: nil)
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                self.viewPopUpBG.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewTransperant.alpha = 0.0
                }, completion: { (finished) in
                    if self.handler != nil
                    {
                        self.handler!(index)
                    }
                    self.removeFromSuperview()
                })
            })
        }
        else
        {
            UIView.animate(withDuration: 0.2, animations: {
                self.viewPopUpBG.alpha = 0.0
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewTransperant.alpha = 0.0
                }, completion: { (finished) in
                    if self.handler != nil
                    {
                        self.handler!(index)
                    }
                    self.removeFromSuperview()
                })
            })
        }
    }
    //MARK: - Tapped On Button
    @objc func tappedOnOk(sender: UIButton)
    {
        self.hide(2, index: sender.tag)
    }
    //MARK: - Gesture Swipe
    @objc func swipeToDown(_ gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                self.hide(4, index: 0)
                break
            case UISwipeGestureRecognizer.Direction.left:
                self.hide(3, index: 0)
                break
            case UISwipeGestureRecognizer.Direction.down:
                self.hide(2, index: 0)
                break
            case UISwipeGestureRecognizer.Direction.up:
                self.hide(1, index: 0)
                break
            default:
                break
            }
        }
    }
    func recognizePanGesture(sender: UIPanGestureRecognizer)
    {
    }
    //MARK - Touches Override Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("BEGAN")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("MOVED")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ENDED")
    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 3.0)
        rotateAnimation.duration = duration
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
//MARK: - Dynamic Width / Height set
extension UILabel{
    
    func requiredHeight() -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.frame.width,height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
    func requiredWidth() -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: CGFloat.greatestFiniteMagnitude,height: self.frame.height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.width
    }
}
//MARK: - Font Layout
struct FontName
{
    static let HelveticaNeueBoldItalic = "HelveticaNeue-BoldItalic"
    static let HelveticaNeueLight = "HelveticaNeue-Light"
    static let HelveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
    static let HelveticaNeueCondensedBold = "HelveticaNeue-CondensedBold"
    static let HelveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
    static let HelveticaNeueThin = "HelveticaNeue-Thin"
    static let HelveticaNeueMedium = "HelveticaNeue-Medium"
    static let HelveticaNeueThinItalic = "HelveticaNeue-ThinItalic"
    static let HelveticaNeueLightItalic = "HelveticaNeue-LightItalic"
    static let HelveticaNeueUltraLight = "HelveticaNeue-UltraLight"
    static let HelveticaNeueBold = "HelveticaNeue-Bold"
    static let HelveticaNeue = "HelveticaNeue"
    static let HelveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
    static let SatteliteRegular = "Satellite"
    static let SatteliteOblique = "Satellite-Oblique"
}
//MARK: - Animation
struct MTAnimation {
    static let TopToMoveCenter:NSString = "TopToMoveCenter"
    static let BottomToMoveCenter:NSString = "BottomToMoveCenter"
    static let LeftToMoveCenter:NSString = "LeftToMoveCenter"
    static let RightToMoveCenter:NSString = "RightToMoveCenter"
    static let FadeIn_FadeOut:NSString = "FadeIn_FadeOut"
    static let ZoomIn_ZoomOut:NSString = "ZoomIn_ZoomOut"
    static let ExpandViewAnimation:NSString = "ExpandViewAnimation"
    static let RotationAnimation:NSString = "RotationAnimation"
}
