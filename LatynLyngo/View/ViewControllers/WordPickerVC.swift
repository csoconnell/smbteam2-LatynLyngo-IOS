//
//  WordPickerVC.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 26/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

class WordPickerVC: UIViewController {
    
    @IBOutlet weak var prefix2View: UIView!
    @IBOutlet weak var suffix1View: UIView!
    @IBOutlet weak var suffix2View: UIView!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var picker3: UIPickerView!
    @IBOutlet weak var picker4: UIPickerView!
    @IBOutlet weak var picker5: UIPickerView!
    @IBOutlet weak var picker6: UIPickerView!
    @IBOutlet weak var prefixOverlayBTN: UIButton!
    @IBOutlet weak var rootOverlayBTN: UIButton!
    @IBOutlet weak var suffixOverlayBTN: UIButton!
    @IBOutlet weak var resetBTN: UIButton!
    @IBOutlet weak var wordLBL: UILabel!
    
    var nonsencePrefixArr = [String]()
    var nonsenceRootArr = [String]()
    var nonsenceSuffixArr = [String]()
    var pickerdataPrefix1 = [String]()
    var pickerdataPrefix2 = [String]()
    var pickerdataRoot = [String]()
    var pickerdataSuffix3 = [String]()
    var pickerdataSuffix2 = [String]()
    var pickerdataSuffix1 = [String]()
    var wordArray = ["","","","","",""]
    
