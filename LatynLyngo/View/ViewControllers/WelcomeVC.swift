//
//  WelcomeVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 26/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var slackView: UIStackView!
    @IBOutlet weak var contentCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cellTextViewArray:[UITextView] = []
    var contentText = ""
    var heightOfContentLBL = ((320/896) * screenHeight) - 50
    var widthOfContentLBL = screenWidth - 60
   
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContentText()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(self.checkForUpdate), name: NSNotification.Name(rawValue: "checkUpdate"), object: nil)
        initialViewSettings()
       
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //contentCV.layoutIfNeeded()
        view.layoutIfNeeded()
        // contentDetailTextViewHeightConstraint.constant = (80/667) * UIScreen.main.bounds.height
    }
    // view settings after device orientation changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        initialViewSettings()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.showContentText()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: - Button Actions
    @IBAction func getStartedBTNTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        //        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        //        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func instructionBTNTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
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
    func getContentText() {
        activityIndicator.startAnimaton()
        NetworkManager.shared.fetchingResponse(from: URLs.welcomeMessage, parameters: [:], method: .get, encoder: .urlEncoding) { (responseData, responseDic, message, status) in
            activityIndicator.stopAnimaton()
            let storeVersion = responseDic?["version"] as? String ?? ""
            WordModel.shared.appStoreVersion = storeVersion
            
            if let dataObject = responseDic?["data"] as? String {
                self.contentText = dataObject
                self.showContentText()
            }
            
        }
    }
    @objc func checkForUpdate() {
        let versionCompare = appVerion.compare(WordModel.shared.appStoreVersion, options: .numeric)
        
        if versionCompare == .orderedAscending { //.orderedSame   .orderedDescendin
            print("ask user to update")
            let alert = UIAlertController(title: "New version available !", message: "Download the latest version to continue using", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                UIApplication.shared.open( URLs.appstoreURL, options: [:], completionHandler: nil)
                
            })
            self .present(alert, animated: true, completion: nil)
         }
        
    }
    func showContentText() {
        self.checkForUpdate()
        
        if contentText != "" {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html
            ]
            let contentAttrString = try! NSAttributedString(
                data: contentText.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: options,
                documentAttributes: nil)
           
            let contentFrame = CGRect(x: 0, y: 0, width: contentCV.frame.width - 10, height: contentCV.frame.height - 5)
             let viewFrame = CGRect(x: 0, y: 0, width: contentCV.frame.width , height: contentCV.frame.height )
            let txtSorage = NSTextStorage(attributedString:contentAttrString)
            let layoutManager = NSLayoutManager()
            txtSorage.addLayoutManager(layoutManager)
            cellTextViewArray.removeAll()
            
            var lastTextConainer: NSTextContainer? = nil
            while nil == lastTextConainer {
               for _ in 1...20 {
                let textContainer = NSTextContainer(size:contentFrame.size)
                layoutManager.addTextContainer(textContainer)
                let tv = TextView(frame:viewFrame, textContainer:textContainer)
                tv.didTouchedLink = { (url,tapRange,point) in
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                cellTextViewArray.append(tv)
               }
               lastTextConainer = layoutManager.textContainer(forGlyphAt: layoutManager.numberOfGlyphs - 1, effectiveRange: nil)
            }
            
            let pagesCount = layoutManager.textContainers.firstIndex(of: lastTextConainer!)! + 1
            let emptyViewsCount = 20 - pagesCount
            cellTextViewArray.removeLast(emptyViewsCount)
          
            self.pageControl.numberOfPages = self.cellTextViewArray.count
            contentCV.layoutIfNeeded()
            
            self.contentCV.reloadData()
            if cellTextViewArray.count > 0 {
                self.contentCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            }
        }
    }
   
}

// MARK: - CollectionView Delegates
extension WelcomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellTextViewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCVC", for: indexPath) as! WelcomeCVC
        // cell.setCellValues(text: contentArray[indexPath.row], row: indexPath.row)
       // cell.contentTextView.removeFromSuperview()
        cell.contentView.addSubview(cellTextViewArray[indexPath.row])
        //cell.contentTextView = cellTextViewArray[indexPath.row]
        return cell
    }
}

extension WelcomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}
