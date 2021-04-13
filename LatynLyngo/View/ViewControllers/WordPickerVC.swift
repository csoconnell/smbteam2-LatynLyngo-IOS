//
//  WordPickerVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 26/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit
import SDWebImage

class WordPickerVC: UIViewController {
    
    @IBOutlet weak var slackView: UIStackView!
    @IBOutlet weak var slackViewYConstraint: NSLayoutConstraint!
    @IBOutlet weak var prefix1View: UIView!
    @IBOutlet weak var prefix2View: UIView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var suffix2View: UIView!
    @IBOutlet weak var suffix3View: UIView!
    @IBOutlet weak var prefix2VerticalView: UIView!
    @IBOutlet weak var suffix2VerticalView: UIView!
    @IBOutlet weak var p1MeaningView: UIView!
    @IBOutlet weak var p2MeaningView: UIView!
    @IBOutlet weak var rootMeaningView: UIView!
    @IBOutlet weak var s2MeaningView: UIView!
    @IBOutlet weak var s3MeaningView: UIView!
    @IBOutlet weak var wordDetailView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var wordDetailLBL: UILabel!
    @IBOutlet weak var synonymLBL: UILabel!
    @IBOutlet weak var noSynonymLBL: UILabel!
    @IBOutlet weak var p1MeaningTextView: UITextView!
    @IBOutlet weak var p2MeaningTextView: UITextView!
    @IBOutlet weak var rootMeaningTextView: UITextView!
    @IBOutlet weak var s2MeaningTextView: UITextView!
    @IBOutlet weak var s3MeaningTextView: UITextView!
    @IBOutlet weak var wordDetailTextView: UITextView!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var picker3: UIPickerView!
    @IBOutlet weak var picker4: UIPickerView!
    @IBOutlet weak var picker5: UIPickerView!
    @IBOutlet weak var synonymCV: UICollectionView!
    
    @IBOutlet weak var prefixOverlayBTN: UIButton!
    @IBOutlet weak var rootOverlayBTN: UIButton!
    @IBOutlet weak var suffixOverlayBTN: UIButton!
    @IBOutlet weak var wordDetailBTN: UIButton!
    @IBOutlet weak var resetBTN: UIButton!
    @IBOutlet weak var meaningBTN: UIButton!
    @IBOutlet weak var listBTN: UIButton!
    @IBOutlet weak var synonymBTN: UIButton!
    @IBOutlet weak var closeBTNTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordDetailViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordDetailViewHeightConstraint: NSLayoutConstraint!
    
    var items: [DictionaryInfo]!
    var allMovies: [DictionaryInfo] = []
    var synonymListArray : NSMutableArray = []
    var partofSpeechDict : NSDictionary = ["n.":"Noun","adj.":"Adjective","v.":"Verb","":"Adverb","":"Pronoun","":" Preposition","":"Conjunction ","":"Interjection"]
    var nonsencePrefixArr = [String]()
    var nonsenceRootArr = [String]()
    var nonsenceSuffixArr = [String]()
    var pickerdataPrefix1 = [String]()
    var pickerdataPrefix2 = [String]()
    var pickerdataRoot = [String]()
    var pickerdataSuffix3 = [String]()
    var pickerdataSuffix2 = [String]()
    var savedRootArray = [String]()
    var wordArray = ["","","","",""]
    
    var resultWord = ""
    var rootValue = ""
    var prefix1Value = ""
    var prefix2Value = ""
    var suffix2Value = ""
    var suffix3Value = ""
    var randomCounter = 0
    var synonymIndex = 0
    var boolSuffixFirst = false
    var boolPrefixFirst = false
    var synonymSelected = false
    var synonymDidStatus = false
    // for spin action
    var prefixSpinned = false
    var rootSpinned = false
    var suffixSpinned = false
    var prefixValueSelected = false
    var rootValueSelected = false
    var suffixValueSelected = false
    
