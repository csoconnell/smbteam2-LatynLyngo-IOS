 //
 //  HomeVC.swift
 //  LatynLyngo
 //
 //  Created by NewAgeSMB on 26/03/21.
 //  Copyright © 2017 NewAgeSMB. All rights reserved.
 //
 
 import UIKit
 
 class HomeVC: UIViewController{
    
    @IBOutlet weak var slackView: UIStackView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var menuBTN: UIButton!
    
    var meaningList: [WordMeaningInfo]!
    let transiton = SlideInTransition()
    var topView: UIView?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.isUserInteractionEnabled = false
        //        menuBTN.isUserInteractionEnabled = false
        //        backBTN.isUserInteractionEnabled = false
        
        UIApplication.shared.beginIgnoringInteractionEvents()
   //  WordModel.shared.DbUpdated = true
        if !WordModel.shared.DbUpdated {
            activityIndicator.startAnimaton()
            WordViewModel().GetWordListRequest { (status, message) in
                activityIndicator.stopAnimaton()
                print(Date())
                WordModel.shared.DbUpdated = true
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            
        } else {
            UIApplication.shared.endIgnoringInteractionEvents()
            //            self.view.isUserInteractionEnabled = true
            //            self.menuBTN.isUserInteractionEnabled = true
            //            self.backBTN.isUserInteractionEnabled = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialViewSettings()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        initialViewSettings()
        
    }
    // MARK: - Button Actions
    
    @IBAction func menuBTNTapped(_ sender: UIButton) {
        //      let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationVC") as! SideMenuNavigationVC
        //        presentTransitionVC(vc: nextVC)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        nextVC.didTapMenuType = { tag in
            self.transitionToNew(tag)
        }
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.transitioningDelegate = self
        present(nextVC, animated: true)
    }
    @IBAction func modeBTNTapped(_ sender: UIButton) {
        //   0 - Root, 1 - random, 2 - Nonsense
        WordModel.shared.ModeValue = sender.tag
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WordPickerVC") as! WordPickerVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    // MARK: - Methods
    func initialViewSettings() {
        if UIDevice.current.orientation.isLandscape {
            slackView.axis = .horizontal
        } else {
            slackView.axis = .vertical
        }
    }
    
    func transitionToNew(_ tag: Int) {
        //           let title = String(describing: menuType).capitalized
        //           self.title = title
        //
        //           topView?.removeFromSuperview()
        //           switch menuType {
        //           case .profile:
        //               let view = UIView()
        //               view.backgroundColor = .yellow
        //               view.frame = self.view.bounds
        //               self.view.addSubview(view)
        //               self.topView = view
        //           case .camera:
        //               let view = UIView()
        //               view.backgroundColor = .blue
        //               view.frame = self.view.bounds
        //               self.view.addSubview(view)
        //               self.topView = view
        //           default:
        //               break
        //           }
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
        if tag == 1 {
            //dismissTransitionVC()
            self.dismiss(animated: true, completion: nil)
        } else if tag == 2 {
            // default - Instruction
        } else if tag == 3 {
            nextVC.contentData = "Hints"
        } else if tag == 4 {
            nextVC.contentData = "Packages"
        } else if tag == 5 {
            nextVC.contentData = "Privacy"
        }  else {
            nextVC.contentData = "Terms"
        }
        if tag != 1 {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
 }
 extension HomeVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
 }
