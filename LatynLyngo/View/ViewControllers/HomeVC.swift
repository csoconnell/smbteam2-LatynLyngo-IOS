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
    
    var meaningList: [WordMeaningInfo]!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //WordModel.shared.DbUpdated = true
        if !WordModel.shared.DbUpdated {
            activityIndicator.startAnimaton()
            self.view.isUserInteractionEnabled = false
            WordViewModel().GetWordListRequest { (status, message) in
                activityIndicator.stopAnimaton()
                WordModel.shared.DbUpdated = true
                self.view.isUserInteractionEnabled = true
            }
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
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationVC") as! SideMenuNavigationVC
        presentTransitionVC(vc: nextVC)
    }
    @IBAction func modeBTNTapped(_ sender: UIButton) {
        //   0 - Root, 1 - random, 2 - Nonsense
        WordModel.shared.ModeValue = sender.tag
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WordPickerVC") as! WordPickerVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /*
     @IBAction func navigation(_ sender: UIButton) {
     if  sender.tag == 1 {
     //Root
     shared.ModeValue = 0
     } else if sender.tag == 3 {
     //random
     shared.ModeValue = 2
     } else {
     //nonsense
     startLoader(view: self.view, loadtext: "")
     self.view.isUserInteractionEnabled = false
     meaningList = DBManager.shared.loadnonsenceData()
     shared.ModeValue = 1
     }
     loadnavigation()
     }
     func loadnavigation()  {
     let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
     
     if shared.ModeValue == 1 {
     stopLoader()
     self.view.isUserInteractionEnabled = true
     
     shared.meaningList.removeAll()
     shared.meaningList = meaningList
     }
     nextVC.modalPresentationStyle = .fullScreen
     self.present(nextVC, animated: true, completion: nil)
     }
     
     @IBAction func navigationAction(_ sender: UIButton) {
     any mode
     shared.ModeValue = 3
     let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationPassController") as! NavigationPassController
     nextVC.modalPresentationStyle = .fullScreen
     self.present(nextVC, animated: true, completion: nil)
     }
     
     */
    // MARK: - Methods
    func initialViewSettings() {
        if UIDevice.current.orientation.isLandscape {
            slackView.axis = .horizontal
        } else {
            slackView.axis = .vertical
        }
    }
 }
