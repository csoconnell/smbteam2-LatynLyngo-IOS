//
//  ProfileVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/9/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import  SDWebImage
import RJImageLoader

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,PostRequestResult{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    let imagePicker = UIImagePickerController()
    let uploadedImage = PostRequest()
    var loaderStart : Bool = false
    var shared = SharedInstance.sharedInstance
    @IBOutlet weak var userImg: UIImageView!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = self.shared.userFullName as String
        userEmail.text = self.shared.userEmail as String
        userImg.layer.masksToBounds = true
        userImg.contentMode = UIView.ContentMode.scaleAspectFill
        userImg.clipsToBounds = true
        userImg.sd_setImage(with: URL(string: self.shared.userProfilepic as String), placeholderImage: #imageLiteral(resourceName: "no_img"))
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated(){
        if UIDevice.current.orientation.isLandscape {
            if loaderStart{
                stopLoader()
                startLoader(view: self.view, loadtext: "")
            }
        }
        else {
            if loaderStart{
                stopLoader()
                startLoader(view: self.view, loadtext: "")
            }
        }
        
    }
    
    // MARK:- Back Navigation function
    @IBAction func Back(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    // MARK:- Camera functions
    @IBAction func editProfileClicked(_ sender: UIButton) {
        self.showAlertView(withTitle: "Edit Photo", withMessage: "Select Photo")
    }
    
    func camera()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.videoQuality = .typeLow
        present(imagePicker, animated: true, completion: nil)
    }
    
    func photoLibrary()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    // MARK: - UIImagePickerControllerDelegate Methods
    
//    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            userImg.contentMode = .scaleAspectFit
//            userImg.image = pickedImage
//        }
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImg.image = image
            dismiss(animated: true, completion: nil)
            self.uploadedImage.delegate = self
            startLoader(view: self.view, loadtext: "")
            loaderStart = true
            self.uploadedImage.upDateprofile(imageData: userImg.image!)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: AlertView functions
    
    func showAlertView(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            if index == 1{
                self.camera()
            }
            
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Camera","Cancel"],
                                             strTitle: withTitle)
        
    }
    
    func showAlertViewData(withTitle:String,withMessage:String){
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            
        },
                                             view: self.view,
                                             animationType: MTAnimation.TopToMoveCenter,
                                             strMessage: withMessage,
                                             btnArray: ["Done"],
                                             strTitle: withTitle)
        
    }
    
    // MARK:- Server Response Delegate
    func PostResponse(param:NSDictionary)
    {
        stopLoader()
        loaderStart = false
        if param.count > 0 {
            let status =  param.value(forKey: "status") as! Bool
            if (status)
            {
                shared.userProfilepic = param.value(forKey: "image_url") as! NSString
            }else{
                self.showAlertViewData(withTitle: "Message", withMessage: param.value(forKey: "message") as! String)
            }
        }else{
            self.showAlertViewData(withTitle: "Network Error", withMessage: "Please check your network connection")
        }
    }
    
}
