//
//  SideMenuVC.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 2/6/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //let sideMenuItems: [String] = ["Select mode", "Settings", "Packages", "Instructions"]
    let sideMenuItems: [String] = ["Select mode", "Instructions", "Packages", "Privacy", "Terms of use"]
    let  settigsImages : [UIImage] = [#imageLiteral(resourceName: "dash1"), #imageLiteral(resourceName: "dash4"), #imageLiteral(resourceName: "dash3"), #imageLiteral(resourceName: "icn2"), #imageLiteral(resourceName: "icn4")]
    @IBOutlet var tableView: UITableView!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UITableView.appearance().separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: UITableviewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sideMenuItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: UITableviewDelegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SidemenuCell") as! SidemenuCell
        cell.titleLbl.text = self.sideMenuItems[indexPath.row]
        cell.titleLbl.textAlignment = NSTextAlignment.right
        cell.titleImg.image = self.settigsImages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "toHome", sender: self)
        } else if indexPath.row == 1 {
            //self.performSegue(withIdentifier: "toSettings", sender: self)
            self.performSegue(withIdentifier: "toInstuctions", sender: self)
        } else if indexPath.row == 2 {
            self.performSegue(withIdentifier: "toPackage", sender: self)
        } else if indexPath.row == 3 {
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVc") as! AboutVc
            secondVC.loadData = 1
            self.navigationController?.pushViewController(secondVC, animated: true)
        } else if indexPath.row == 4 {
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVc") as! AboutVc
            secondVC.loadData = 0
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
