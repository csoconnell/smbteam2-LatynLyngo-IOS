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
        
        showContentText()
        initialViewSettings()
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
            if let dataObject = responseDic?["data"] as? String {
                self.contentText = dataObject
                self.showContentText()
            }
        }
    }
    
    func showContentText() {
        print("happy h y ".count)
        heightOfContentLBL = contentCV.frame.height - 80.0
        widthOfContentLBL = contentCV.frame.width + 50.0
        if contentText != "" {
            /*  let line2Array = cell.contentTextView.text.components(separatedBy: CharacterSet.newlines)
             let someText = """
             Here is
             some text
             on a large
             number
             of lines
             to be split
             in chunks of 2
             """
             let lineArray = someText.components(separatedBy: CharacterSet.newlines)
             let line = 10
             let size = line // 10
             let newText = stride(from: 0, to: lineArray.count, by: line ).map {
             Array(lineArray [$0 ..< Swift.min($0 + size , lineArray.count)])
             }
             print("newText", newText)
             let new2Text = stride(from: 0, to: line2Array.count, by: line ).map {
             Array(line2Array [$0 ..< Swift.min($0 + size , line2Array.count)])
             }
             print("new22222Text", new2Text)
             
             newText [["Here is", "some text", "on a large", "number", "of lines", "to be split", "in chunks of 2"]]
             new22222Text [["A fun-filled, slot machine style game;   ", "perfect for Middle to High School and ESL learners.", " ", "Memorizing new words is Grueling. ", "Learning a few Root Words is Easy.", "Each Root gives"]]
             new22222Text [["access to many words.", "Use the fun-filled slot machine to grow words from the Root.", "60% of English words derived from Greek and Latin. ", "Seeing the same Root 15-20 times, with various"]]
             
             */
            
            //let contentAttrString = NSAttributedString(string: contentText)
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html
            ]
            let contentAttrString = try! NSAttributedString(
                data: contentText.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: options,
                documentAttributes: nil)
            //  print(contentCV.frame)
            print(contentAttrString.string)
            let totalHeightOfContent = heightForView(text: contentAttrString, frame: CGRect(x: 0, y: 0, width: widthOfContentLBL, height:  CGFloat.leastNonzeroMagnitude), font: appRegular50Font!)
            print("\(totalHeightOfContent)......\(widthOfContentLBL)......\(heightOfContentLBL)")
            var countOfViews = Int(totalHeightOfContent/(heightOfContentLBL))
            if countOfViews == 0 {
                countOfViews = 1
                
            }
            let stringSplitPosition = contentAttrString.length / countOfViews
            
            
            
            
            let splitedArray = splitAttributedStrings(inputString: contentAttrString, seperator: " ", length: stringSplitPosition)
            print("stringSplitPosition  \(stringSplitPosition)...\(splitedArray.count)")
            contentArray = splitedArray
            
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
