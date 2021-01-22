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
 class HomeVC: UIViewController{
    var meaningList: [WordMeaningInfo]!
    @IBOutlet weak var menuButton: UIButton!
    var shared = SharedInstance.sharedInstance
    
    @IBAction func backBTNTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func navigation(_ sender: UIButton) {
        if  sender.tag == 1 {
            startLoader(view: self.view, loadtext: "")
            self.view.isUserInteractionEnabled = false
            meaningList = DBManager.shared.loadnonsenceData()
            shared.ModeValue = 1
        }else if sender.tag == 2  {
            shared.ModeValue = 0
        }
        else{
            shared.ModeValue = 2
            
        }
        loadnavigation()
        
    }
    func loadnavigation()  {
        let messageVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        
        if shared.ModeValue == 1{
            stopLoader()
            self.view.isUserInteractionEnabled = true

            shared.meaningList.removeAll()
            shared.meaningList = meaningList
        }
        self.present(messageVC, animated: false, completion: nil)
    }
    
    @IBAction func navigationAction(_ sender: UIButton) {
        shared.ModeValue = 3
        let messageVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationPassController") as! NavigationPassController
        self.present(messageVC, animated: false, completion: nil)
    }
    
    @IBAction func navigationActionPass(_ sender: UIButton) {
        shared.ModeValue = 3
        let messageVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationPassController") as! NavigationPassController
        self.present(messageVC, animated: false, completion: nil)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
        if (UserDefaults.standard.object(forKey: "insertDB") == nil) || shared.DbUpdated == "1"
        {
            startLoader(view: self.view, loadtext: "")
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
                        UserDefaults.standard.set(true, forKey: "insertDB")
                        UserDefaults.standard.synchronize()
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
