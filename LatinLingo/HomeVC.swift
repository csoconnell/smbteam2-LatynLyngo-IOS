 //
 //  HomeVC.swift
 //  LatinLingo
 //
 //  Created by NewAgeSMB on 1/11/17.
 //  Copyright © 2017 NewAgeSMB. All rights reserved.
 //
 
 import UIKit
 import CoreData
 import Alamofire
 import AVFoundation
 
 struct DictionaryInfo {
    var word_id: Int!
    var word_database_id: String!
    var word: String!
    var meaning: String!
    var prefex_1: String!
    var prefex_2: String!
    var root: String!
    var suffix_1: String!
    var suffix_2: String!
    var suffix_3: String!
    var synonym: String!
    var part_speech: String!
    
 }
 struct WordMeaningInfo {
    var w_id: Int!
    var word_database_id: String!
    var word: String!
    var meaning: String!
    var type: String!
    var m_cat_id: String!
    var part_speech: String!
    
 }
 extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
 }
 class HomeVC: UIViewController{
    var meaningList: [WordMeaningInfo]!
    @IBOutlet weak var menuButton: UIButton!
    var shared = SharedInstance.sharedInstance
    var audio:AVPlayer!
    
    @IBAction func backBTNTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
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
        //any mode
        shared.ModeValue = 3
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationPassController") as! NavigationPassController
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
      //  if (UserDefaults.standard.object(forKey: "insertDB") == nil) || shared.DbUpdated == "1"
 self.shared.DbUpdated = true
        if !shared.DbUpdated {
            startLoader(view: self.view, loadtext: "")//UIApplication.shared.keyWindow!  self.view
            self.view.isUserInteractionEnabled = false
            Alamofire.request( "\(kBaseURLClient)get_word_list").response {
                response in
                do {
                    print("\(kBaseURLClient)get_word_list")
                    let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String:AnyObject]
                    let param =
                        responseObject as NSDictionary
                    let printDict = param.value(forKey: "data") as! NSDictionary
                    let dict = printDict.value(forKey: "word") as! NSArray
                    let dict1 = printDict.value(forKey: "meaning") as! NSArray
                    if DBManager.shared.createDatabase() {
                        //UserDefaults.standard.set(true, forKey: "insertDB")
                       // UserDefaults.standard.synchronize()
                        self.shared.DbUpdated = true
                        DBManager.shared.insertWordTableData(passDict: dict)
                        DBManager.shared.insertMeaningTableData(passDict: dict1)
                        
                    }
                     
                } catch let error as NSError {
                    print("error: \(error.localizedDescription)")
                }
                stopLoader()
                self.view.isUserInteractionEnabled = true
                
            }
            
        }
    }
    
    // MARK:- Navigation function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "nonsenseMode")
        {
        }
        if(segue.identifier == "toButtonHome")
        {
            shared.ModeValue = 0
        }
        if(segue.identifier == "RandomMode" || segue.identifier == "resetAction")
        {
            shared.ModeValue = 2
            
        }
        
    }
    
 }
