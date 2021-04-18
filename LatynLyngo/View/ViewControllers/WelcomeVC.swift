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
    @IBOutlet weak var logoView: WelcomeViewInStack!
    
    var cellTextViewArray:[UITextView] = []
    var contentText = ""
    var heightOfContentLBL = ((320/896) * screenHeight) - 50
    var widthOfContentLBL = screenWidth - 60
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //       self.initialViewSettings()
        //        self.showContentText()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(self.checkForUpdate), name: NSNotification.Name(rawValue: "checkUpdate"), object: nil)
        initialViewSettings()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showContentText()
            self.contentCV.reloadData()
        }
    }
    
    
    // view settings after device orientation changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        initialViewSettings()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.showContentText()
            self.contentCV.reloadData()
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
            logoView.height = 1.0
            slackView.axis = .horizontal
        } else {
            logoView.height = 0.6 // intrinsic content size
            slackView.axis = .vertical
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
            print(UIScreen.main.bounds.width)
            let contentFrame = CGRect(x: 0, y: 0, width: contentCV.bounds.width - 10, height: contentCV.bounds.height - 10)
            let viewFrame = CGRect(x: 0, y: 0, width: contentCV.bounds.width , height: contentCV.bounds.height )
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
            self.contentCV.reloadData()
            
            print(".......")
            //print(".................")
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
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        cell.contentView.addSubview(cellTextViewArray[indexPath.row])
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
}

extension WelcomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}
