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
    
    var contentArray:[NSAttributedString] = []
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
        if UIDevice.current.orientation.isLandscape {
            slackView.axis = .horizontal
        } else {
            slackView.axis = .vertical
        }
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
        
        showContentText()
        if UIDevice.current.orientation.isLandscape {
            slackView.axis = .horizontal
        } else {
            slackView.axis = .vertical
        }
        //super.viewWillTransition(to: size, with: coordinator)
        // view.layoutIfNeeded()
    }
    
    // MARK: - Button Actions
    @IBAction func getStartedBTNTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        //        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        //        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func instructionBTNTapped(_ sender: UIButton) {
        //        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
        //        secondVC.pushFrom = "WelcomeVC"
        //        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    // MARK: - Methods
    func getContentText() {
        pageControl.hidesForSinglePage = true
        activityIndicator.startAnimaton()
        NetworkManager.shared.fetchingResponse(from: URLs.welcomeMessage, parameters: [:], method: .get, encoder: .urlEncoding) { (responseData, responseDic, message, status) in
            activityIndicator.stopAnimaton()
            if let dataObject = responseDic?["data"] as? String {
                self.contentText = dataObject
                self.showContentText()
            }
        }
    }
    
    func showContentText() {
        
        heightOfContentLBL = contentCV.frame.height + 80
        widthOfContentLBL = contentCV.frame.width - 40
        if contentText != "" {
            let contentAttrString = NSAttributedString(string: contentText)
            
            //  print(contentCV.frame)
            
            let totalHeightOfContent = heightForView(text: contentAttrString, frame: CGRect(x: 0, y: 0, width: widthOfContentLBL, height:  CGFloat.greatestFiniteMagnitude))
            print("\(totalHeightOfContent)......\(widthOfContentLBL)......\(heightOfContentLBL)")
            var countOfViews = Int(totalHeightOfContent/heightOfContentLBL)
            if countOfViews == 0 {
                countOfViews = 1
            }
            let stringSplitPosition = contentAttrString.length / countOfViews
            
            let splitedArray = splitAttributedStrings(inputString: contentAttrString, seperator: " ", length: stringSplitPosition)
            print("stringSplitPosition  \(stringSplitPosition)...\(splitedArray.count)")
            self.contentArray.removeAll()
            for word in splitedArray {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html
                ]
                let finalWord = try! NSAttributedString(
                    data: word.string.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                    options: options,
                    documentAttributes: nil)
                self.contentArray.append(finalWord)
            }
            print("contentArray.count....\(self.contentArray.count)")
            self.pageControl.numberOfPages = self.contentArray.count
            contentCV.layoutIfNeeded()
            
            self.contentCV.reloadData()
            if contentArray.count > 0 {
                self.contentCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            }
        }
   }
    
}

// MARK: - CollectionView Delegates
extension WelcomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCVC", for: indexPath) as! WelcomeCVC
        cell.setCellValues(text: contentArray[indexPath.row], row: indexPath.row)
        print("label...\(cell.contentLBL.bounds.size)")
        return cell
    }
}

extension WelcomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}


////        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////
////            return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
////        }
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        return 20
////    }
//
//}