    // 0 - Root, 1 - random, 2 - Nonsense
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialViewSettings()
    }
    
    // view settings after device orientation changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        initialViewSettings()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // slackView.spacing = 10
        // https://stackoverflow.com/questions/54866829/ios-stackviews-with-proportionally-filled-subviews-and-intrinsic-width-not-behav
    }
    
    // MARK: - Button Actions
    @IBAction func SpinBTNTapped(_ sender: UIButton) {
         if WordModel.shared.ModeValue == 1 {// random mode
            showRandomMovie()
            // randomTimer.invalidate()
            
        } else if WordModel.shared.ModeValue == 2 {// nonsense mode
            rootBtnAction()
            prefixBtnAction()
            suffixBtnAction()
        } else if WordModel.shared.ModeValue == 0 && prefixOverlayBTN.isHidden == false && rootOverlayBTN.isHidden == false && suffixOverlayBTN.isHidden == false {
            // root mode , Initially if user hits spin, nothing should happen
            
        } else {// root mode with any word
            
            print("spin............\(prefixValueSelected)......\(rootValueSelected)......\(suffixValueSelected)")
            if !prefixValueSelected {
                prefixSpinned = true
                prefixBtnAction()
            }
            if !suffixValueSelected {
                suffixSpinned = true
                suffixBtnAction()
            }
            if prefixValueSelected && suffixValueSelected && rootValueSelected {
                (prefixSpinned, suffixSpinned, rootSpinned)  = (true,true,true)
                (prefixValueSelected, rootValueSelected, suffixValueSelected)  = (false,false,false)
                rootBtnAction()
                prefixBtnAction()
                suffixBtnAction()
            }
            
        }
        
    }
    @IBAction func resetBTNTapped(_ sender: UIButton) {
        resetWith(root: false)
    }
    @IBAction func instructionBTNTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "InstructionVC") as! InstructionVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func prefixOverlayBTNTapped(_ sender: UIButton) {
        prefixSpinned = false
        prefixValueSelected = true
        prefixBtnAction()
    }
    @IBAction func rootOverlayBTNTapped(_ sender: UIButton) {
        rootSpinned = false
        rootValueSelected = true
        rootBtnAction()
    }
    @IBAction func suffixOverlayBTNTapped(_ sender: UIButton) {
        suffixSpinned = false
        suffixValueSelected = true
        suffixBtnAction()
    }
    @IBAction func wordMeaningBTNTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            p1MeaningView.isHidden = !p1MeaningView.isHidden
        } else if sender.tag == 2 {
            p2MeaningView.isHidden = !p2MeaningView.isHidden
        } else if sender.tag == 3 {
            rootMeaningView.isHidden = !rootMeaningView.isHidden
        } else if sender.tag == 4 {
            s2MeaningView.isHidden = !s2MeaningView.isHidden
        } else  {
            s3MeaningView.isHidden = !s3MeaningView.isHidden
        }
        var wordMeaning = ""
        DBManager.shared.loadWordmeaning(withWord: wordArray[sender.tag - 1], completionHandler: { (movie) in
            // DispatchQueue.main.async {
            if movie != nil {
                wordMeaning = movie?.meaning ?? ""
                if movie?.part_speech != "" {
                    wordMeaning = wordMeaning + " (\(movie?.part_speech ?? ""))"
                }
            }
            //}
        })
        if sender.tag == 1 {
            p1MeaningTextView.text = wordMeaning
        } else if sender.tag == 2 {
            p2MeaningTextView.text = wordMeaning
        } else if sender.tag == 3 {
            rootMeaningTextView.text = wordMeaning
        } else if sender.tag == 4 {
            s2MeaningTextView.text = wordMeaning
        } else  {
            s3MeaningTextView.text = wordMeaning
        }
    }
    
    @IBAction func closeBTNTapped(_ sender: UIButton) {
        // prefix1Img.layer.removeAllAnimations()
       
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            
            if  self.wordDetailViewTopConstraint.constant == UIScreen.main.bounds.height + 15 {
                self.closeBTNTopConstraint.constant = 0
                self.wordDetailViewTopConstraint.constant = 150
                self.view.layoutIfNeeded()
            } else {
                self.wordDetailViewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }, completion: { (status) in
            if self.wordDetailViewTopConstraint.constant == 0 {
                self.wordDetailBTN.isHidden = false
            }
            
        })
    }
    @IBAction func wordDetailBTNTapped(_ sender: UIButton) {
        wordform()
    }
    
    @IBAction func ShowDetailsOfWord(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            meaningBTN.isSelected = true
            self.meaningBTN.borderColor = UIColor(named: "ButtonColor")
            listBTN.isSelected = false
            listBTN.borderColor = UIColor.white
            synonymBTN.isSelected = false
            synonymBTN.borderColor = UIColor.white
        case 2:
            meaningBTN.isSelected = false
            meaningBTN.borderColor = UIColor.white
            listBTN.isSelected = true
            listBTN.borderColor = UIColor(named: "ButtonColor")
            synonymBTN.isSelected = false
            synonymBTN.borderColor = UIColor.white
        case 3:
            meaningBTN.isSelected = false
            meaningBTN.borderColor = UIColor.white
            listBTN.isSelected = false
            listBTN.borderColor = UIColor.white
            synonymBTN.isSelected = true
            synonymBTN.borderColor = UIColor(named: "ButtonColor")
        default:
            meaningBTN.isSelected = false
            meaningBTN.borderColor = UIColor.white
            listBTN.isSelected = false
            listBTN.borderColor = UIColor.white
            synonymBTN.isSelected = false
            synonymBTN.borderColor = UIColor.white
        }
        
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
            self.closeBTNTopConstraint.constant = 30
            self.wordDetailViewTopConstraint.constant = UIScreen.main.bounds.height + 15
            self.view.layoutIfNeeded()
        }, completion: nil)
        switch sender.tag {
        case 1:
            listView.isHidden = true
            self.wordDetailTextView.isHidden = false
            print(".......ShowDetailsOfWord.........")
            
            let movies: [DictionaryInfo] = DBManager.shared.loadMovieList(withDataWord: wordArray[0], prefix2: wordArray[1], root: wordArray[2], suffix1: "", suffix2: wordArray[3], suffix3: wordArray[4]) ?? []
            let meaningArr : NSMutableArray = []
            let partofSpeachArr : NSMutableArray = []
            for item in movies {
                if item.meaning != "" {
                    meaningArr.add(item.meaning)
                    partofSpeachArr.add(item.part_speech)
                }
            }
            var str: String = ""
            for var i in (0..<meaningArr.count){
                
                str += "\(partofSpeechDict["\(partofSpeachArr[i])"] as? String ?? ""):\n\(meaningArr[i])\n"
            }
            let stringVar = str.replacingOccurrences(of: "<br />", with: "")
            self.wordDetailTextView.text = stringVar
            //            let newString  = stringVar.replacingOccurrences(of: "<br />", with: "", options: .literal, range: NSRange(location: 0, length: stringVar.length))
            //            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Corbel", size: 24.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            //            let myAttrString = NSAttributedString(string: newString, attributes: myAttribute)
            //            self.wordDetailTextView.attributedText = myAttrString
            //            self.wordDetailTextView.textAlignment = .center
            break
        case 2:
            items = DBManager.shared.loadMovieList(withDataWord: "", prefix2: "", root: wordArray[2], suffix1: "", suffix2: "", suffix3: "") ?? []
            var str: [String] = []
            for var i in (0..<items.count){
                str.append(items[i].word)
            }
            let stringRepresentation = str.joined(separator: ", ")
            self.wordDetailTextView.text = stringRepresentation as String
            self.wordDetailTextView.textAlignment = .center
            self.wordDetailTextView.isHidden = false
            listView.isHidden = true
            break
        case 3:
            self.wordDetailTextView.isHidden = true
            listView.isHidden = false
            synonymLBL.text = "Select the right synonym for  " + "\"" + (wordDetailLBL.text! as String) + "\""
            items = DBManager.shared.loadMovieList(withDataWord: "", prefix2: "", root: wordArray[2], suffix1: "", suffix2: "", suffix3: "") ?? []
            synonymListArray.removeAllObjects()
            synonymSelected = false
            
            if let id = wordDetailLBL.text {
                DBManager.shared.loadMovie(withWordSynonym: id, completionHandler: { (movie) in
                    DispatchQueue.main.async {
                        if movie != nil {
                            if movie?.synonym != "" {
                                self.noSynonymLBL.isHidden = true
                                self.synonymCV.isHidden = false
                                self.wordDetailTextView.text = movie?.synonym
                                for var i in (0..<self.items.count) {
                                    if self.items[i].synonym != ""{
                                        if self.synonymListArray.count < 4 {
                                            if self.items[i].synonym != movie?.synonym{
                                                self.synonymListArray.add(self.items[i].synonym)
                                            } else if self.items[self.items.count-1].synonym != movie?.synonym{
                                                self.synonymListArray.add(self.items[self.items.count-1].synonym)
                                                
                                            }
                                        }
                                    }
                                }
                                // self.synonymListArray.add((movie?.synonym)! as String)
                                if self.synonymListArray.contains((movie?.synonym)! as String){
                                }
                                else{
                                    let   random1 :Int = Int.random(in: 0...3)
                                    self.synonymListArray.removeObject(at: random1)
                                    self.synonymListArray.insert((movie?.synonym)! as String, at: random1)
                                }
                                self.synonymCV.reloadData()
                            }
                            else{
                                self.noSynonymLBL.isHidden = false
                                self.synonymCV.isHidden = true
                            }
                            
                        }
                    }
                })
            }
            break
        default:
            break
        }
    }
    // MARK: - Methods
    
    func initialViewSettings() {
      // hideViews(hideP2View: true, hideS2View: true)
        wordDetailViewHeightConstraint.constant = UIScreen.main.bounds.height + 15
        if self.wordDetailViewTopConstraint.constant != 0 {
            self.wordDetailBTN.isHidden = false
        }
        self.wordDetailViewTopConstraint.constant = 0
        if UIDevice.current.orientation.isLandscape {
            
            slackView.insertArrangedSubview(prefix2View, at: 1)
            slackView.insertArrangedSubview(suffix2View, at: 3)
            suffix2VerticalView.isHidden = true
            prefix2VerticalView.isHidden = true
            slackViewYConstraint.constant = 0
        } else {
            
            slackView.removeArrangedSubview(prefix2View)
            prefix2View.removeFromSuperview()
            slackView.removeArrangedSubview(suffix2View)
            suffix2View.removeFromSuperview()
            slackViewYConstraint.constant = -80
            prefix2VerticalView.addSubview(prefix2View)
            suffix2VerticalView.addSubview(suffix2View)
            prefix2View.bindFrameToSuperviewBounds()
            suffix2View.bindFrameToSuperviewBounds()
            if wordArray[1] != "" {
                prefix2VerticalView.isHidden = false
            }
            if wordArray[3] != "" {
                suffix2VerticalView.isHidden = false
            }
        }
    }
    func initialSettings() {
        items = []
        if (UserDefaults.standard.object(forKey: "savedRootArray") as? [String]) != nil {
            savedRootArray = UserDefaults.standard.object(forKey: "savedRootArray") as! [String]
        }
        hideViews(hideP2View: true, hideS2View: true)
        picker1.isUserInteractionEnabled = true
        picker2.isUserInteractionEnabled = true
        picker3.isUserInteractionEnabled = true
        picker4.isUserInteractionEnabled = true
        picker5.isUserInteractionEnabled = true
        suffixOverlayBTN.isUserInteractionEnabled = true
        rootOverlayBTN.isUserInteractionEnabled = true
        prefixOverlayBTN.isUserInteractionEnabled = true
        resetBTN.isHidden = true
        if WordModel.shared.ModeValue == 0 { // root
            loadIntialData()
            resetBTN.isHidden = false
        } else if WordModel.shared.ModeValue == 1 { // random
            picker1.isUserInteractionEnabled = false
            picker2.isUserInteractionEnabled = false
            picker3.isUserInteractionEnabled = false
            picker4.isUserInteractionEnabled = false
            picker5.isUserInteractionEnabled = false
            suffixOverlayBTN.isUserInteractionEnabled = false
            rootOverlayBTN.isUserInteractionEnabled = false
            prefixOverlayBTN.isUserInteractionEnabled = false
            
            
            if savedRootArray.isEmpty {
                let alert = UIAlertController(title: "Instruction", message: "You need to start studying with root mode to start growing the random mode", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                
                loadRandomData()
            }
        } else {
            resetBTN.isHidden = false
            loadNonSenseData()
        }
        
    }
    func loadIntialData() {
        
        let movies: [DictionaryInfo] = DBManager.shared.loadMovies() ?? []
        for item in movies {
            if pickerdataPrefix1.contains(item.prefex_1) {
            }else{
                if item.prefex_1 != "" {
                    pickerdataPrefix1.append(item.prefex_1)}
            }
            if pickerdataPrefix2.contains(item.prefex_2) {
            }else{
                if item.prefex_2 != "" {
                    pickerdataPrefix2.append(item.prefex_2)}
            }
            if pickerdataRoot.contains(item.root) {
            }else{
                if item.root != "" {
                    pickerdataRoot.append(item.root)
                }
            }
            if pickerdataSuffix2.contains(item.suffix_2) {
            }else{
                if item.suffix_2 != "" {
                    pickerdataSuffix2.append(item.suffix_2)
                }
            }
            if pickerdataSuffix3.contains(item.suffix_3) {
            }else{
                
                if item.suffix_3 != "" {
                    pickerdataSuffix3.append(item.suffix_3)
                }
            }
        }
        pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataRoot = pickerdataRoot.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    }
    func loadNonSenseData() {
        
        let meaningMovies: [WordMeaningInfo] = DBManager.shared.loadnonsenceData() ?? []
        print(meaningMovies)
        
        for item in meaningMovies {
            print(item)
            if item.type == "1" {
                if nonsencePrefixArr.contains(item.word) {
                }else{
                    
                    if item.word != "" {
                        nonsencePrefixArr.append(item.word)
                    }
                }
            } else if item.type == "3" {
                if nonsenceRootArr.contains(item.word) {
                }else{
                    
                    if item.word != "" {
                        nonsenceRootArr.append(item.word)
                    }
                }
            } else if item.type == "6" {
                if nonsenceSuffixArr.contains(item.word) {
                }else{
                    
                    if item.word != "" {
                        nonsenceSuffixArr.append(item.word)
                    }
                }
            }
        }
    }
    func loadRandomData() {
        
        let movies = DBManager.shared.loadMovies() ?? []
        print("......\(allMovies.count).....\(allMovies)")
        for movie in movies {
            for root in savedRootArray {
                if movie.root == root {
                    allMovies.append(movie)
                }
            }
        }
        print("......\(allMovies.count).........\(savedRootArray.count)")
        if !allMovies.isEmpty && !savedRootArray.isEmpty {
            for item in allMovies {
                if pickerdataPrefix1.contains(item.prefex_1) {
                }else{
                    if item.prefex_1 != "" {
                        pickerdataPrefix1.append(item.prefex_1)}
                }
                if pickerdataPrefix2.contains(item.prefex_2) {
                }else{
                    if item.prefex_2 != "" {
                        pickerdataPrefix2.append(item.prefex_2)}
                }
                if pickerdataRoot.contains(item.root) {
                }else{
                    if item.root != "" {
                        pickerdataRoot.append(item.root)
                    }
                }
                if pickerdataSuffix2.contains(item.suffix_2) {
                }else{
                    if item.suffix_2 != "" {
                        pickerdataSuffix2.append(item.suffix_2)
                    }
                }
                if pickerdataSuffix3.contains(item.suffix_3) {
                }else{
                    
                    if item.suffix_3 != "" {
                        pickerdataSuffix3.append(item.suffix_3)
                    }
                }
            }
            pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataRoot = pickerdataRoot.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            showRandomMovie()
        }
    }
    func showRandomMovie() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
                   self.wordDetailViewTopConstraint.constant = 0
                   self.wordDetailBTN.isHidden = true
               }, completion: nil)
        
        if !allMovies.isEmpty && !savedRootArray.isEmpty {
            // activityIndicator.startAnimaton()
            let randomNum :Int = Int.random(in: 1...10000)
            let randomMovie = allMovies[randomNum%allMovies.count]
            print("randomMovie....\(allMovies.count)......\(randomNum%allMovies.count)....\(randomMovie)")
            wordArray = [randomMovie.prefex_1,randomMovie.prefex_2,randomMovie.root,randomMovie.suffix_2,randomMovie.suffix_3]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {// 0.5
                if let root = randomMovie.root {
                    if root != "" {
                        self.rootOverlayBTN.isHidden = true
                        self.picker3.isHidden = false
                        if let indexofFirstword = self.pickerdataRoot.firstIndex(of: root) {
                            self.picker3.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                        // self.picker3.selectRow(randomNum, inComponent: 0, animated: true)
                        // self.pickerView(self.picker3, didSelectRow: randomNum, inComponent: 0)
                    } else {
                        self.picker3.isHidden = true
                        self.rootOverlayBTN.isHidden = false
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {//1.0
                if let prefix1 = randomMovie.prefex_1 {
                    if prefix1 != "" {
                        self.picker1.isHidden = false
                        self.prefixOverlayBTN.isHidden = true
                        if let indexofFirstword = self.pickerdataPrefix1.firstIndex(of: prefix1) {
                            self.picker1.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                    } else {
                        self.picker1.isHidden = true
                        self.prefixOverlayBTN.isHidden = false
                    }
                }
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {//1.5
                if let prefix2 = randomMovie.prefex_2 {
                    if prefix2 == "" {
                        self.hideViews(hideP2View: true)
                    } else {
                        self.hideViews(hideP2View: false)
                        if let indexofFirstword = self.pickerdataPrefix2.firstIndex(of: prefix2) {
                            self.picker2.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {// 2
                if let suffix3 = randomMovie.suffix_3 {
                    if suffix3 != "" {
                        self.picker5.isHidden = false
                        self.suffixOverlayBTN.isHidden = true
                        if let indexofFirstword = self.pickerdataSuffix3.firstIndex(of: suffix3) {
                            self.picker5.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                    } else {
                        self.picker5.isHidden = true
                        self.suffixOverlayBTN.isHidden = false
                    }
                }
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {//2.5
                
                if let suffix2 = randomMovie.suffix_2 {
                    if suffix2 == "" {
                        self.hideViews(hideS2View: true)
                    } else {
                        self.hideViews(hideS2View: false)
                        if let indexofFirstword = self.pickerdataSuffix2.firstIndex(of: suffix2) {
                            self.picker4.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                    }
                }
            }
            picker1.reloadAllComponents()
            picker2.reloadAllComponents()
            picker3.reloadAllComponents()
            picker4.reloadAllComponents()
            picker5.reloadAllComponents()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {//3
                //  activityIndicator.stopAnimaton()
                self.wordform()
            }
        }
    }
    func prefixBtnAction() {
        let randomNum :Int = Int.random(in: 0...10000)
        if WordModel.shared.ModeValue == 2 {
            
            picker1.isHidden = false
            prefixOverlayBTN.isHidden = true
            self.picker1.selectRow(randomNum, inComponent: 0, animated: true)
            self.pickerView(self.picker1, didSelectRow: randomNum, inComponent: 0)
        } else {
            if rootValue != "" {
                if suffix3Value == "" {
                    boolSuffixFirst = false
                    boolPrefixFirst = true
                } else {
                    boolPrefixFirst = false
                }
                
                picker1.isHidden = false
                prefixOverlayBTN.isHidden = true
                self.picker1.selectRow(randomNum, inComponent: 0, animated: true)
                self.pickerView(self.picker1, didSelectRow: randomNum, inComponent: 0)
            }
        }
    }
    func rootBtnAction() {
        let randomNum :Int = Int.random(in: 0...10000)
        picker3.isHidden = false
        rootOverlayBTN.isHidden = true
        self.picker3.selectRow(randomNum, inComponent: 0, animated: true)
        self.pickerView(self.picker3, didSelectRow: randomNum, inComponent: 0)
    }
    func suffixBtnAction() {
        let randomNum :Int = Int.random(in: 0...10000)
        if WordModel.shared.ModeValue == 2 {
            picker5.isHidden = false
            suffixOverlayBTN.isHidden = true
            self.picker5.selectRow(randomNum, inComponent: 0, animated: true)
            self.pickerView(self.picker5, didSelectRow: randomNum, inComponent: 0)
        } else {
            if rootValue != ""{
                
                if prefix1Value == "" {
                    boolSuffixFirst = true
                    boolPrefixFirst = false
                } else {
                    boolSuffixFirst = false
                }
                picker5.isHidden = false
                suffixOverlayBTN.isHidden = true
                self.picker5.selectRow(randomNum, inComponent: 0, animated: true)
                self.pickerView(self.picker5, didSelectRow: randomNum, inComponent: 0)
            }
        }
    }
    
    func resetWith(root: Bool) {
         UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
                   self.wordDetailViewTopConstraint.constant = 0
                   self.wordDetailBTN.isHidden = true
               }, completion: nil)
        
        
        if root {
            wordArray = ["","",rootValue,"",""]
        } else {
            rootValue = ""
            rootOverlayBTN.isHidden = false
            picker3.isHidden = true
        }
        boolSuffixFirst = false
        boolPrefixFirst = false
        prefix1Value = ""
        prefix2Value = ""
        suffix2Value = ""
        suffix3Value = ""
        picker1.isHidden = true
        picker5.isHidden = true
        self.hideViews(hideP2View: true, hideS2View: true)
        prefixOverlayBTN.isHidden = false
        suffixOverlayBTN.isHidden = false
    }
    func getMovies() {
        print("values.....prefix1_\(wordArray[0]).....prefix2_\(wordArray[1]).....root_\(wordArray[2]).......suffix2_\(wordArray[3]).....suffix3_\(wordArray[4])")
        
        loadPickerData(prefix1: wordArray[0], prefix2: wordArray[1], root: wordArray[2], suffix2: wordArray[3], suffix3: wordArray[4]) { (pickerMovies) in
            
            print("pickerMovies........\(pickerMovies.count)");
            
            print("array count.....prefix1_\(pickerdataPrefix1.count).....prefix2_\(pickerdataPrefix2.count).....root_\(pickerdataRoot.count).........suffix2_\(pickerdataSuffix2.count).....suffix3_\(pickerdataSuffix3.count)")
            if !pickerMovies.isEmpty && rootValue != "" && prefix1Value != "" && suffix3Value != "" {
                //&& (wordArray[0] != "" || wordArray[2] != "" || wordArray[5] != "")
                let randomNum :Int = Int.random(in: 1...10000)
                let randomMovie = pickerMovies[randomNum%pickerMovies.count]
                print("randomMovie.........\n\(randomMovie)")
                if let prefix1 = randomMovie.prefex_1 {
                    if wordArray[0] == "" {
                        wordArray[0] = prefix1
                    }
                    if wordArray[0] != "" {
                        self.picker1.isHidden = false
                        self.prefixOverlayBTN.isHidden = true
                        if let indexofFirstword = self.pickerdataPrefix1.firstIndex(of: wordArray[0]) {
                            self.picker1.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                    } else {
                        self.picker1.isHidden = true
                        self.prefixOverlayBTN.isHidden = false
                    }
                    
                }
                if let prefix2 = randomMovie.prefex_2 {
                    wordArray[1] = prefix2
                    if wordArray[1] == "" {
                        self.hideViews(hideP2View: true)
                    } else {
                        self.hideViews(hideP2View: false)
                        if let indexofFirstword = self.pickerdataSuffix3.firstIndex(of: wordArray[1]) {
                        self.pickerView(self.picker2, didSelectRow: indexofFirstword, inComponent: 0)
                        }
                    }
                }
                if let suffix2 = randomMovie.suffix_2 {
                    wordArray[3] = suffix2
                    if wordArray[3] == "" {
                        self.hideViews(hideS2View: true)
                    } else {
                        self.hideViews(hideS2View: false)
                        if let indexofFirstword = self.pickerdataSuffix3.firstIndex(of: wordArray[3]) {
                        self.pickerView(self.picker4, didSelectRow: indexofFirstword, inComponent: 0)
                        }
                    }
                }
                if let suffix3 = randomMovie.suffix_3 {
                    if wordArray[4] == "" {
                        wordArray[4] = suffix3
                    }
                    if wordArray[4] != "" {
                        self.picker5.isHidden = false
                        self.suffixOverlayBTN.isHidden = true
                        if let indexofFirstword = self.pickerdataSuffix3.firstIndex(of: wordArray[4]) {
                            self.picker5.selectRow(indexofFirstword, inComponent: 0, animated: true)
                        }
                    } else {
                        self.picker5.isHidden = true
                        self.suffixOverlayBTN.isHidden = false
                    }
                }
            } else {
                self.hideViews(hideP2View: true, hideS2View: true)
            }
            
        }
        picker1.reloadAllComponents()
        picker2.reloadAllComponents()
        picker3.reloadAllComponents()
        picker4.reloadAllComponents()
        picker5.reloadAllComponents()
        wordform()
    }
    func wordform() {
        print(".......wordform().........")
        print(wordArray)
        
        
        
        hideMeaningViews()
        self.wordDetailBTN.isHidden = true
        DBManager.shared.loadwordFromDB(withWord: wordArray[0], prefix2: wordArray[1], root: wordArray[2], suffix1: "", suffix2: wordArray[3], suffix3: wordArray[4], completionHandler: { (movie) in
            DispatchQueue.main.async {
                if movie != nil {
                    self.resultWord = movie!.word
                    self.wordDetailBTN.isHidden = false
                    self.showWordMeaningPopup()
                } else {
                    self.wordDetailViewTopConstraint.constant = 0
                    self.wordDetailBTN.isHidden = true
                    print("down popup")
                }
                
            }
        })
    }
    
    func showWordMeaningPopup() {
        // save root value for random mode
        if !savedRootArray.contains(rootValue) {
            savedRootArray.append(rootValue)
        }
        UserDefaults.standard.set(savedRootArray, forKey: "savedRootArray")
        UserDefaults.standard.synchronize()
        
        let wordBtnStatus = self.wordDetailBTN.isHidden
        self.wordDetailBTN.isHidden = true
        self.closeBTNTopConstraint.constant = 0
        print(".......showMeaningGestureTapped.........\(wordBtnStatus)")
        print(".......self.popupviewTop.constant.........\(self.wordDetailViewTopConstraint.constant)")
        //self.randomTimer.invalidate()
        self.wordDetailLBL.text = self.resultWord
        self.meaningBTN.isSelected = false
        self.meaningBTN.borderColor = UIColor.white
        self.listBTN.isSelected = false
        self.listBTN.borderColor = UIColor.white
        self.synonymBTN.isSelected = false
        self.synonymBTN.borderColor = UIColor.white
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
            self.wordDetailViewTopConstraint.constant =  150
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func loadPickerData(prefix1: String, prefix2 : String, root : String, suffix2:String, suffix3:String, handler: (([DictionaryInfo])->Void)) {
        let movies: [DictionaryInfo] = DBManager.shared.loadMovieList(withDataWord: prefix1, prefix2: prefix2, root: root, suffix1: "", suffix2: suffix2, suffix3: suffix3) ?? []
        if !movies.isEmpty {
            
            if prefix1 == "" {
                pickerdataPrefix1.removeAll()
            }
            if prefix2 == "" {
                pickerdataPrefix2.removeAll()
            }
            if root == "" {
                pickerdataRoot.removeAll()
            }
            if suffix2 == "" {
                pickerdataSuffix2.removeAll()
            }
            if suffix3 == "" {
                pickerdataSuffix3.removeAll()
            }
            for item in movies {
                if pickerdataPrefix1.contains(item.prefex_1) {
                } else {
                    
                    if item.prefex_1 != "" {
                        pickerdataPrefix1.append(item.prefex_1)
                    }
                }
                
                if pickerdataPrefix2.contains(item.prefex_2) {
                } else {
                    
                    if item.prefex_2 != "" {
                        pickerdataPrefix2.append(item.prefex_2)
                    }
                }
                if pickerdataRoot.contains(item.root) {
                }else{
                    if item.root != "" {
                        pickerdataRoot.append(item.root)
                    }
                }
                if pickerdataSuffix2.contains(item.suffix_2) {
                } else {
                    
                    if item.suffix_2 != "" {
                        pickerdataSuffix2.append(item.suffix_2)
                    }
                }
                
                if pickerdataSuffix3.contains(item.suffix_3) {
                } else {
                    
                    if item.suffix_3 != "" {
                        pickerdataSuffix3.append(item.suffix_3)
                    }
                }
            }
            pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataRoot = pickerdataRoot.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        handler(movies)
    }
    func hideViews(hideP2View: Bool? = nil, hideS2View: Bool? = nil) {
        if hideP2View != nil {
            prefix2View.isHidden = hideP2View!
            
            if UIDevice.current.orientation.isLandscape {
                prefix2VerticalView.isHidden = true
            } else {
                prefix2VerticalView.isHidden = hideP2View!
            }
         }
        if hideS2View != nil {
            suffix2View.isHidden = hideS2View!
            
            if UIDevice.current.orientation.isLandscape {
                prefix2VerticalView.isHidden = true
            } else {
                suffix2VerticalView.isHidden = hideS2View!
            }
        }
    }
    func hideMeaningViews() {
        p1MeaningView.isHidden = true
        p2MeaningView.isHidden = true
        rootMeaningView.isHidden = true
        s2MeaningView.isHidden = true
        s3MeaningView.isHidden = true
    }
}

//MARK: - Picker Delegates
extension WordPickerVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10000
        //        if pickerView == picker1 {
        //            return pickerdataPrefix1.count
        //        } else if pickerView == picker2 {
        //            return pickerdataPrefix2.count
        //        } else if pickerView == picker3 {
        //            return pickerdataRoot.count
        //        } else if pickerView == picker4 {
        //            return pickerdataSuffix1.count
        //        } else if pickerView == picker5 {
        //            return pickerdataSuffix2.count
        //        } else {
        //            return pickerdataSuffix3.count
        //        }
    }
}

extension WordPickerVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if WordModel.shared.ModeValue == 2 {
            if pickerView == self.picker1{
                return nonsencePrefixArr[row%nonsencePrefixArr.count]
            } else if pickerView == self.picker3 {
                return nonsenceRootArr[row%nonsenceRootArr.count]
            } else{
                return nonsenceSuffixArr[row%nonsenceSuffixArr.count]
            }
        }
        else{
            if pickerView == picker1 {
                return pickerdataPrefix1[row%pickerdataPrefix1.count]}
            else if pickerView == picker2 {
                return pickerdataPrefix2[row%pickerdataPrefix2.count]}
            else if pickerView == picker3 {
                return pickerdataRoot[row%pickerdataRoot.count]}
            else if pickerView == picker4 {
                return pickerdataSuffix2[row%pickerdataSuffix2.count]}
            else {
                return pickerdataSuffix3[row%pickerdataSuffix3.count]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()
        label.font = appBold20Font
        label.textAlignment = .center
        label.textColor = UIColor.white
        if WordModel.shared.ModeValue == 2 {
            if pickerView == picker1 && nonsencePrefixArr.count > 0 {
                label.text = nonsencePrefixArr[row%nonsencePrefixArr.count]
            } else if pickerView == picker3 && nonsenceRootArr.count > 0 {
                label.text = nonsenceRootArr[row%nonsenceRootArr.count]
            } else if nonsenceSuffixArr.count > 0 {
                label.text = nonsenceSuffixArr[row%nonsenceSuffixArr.count]
            }
        } else  {
            if pickerView == picker1 && pickerdataPrefix1.count > 0 {
                label.text = pickerdataPrefix1[row%pickerdataPrefix1.count]
            } else if pickerView == picker2 && pickerdataPrefix2.count > 0 {
                label.text = pickerdataPrefix2[row%pickerdataPrefix2.count]
            } else if pickerView == picker3 && pickerdataRoot.count > 0 {
                label.text = pickerdataRoot[row%pickerdataRoot.count]
            } else if pickerView == picker4 && pickerdataSuffix2.count > 0 {
                label.text = pickerdataSuffix2[row%pickerdataSuffix2.count]
            } else if pickerdataSuffix3.count > 0 {
                label.text = pickerdataSuffix3[row%pickerdataSuffix3.count]
            }
        }
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if WordModel.shared.ModeValue == 0 { //root mode
            if pickerView == picker1 {
                if !prefixSpinned {
                    prefixValueSelected = true
                }
                prefixSpinned = false
                if pickerdataPrefix1.count > 0 {
                    prefix1Value = pickerdataPrefix1[row%pickerdataPrefix1.count]
                } else  {
                    prefix1Value = ""
                }
                
                print("....1...\(prefix1Value)")
                if boolPrefixFirst {
                    boolSuffixFirst = false
                    wordArray = [prefix1Value,"",rootValue,"",""]
                }else{
                    boolPrefixFirst = true
                    boolSuffixFirst = false
                    wordArray[0] = prefix1Value
                }
                print("prefix2View...\(prefix2View.isHidden)")
                print("suffix2View...\(suffix2View.isHidden)")
               getMovies()
            } else if pickerView == picker2 {
                prefix2Value = pickerdataPrefix2[row%pickerdataPrefix2.count]
                print("....2..\(prefix2Value)")
                wordArray[1] = prefix2Value
                wordform()
            } else if pickerView == picker3 {
                if !rootSpinned {
                    rootValueSelected = true
                    
                }
                rootSpinned = false
                rootValue = pickerdataRoot[row%pickerdataRoot.count]
                wordArray[2] = rootValue
                boolSuffixFirst = false
                boolPrefixFirst = false
                print(wordArray)
                resetWith(root: true)
                getMovies()
                
            } else if pickerView == picker4 {
                suffix2Value = pickerdataSuffix2[row%pickerdataSuffix2.count]
                print("....5...\(suffix2Value)")
                wordArray[3] = suffix2Value
                wordform()
            } else {
                if !suffixSpinned {
                    suffixValueSelected = true
                }
                suffixSpinned = false
                if pickerdataSuffix3.count > 0 {
                    suffix3Value = pickerdataSuffix3[row%pickerdataSuffix3.count]
                } else  {
                    suffix3Value = ""
                }
                print("prefix2View...\(prefix2View.isHidden)")
                print("suffix2View...\(suffix2View.isHidden)")
                print("....6...\(suffix3Value)")
                if boolSuffixFirst {
                    boolPrefixFirst = false
                    wordArray = ["","",rootValue,"",suffix3Value]
                }else{
                    boolPrefixFirst = false
                    boolSuffixFirst = true
                    wordArray[4] = suffix3Value
                }
                getMovies()
            }
        } else if WordModel.shared.ModeValue == 1 { // random mode
            
        } else { // nonsense mode
            if pickerView == picker1 {
                if nonsencePrefixArr.count > 0 {
                    prefix1Value = nonsencePrefixArr[row%nonsencePrefixArr.count]
                } else  {
                    prefix1Value = ""
                }
                wordArray[0] = prefix1Value
            } else if pickerView == picker3 {
                
                rootValue = nonsenceRootArr[row%nonsenceRootArr.count]
                wordArray[2] = rootValue
            } else {
                if nonsenceSuffixArr.count > 0 {
                    suffix3Value = nonsenceSuffixArr[row%nonsenceSuffixArr.count]
                } else  {
                    suffix3Value = ""
                }
                wordArray[4] = suffix3Value
            }
        }
    }
}

// MARK: - CollectionView Delegates
extension WordPickerVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return synonymListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SynonymCVC", for: indexPath as IndexPath) as! SynonymCVC
        
        cell.nameLBL.text = synonymListArray[indexPath.row] as? String
        cell.backgroundColor = UIColor.clear
        cell.statusBTN.isHidden = true
        
        if synonymSelected {
            
            if let id = wordDetailLBL.text {
                DBManager.shared.loadMovie(withWordSynonym: id, completionHandler: { (movie) in
                    DispatchQueue.main.async {
                        if movie != nil {
                            if  self.synonymListArray[indexPath.row] as? String == movie?.synonym {
                                
                                if self.synonymIndex == indexPath.row {
                                    if checkSynonymSuccess() {
                                        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "giphy", withExtension: "gif")!)
                                        let jeremyGif = UIImage.sd_image(withGIFData: imageData)
                                        let imageView = UIImageView(image: jeremyGif)
                                        
                                        imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width/2, height: self.view.frame.size.width/2)
                                        
                                        imageView.center.x = self.view.center.x
                                        imageView.center.y = UIScreen.main.bounds.height
                                        self.view.isUserInteractionEnabled = false
                                        self.view.addSubview(imageView)
                                        UIView.animate(withDuration:1.5, delay: 0, options: [.transitionFlipFromTop], animations: {
                                            
                                            imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                            imageView.contentMode = .scaleAspectFit
                                            imageView.center = self.view.center
                                        }, completion: { (status) in
                                            print("completed")
                                        })
                                        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                                            imageView.removeFromSuperview()
                                            self.view.isUserInteractionEnabled = true
                                        }
                                    } else {
                                        
                                    }
                                } else {
                                    
                                }
                                cell.statusBTN.isHidden = false
                                
                                cell.statusBTN.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
                                
                            } else {
                                if self.synonymIndex == indexPath.row {
                                    cell.statusBTN.isHidden = false
                                    self.synonymDidStatus = true
                                    cell.statusBTN.setBackgroundImage(#imageLiteral(resourceName: "no"), for: .normal)
                                    
                                } else {
                                    
                                    cell.statusBTN.isHidden = true
                                }
                            }
                            
                        } else {
                            if self.synonymIndex == indexPath.row{
                                cell.statusBTN.isHidden = false
                                self.synonymDidStatus = true
                                cell.statusBTN.setBackgroundImage(#imageLiteral(resourceName: "no"), for: .normal)
                                
                            } else {
                                
                                cell.statusBTN.isHidden = true
                                
                            }
                        }
                    }
                }
                )
            }
        }
        return cell
    }
}

extension WordPickerVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        synonymSelected = true
        synonymIndex = indexPath.row
        
        self.synonymCV.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40)/2, height: 50)
    }
}

// MARK: - ScrollView Delegates
extension WordPickerVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let verticalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as? UIImageView) {
            verticalIndicator.backgroundColor = UIColor(red: 152.0/255.0, green: 187.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        }
    }
}