    var resultWord = ""
    var rootValue = ""
    var prefix1Value = ""
    var prefix2Value = ""
    var suffix1Value = ""
    var suffix2Value = ""
    var suffix3Value = ""
    var randomCounter = 0
    var boolSuffixFirst = false
    var boolPrefixFirst = false
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
        
    }
    @IBAction func back(_ sender: UIButton) {
        print( self.navigationController!.viewControllers)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SpinBTNTapped(_ sender: UIButton) {
        if WordModel.shared.ModeValue == 1 {// random mode
            loadRandomData()
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
            picker6.isHidden = false
            suffixOverlayBTN.isHidden = true
            self.picker6.selectRow(randomNum, inComponent: 0, animated: true)
            self.pickerView(self.picker6, didSelectRow: randomNum, inComponent: 0)
        } else {
            if rootValue != ""{
                
                if prefix1Value == "" {
                    boolSuffixFirst = true
                    boolPrefixFirst = false
                } else {
                    boolSuffixFirst = false
                }
                picker6.isHidden = false
                suffixOverlayBTN.isHidden = true
                self.picker6.selectRow(randomNum, inComponent: 0, animated: true)
                self.pickerView(self.picker6, didSelectRow: randomNum, inComponent: 0)
            }
        }
    }
    func initialSettings() {
        prefix2View.isHidden = true
        suffix1View.isHidden = true
        suffix2View.isHidden = true
        picker1.isUserInteractionEnabled = true
        picker2.isUserInteractionEnabled = true
        picker3.isUserInteractionEnabled = true
        picker4.isUserInteractionEnabled = true
        picker5.isUserInteractionEnabled = true
        picker6.isUserInteractionEnabled = true
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
            picker6.isUserInteractionEnabled = false
            suffixOverlayBTN.isUserInteractionEnabled = false
            rootOverlayBTN.isUserInteractionEnabled = false
            prefixOverlayBTN.isUserInteractionEnabled = false
            var savedRootValue = ""
            if (UserDefaults.standard.object(forKey: "savedRootValue") as? String) != nil {
                savedRootValue = UserDefaults.standard.object(forKey: "savedRootValue") as! String
            }
            if savedRootValue == "" {
                let alert = UIAlertController(title: "Alert", message: "Please choose root in Root Mode", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                wordArray = ["","",savedRootValue,"","",""]
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
            if pickerdataSuffix1.contains(item.suffix_1) {
            }else{
                if item.suffix_1 != "" {
                    pickerdataSuffix1.append(item.suffix_1)
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
        pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
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
        activityIndicator.startAnimaton()
        wordLBL.text = ""
        loadPickerData(prefix1: "", prefix2: "", root: wordArray[2], suffix1: "", suffix2: "", suffix3: "") { (pickerMovies) in
            if !pickerMovies.isEmpty {
                let randomNum :Int = Int.random(in: 1...10000)
                let randomMovie = pickerMovies[randomNum%pickerMovies.count]
                print("randomMovie....\(pickerMovies.count)......\(randomNum%pickerMovies.count)....\(randomMovie)")
                wordArray = [randomMovie.prefex_1,randomMovie.prefex_2,randomMovie.root,randomMovie.suffix_1,randomMovie.suffix_2,randomMovie.suffix_3]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let root = randomMovie.root {
                        if root != "" {
                            self.rootOverlayBTN.isHidden = true
                            self.picker3.isHidden = false
                            
                            self.picker3.selectRow(randomNum, inComponent: 0, animated: true)
                            self.pickerView(self.picker3, didSelectRow: randomNum, inComponent: 0)
                        } else {
                            self.picker3.isHidden = true
                            self.rootOverlayBTN.isHidden = false
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if let prefix2 = randomMovie.prefex_2 {
                        if prefix2 == "" {
                            self.prefix2View.isHidden = true
                        } else {
                            self.prefix2View.isHidden = false
                            if let indexofFirstword = self.pickerdataPrefix2.firstIndex(of: prefix2) {
                                self.picker2.selectRow(indexofFirstword, inComponent: 0, animated: true)
                            }
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    if let suffix3 = randomMovie.suffix_3 {
                        if suffix3 != "" {
                            self.picker6.isHidden = false
                            self.suffixOverlayBTN.isHidden = true
                            if let indexofFirstword = self.pickerdataSuffix3.firstIndex(of: suffix3) {
                                self.picker6.selectRow(indexofFirstword, inComponent: 0, animated: true)
                            }
                        } else {
                            self.picker6.isHidden = true
                            self.suffixOverlayBTN.isHidden = false
                        }
                    }
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    if let suffix1 = randomMovie.suffix_1 {
                        if suffix1 == "" {
                            self.suffix1View.isHidden = true
                        } else {
                            self.suffix1View.isHidden = false
                            if let indexofFirstword = self.pickerdataSuffix1.firstIndex(of: suffix1) {
                                self.picker4.selectRow(indexofFirstword, inComponent: 0, animated: true)
                            }
                        }
                    }
                    if let suffix2 = randomMovie.suffix_2 {
                        if suffix2 == "" {
                            self.suffix2View.isHidden = true
                        } else {
                            self.suffix2View.isHidden = false
                            if let indexofFirstword = self.pickerdataSuffix2.firstIndex(of: suffix2) {
                                self.picker5.selectRow(indexofFirstword, inComponent: 0, animated: true)
                            }
                        }
                    }
                }
                picker1.reloadAllComponents()
                picker2.reloadAllComponents()
                picker3.reloadAllComponents()
                picker4.reloadAllComponents()
                picker5.reloadAllComponents()
                picker6.reloadAllComponents()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    activityIndicator.stopAnimaton()
                    self.wordform()
                }
            }
        }
    }
}
//MARK: Picker Delegates
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
                return pickerdataSuffix1[row%pickerdataSuffix1.count]}
            else if pickerView == picker5 {
                return pickerdataSuffix2[row%pickerdataSuffix2.count]}
            else{
                return pickerdataSuffix3[row%pickerdataSuffix3.count]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()
        label.font = UIFont(name: "trebuc", size: 14)
        label.textAlignment = .center
        label.textColor = UIColor.black
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
            } else if pickerView == picker4 && pickerdataSuffix1.count > 0 {
                label.text = pickerdataSuffix1[row%pickerdataSuffix1.count]
            } else if pickerView == picker5 && pickerdataSuffix2.count > 0 {
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
                prefix1Value = pickerdataPrefix1[row%pickerdataPrefix1.count]
                print("....1...\(prefix1Value)")
                if boolPrefixFirst {
                    boolSuffixFirst = false
                    wordArray = [prefix1Value,"",rootValue,"","",""]
                }else{
                    boolPrefixFirst = true
                    boolSuffixFirst = false
                    wordArray[0] = prefix1Value
                }
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
                
                boolSuffixFirst = false
                boolPrefixFirst = false
                print(wordArray)
                resetWith(root: true)
                getMovies()
                // save root value for random mode
                UserDefaults.standard.set(rootValue, forKey: "savedRootValue")
                UserDefaults.standard.synchronize()
            } else if pickerView == picker4 {
                suffix1Value = pickerdataSuffix1[row%pickerdataSuffix1.count]
                print("....4...\(suffix1Value)")
                wordArray[3] = suffix1Value
                wordform()
            } else if pickerView == picker5 {
                suffix2Value = pickerdataSuffix2[row%pickerdataSuffix2.count]
                print("....5...\(suffix2Value)")
                wordArray[4] = suffix2Value
                wordform()
            } else {
                if !suffixSpinned {
                    suffixValueSelected = true
                }
                suffixSpinned = false
                suffix3Value = pickerdataSuffix3[row%pickerdataSuffix3.count]
                print("....6...\(suffix3Value)")
                if boolSuffixFirst {
                    boolPrefixFirst = false
                    wordArray = ["","",rootValue,"","",suffix3Value]
                }else{
                    boolPrefixFirst = false
                    boolSuffixFirst = true
                    wordArray[5] = suffix3Value
                }
                getMovies()
            }
        } else if WordModel.shared.ModeValue == 1 { // random mode
            
        } else { // nonsense mode
            if pickerView == picker1 {
                
                prefix1Value = nonsencePrefixArr[row%nonsencePrefixArr.count]
            } else if pickerView == picker3 {
                
                rootValue = nonsenceRootArr[row%nonsenceRootArr.count]
            } else {
                
                suffix3Value = nonsenceSuffixArr[row%nonsenceSuffixArr.count]
            }
        }
        
    }
    func resetWith(root: Bool) {
        if root {
            wordArray = ["","",rootValue,"","",""]
        } else {
            rootValue = ""
            rootOverlayBTN.isHidden = false
            picker3.isHidden = true
        }
        boolSuffixFirst = false
        boolPrefixFirst = false
        prefix1Value = ""
        prefix2Value = ""
        suffix1Value = ""
        suffix2Value = ""
        suffix3Value = ""
        picker1.isHidden = true
        picker6.isHidden = true
        prefix2View.isHidden = true
        suffix1View.isHidden = true
        suffix2View.isHidden = true
        prefixOverlayBTN.isHidden = false
        suffixOverlayBTN.isHidden = false
        self.wordLBL.text = ""
    }
    func getMovies() {
        print("values.....prefix1_\(wordArray[0]).....prefix2_\(wordArray[1]).....root_\(wordArray[2]).....suffix1_\(wordArray[3]).....suffix2_\(wordArray[4]).....suffix3_\(wordArray[5])")
        
        loadPickerData(prefix1: wordArray[0], prefix2: wordArray[1], root: wordArray[2], suffix1: wordArray[3], suffix2: wordArray[4], suffix3: wordArray[5]) { (pickerMovies) in
            
            print("pickerMovies........\(pickerMovies.count)");
            
            print("array count.....prefix1_\(pickerdataPrefix1.count).....prefix2_\(pickerdataPrefix2.count).....root_\(pickerdataRoot.count).....suffix1_\(pickerdataSuffix1.count).....suffix2_\(pickerdataSuffix2.count).....suffix3_\(pickerdataSuffix3.count)")
            if !pickerMovies.isEmpty && rootValue != "" && prefix1Value != "" && suffix3Value != "" {
                //&& (wordArray[0] != "" || wordArray[2] != "" || wordArray[5] != "")
                let randomNum :Int = Int.random(in: 1...10000)
                let randomMovie = pickerMovies[randomNum%pickerMovies.count]
                print("randomMovie.........\(randomMovie)")
                if let prefix1 = randomMovie.prefex_1 {
                    if wordArray[0] == "" {
                        wordArray[0] = prefix1
                    }
                }
                if let prefix2 = randomMovie.prefex_2 {
                    wordArray[1] = prefix2
                    if wordArray[1] == "" {
                        prefix2View.isHidden = true
                    } else {
                        prefix2View.isHidden = false
                        self.pickerView(self.picker2, didSelectRow: randomNum, inComponent: 0)
                    }
                }
                if let suffix1 = randomMovie.suffix_1 {
                    wordArray[3] = suffix1
                    if wordArray[3] == "" {
                        suffix1View.isHidden = true
                    } else {
                        suffix1View.isHidden = false
                        self.pickerView(self.picker4, didSelectRow: randomNum, inComponent: 0)
                    }
                }
                if let suffix2 = randomMovie.suffix_2 {
                    wordArray[4] = suffix2
                    if wordArray[4] == "" {
                        suffix2View.isHidden = true
                    } else {
                        suffix2View.isHidden = false
                        self.pickerView(self.picker5, didSelectRow: randomNum, inComponent: 0)
                    }
                }
                if let suffix3 = randomMovie.suffix_3 {
                    if wordArray[5] == "" {
                        wordArray[5] = suffix3
                    }
                }
            } else {
                
                prefix2View.isHidden = true
                suffix1View.isHidden = true
                suffix2View.isHidden = true
            }
            
        }
        picker1.reloadAllComponents()
        picker2.reloadAllComponents()
        picker3.reloadAllComponents()
        picker4.reloadAllComponents()
        picker5.reloadAllComponents()
        picker6.reloadAllComponents()
        wordform()
    }
    func wordform() {
        print(".......wordform().........")
        print(wordArray)
        DBManager.shared.loadwordFromDB(withWord: wordArray[0], prefix2: wordArray[1], root: wordArray[2], suffix1: wordArray[3], suffix2: wordArray[4], suffix3: wordArray[5], completionHandler: { (movie) in
            DispatchQueue.main.async {
                if movie != nil {
                    self.wordLBL.text = movie!.word
                    
                } else {
                    self.wordLBL.text = ""
                }
                
            }
        })
    }
    
    func loadPickerData(prefix1: String, prefix2 : String, root : String, suffix1:String, suffix2:String, suffix3:String, handler: (([DictionaryInfo])->Void)) {
        let movies: [DictionaryInfo] = DBManager.shared.loadTestMovie(withDataWord: prefix1, prefix2: prefix2, root: root, suffix1: suffix1, suffix2: suffix2, suffix3: suffix3) ?? []
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
            if suffix1 == "" {
                pickerdataSuffix1.removeAll()
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
                if pickerdataSuffix1.contains(item.suffix_1) {
                } else {
                    
                    if item.suffix_1 != "" {
                        pickerdataSuffix1.append(item.suffix_1)
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
            pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        handler(movies)
    }
}
