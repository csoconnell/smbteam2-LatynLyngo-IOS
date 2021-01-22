//
//  splitedPickerAny.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 3/20/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices
import AVFoundation
import NVActivityIndicatorView
protocol listRefreshDataAgain {
    func loadDataFunctionAgain()
}
class splitedPickerAny:  UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UIGestureRecognizerDelegate, UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    var items: [DictionaryInfo]!
    let reuseIdentifier = "Cell"
    @IBOutlet var templateList: UICollectionView!
    var audioPlayer = AVAudioPlayer()
    var activityIndicatorView :NVActivityIndicatorView? = nil
    var shared = SharedInstance.sharedInstance
    //MARK: UILabel
    @IBOutlet weak var nosynonymLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var prefix1Lbl: UILabel!
    @IBOutlet weak var prefix2lbl: UILabel!
    @IBOutlet weak var rootlbl: UILabel!
    @IBOutlet weak var suffix1Lbl: UILabel!
    @IBOutlet weak var suffix2Lbl: UILabel!
    @IBOutlet weak var suffix3lbl: UILabel!
    @IBOutlet weak var meaningHeadLbl: UILabel!
    @IBOutlet weak var synonymLbl: UILabel!
    //MARK: UIButtons
    @IBOutlet weak var prefixOverlayBtn: UIButton!
    @IBOutlet weak var rootOverlayBtn: UIButton!
    @IBOutlet weak var suffixOverlayBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var meaningButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var synonymsButton: UIButton!
    @IBOutlet weak var rootButton: UIButton!
    @IBOutlet weak var prefixButton: UIButton!
    @IBOutlet weak var suffixButton: UIButton!
    @IBOutlet weak var prefixBtn: UIButton!
    @IBOutlet weak var rootBtn: UIButton!
    @IBOutlet weak var suffixbtn: UIButton!
    @IBOutlet weak var wordformBtn: UIButton!
    //MARK: UIView
    @IBOutlet weak var randomP1MeaningView: UIView!
    @IBOutlet weak var randomP2MeaningView: UIView!
    @IBOutlet weak var randomRootMeaningView: UIView!
    @IBOutlet weak var randomS1MeaningView: UIView!
    @IBOutlet weak var randomS2MeaningView: UIView!
    @IBOutlet weak var randomS3MeaningView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var topImg: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var meaningPopupView: UIView!
    @IBOutlet weak var Prview1: UIView!
    @IBOutlet weak var Prview2: UIView!
    @IBOutlet weak var Prview3: UIView!
    @IBOutlet weak var Prview4: UIView!
    @IBOutlet weak var Prview5: UIView!
    @IBOutlet weak var Prview6: UIView!
    @IBOutlet weak var prefix1lblView: UIView!
    @IBOutlet weak var prefix2lblView: UIView!
    @IBOutlet weak var rootlblView: UIView!
    @IBOutlet weak var suffix1lblView: UIView!
    @IBOutlet weak var suffix2lblView: UIView!
    @IBOutlet weak var suffix3LblView: UIView!
    @IBOutlet weak var menuBtnView: UIView!
    //MARK: UIImageViews
    @IBOutlet weak var bottomImg: UIImageView!
    @IBOutlet weak var prefix1Img: UIImageView!
    @IBOutlet weak var prefix2Img: UIImageView!
    @IBOutlet weak var rootImg: UIImageView!
    @IBOutlet weak var suffix2Img: UIImageView!
    @IBOutlet weak var suffix1Img: UIImageView!
    @IBOutlet weak var suffix3Img: UIImageView!
    @IBOutlet weak var pickerBgImg: UIImageView!
    //MARK: TapGestures
    var pickerTapPrefix1Gesture = UITapGestureRecognizer()
    var pickerTapPrefix2Gesture = UITapGestureRecognizer()
    var pickerTapRootGesture = UITapGestureRecognizer()
    var pickerTapSuffix1Gesture = UITapGestureRecognizer()
    var pickerTapSuffix2Gesture = UITapGestureRecognizer()
    var pickerTapSuffix3Gesture = UITapGestureRecognizer()
    //MARK: UIPickers
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var picker3: UIPickerView!
    @IBOutlet weak var picker4: UIPickerView!
    @IBOutlet weak var picker5: UIPickerView!
    @IBOutlet weak var picker6: UIPickerView!
    var selectPiceker = UIPickerView()
    //MARK: UITextViews
    @IBOutlet weak var meaningheadTextview: UITextView!
    @IBOutlet weak var MeaningTextView: UITextView!
    //MARK: Constraints
    @IBOutlet weak var popupviewBottom: NSLayoutConstraint!
    @IBOutlet weak var listviewHeight: NSLayoutConstraint!
    @IBOutlet weak var popupViewHeight: NSLayoutConstraint!
    @IBOutlet weak var picker1Width: NSLayoutConstraint!
    @IBOutlet weak var picker2Width: NSLayoutConstraint!
    @IBOutlet weak var picker3Width: NSLayoutConstraint!
    @IBOutlet weak var picker4Width: NSLayoutConstraint!
    @IBOutlet weak var picker5Width: NSLayoutConstraint!
    @IBOutlet weak var picker6Width: NSLayoutConstraint!
    @IBOutlet weak var picker1Leading: NSLayoutConstraint!
    @IBOutlet weak var picker2Leading: NSLayoutConstraint!
    @IBOutlet weak var picker3Leading: NSLayoutConstraint!
    @IBOutlet weak var picker4leading: NSLayoutConstraint!
    @IBOutlet weak var picker5Leading: NSLayoutConstraint!
    @IBOutlet weak var picker6Leading: NSLayoutConstraint!
    @IBOutlet weak var picker6Trailing: NSLayoutConstraint!
    @IBOutlet var grammerTop: NSLayoutConstraint!
    @IBOutlet var instructionTop: NSLayoutConstraint!
    //MARK: Timer Variables
    var timer = Timer()
    var randomTimer = Timer()
    var pickerCounter = 0
    var counter = 0
    //MARK: Bool Variables
    var boolRoot = false
    var boolPrefix = false
    var boolSuffix = false
    var delegate: listRefreshDataAgain?
    var boolSuffixdata = true
    var boolSuffix1data = false
    var boolPrefix1 = false
    var boolSuffix1 = false
    var boolSuffix2 = false
    var boolSuffixfirst = false
    var boolPrefixfirst = false
    var boolSettingRoot = false
    var rootPickerLoading : Bool = false
    var menubtnClicked = false
    var didselectStatus = false
    var didStatus = false
    //MARK: NSDictionaries
    var movies: [DictionaryInfo]!
    var moviesbool: [String] = []
    var moviesbool2nd: [String] = []
    var moviesRoot: [DictionaryInfo]!
    var moviesPrefix1: [DictionaryInfo]!
    var moviesSuffix3: [DictionaryInfo]!
    var moviesSuffix2: [DictionaryInfo]!
    var meaningMovies: [WordMeaningInfo]!
    var partofSpeechDict : NSDictionary = ["n.":"Noun","adj.":"Adjective","v.":"Verb","":"Adverb","":"Pronoun","":" Preposition","":"Conjunction ","":"Interjection"]
    //MARK: NSArrays
    var pickerdataPrefix1 = [String]();
    var pickerdataPrefix2 = [String]();
    var pickerdataRoot = [String]();
    var pickerdataSuffix3 = [String]();
    var pickerdataSuffix2 = [String]();
    var pickerdataSuffix1 = [String]();
    var wordArrayDB = [String]();
    var meaningArrayDB = [String]();
    var selectedWordArr = ["","","","","",""]
    var testArr : NSMutableArray = []
    //MARK: NSString Variables
    var resultWord = ""
    var rootValue = ""
    var prefix1Value = ""
    var prefix2Value = ""
    var suffix1Value = ""
    var suffix2Value = ""
    var suffix3Value = ""
    //MARK: intVariables
    var random : Int = 0
    var Numberlist = -1
    var NumberPicker1 = -1
    var NumberPicker3 = -1
    var NumberPicker6 = -1
    var NumberPicker5 = -1
    var NumberPicker2 = -1
    var didselectValue = 0
    //MARK: Float Variables
    var pickerviewWidth : CGFloat = 0.0
    var deviceScreenWidth : CGFloat = 0.0
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: self.view.center.x-20, y: self.view.center.y-20, width: 40, height: 40)
        activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                        type: .ballSpinFadeLoader)
        templateList.isHidden = false
        templateList.allowsSelection = true
        templateList.delegate = self
        moviesbool.removeAll()
        moviesbool2nd.removeAll()
        templateList.dataSource = self
        if UIScreen.main.bounds.width == 568 {
            listviewHeight.constant = 150
        }else if UIScreen.main.bounds.width == 667 {
            listviewHeight.constant = 180
        }else{
            listviewHeight.constant = 220
        }
        rootBtn.titleLabel?.font = UIFont(name: shared.fontStylePicker as String, size: shared.FontSizePicker)
        prefixBtn.titleLabel?.font = UIFont(name: shared.fontStylePicker as String, size: shared.FontSizePicker)
        suffixbtn.titleLabel?.font = UIFont(name: shared.fontStylePicker as String, size: shared.FontSizePicker)
        self.view.layoutIfNeeded()
        items = []
        templateList.isUserInteractionEnabled = true
        self.templateList.reloadData()
        pickerTapRootGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapRootPickerButton(_:)))
        pickerTapRootGesture.delegate = self
        pickerTapRootGesture.numberOfTapsRequired = 2
        self.picker3.addGestureRecognizer(pickerTapRootGesture)
        pickerTapPrefix1Gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapprefix1PickerButton(_:)))
        pickerTapPrefix1Gesture.delegate = self
        pickerTapPrefix1Gesture.numberOfTapsRequired = 2
        self.picker1.addGestureRecognizer(pickerTapPrefix1Gesture)
        pickerTapPrefix2Gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapPrefix2PickerButton(_:)))
        pickerTapPrefix2Gesture.delegate = self
        pickerTapPrefix2Gesture.numberOfTapsRequired = 2
        self.picker2.addGestureRecognizer(pickerTapPrefix2Gesture)
        pickerTapSuffix1Gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSuffix1PickerButton(_:)))
        pickerTapSuffix1Gesture.delegate = self
        pickerTapSuffix1Gesture.numberOfTapsRequired = 2
        self.picker4.addGestureRecognizer(pickerTapSuffix1Gesture)
        pickerTapSuffix2Gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSuffix2PickerButton(_:)))
        pickerTapSuffix2Gesture.delegate = self
        pickerTapSuffix2Gesture.numberOfTapsRequired = 2
        self.picker5.addGestureRecognizer(pickerTapSuffix2Gesture)
        pickerTapSuffix3Gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSuffix3PickerButton(_:)))
        pickerTapSuffix3Gesture.delegate = self
        pickerTapSuffix3Gesture.numberOfTapsRequired = 2
        self.picker6.addGestureRecognizer(pickerTapSuffix3Gesture)
        let showmeaningGesture = UITapGestureRecognizer(target: self, action: #selector(self.showMeaningGestureTapped(_:)))
        showmeaningGesture.delegate = self
        showmeaningGesture.numberOfTapsRequired = 1
        let showmeaningGestureBottom = UITapGestureRecognizer(target: self, action: #selector(self.showMeaningGestureTapped(_:)))
        showmeaningGestureBottom.delegate = self
        showmeaningGestureBottom.numberOfTapsRequired = 1
        self.bottomImg.isUserInteractionEnabled = true
        self.bottomImg.addGestureRecognizer(showmeaningGestureBottom)
        self.topImg.addGestureRecognizer(showmeaningGesture)
        let rootswipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.rootbtnClicked(_:)))
        rootswipeGesture.delegate = self
        rootswipeGesture.direction = .down
        self.rootOverlayBtn.addGestureRecognizer(rootswipeGesture)
        let rootswipeupGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.rootbtnClicked(_:)))
        rootswipeupGesture.delegate = self
        rootswipeupGesture.direction = .up
        self.rootOverlayBtn.addGestureRecognizer(rootswipeupGesture)
        let prefixswipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.prefixbtnClicked(_:)))
        prefixswipeGesture.delegate = self
        prefixswipeGesture.direction = .down
        self.prefixOverlayBtn.addGestureRecognizer(prefixswipeGesture)
        let prefixswipeupGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.prefixbtnClicked(_:)))
        prefixswipeupGesture.delegate = self
        prefixswipeupGesture.direction = .up
        self.prefixOverlayBtn.addGestureRecognizer(prefixswipeupGesture)
        let suffixswipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.suffixbtnClicked(_:)))
        suffixswipeGesture.delegate = self
        suffixswipeGesture.direction = .down
        self.suffixOverlayBtn.addGestureRecognizer(suffixswipeGesture)
        let suffixswipeupGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.suffixbtnClicked(_:)))
        suffixswipeupGesture.delegate = self
        suffixswipeupGesture.direction = .down
        self.suffixOverlayBtn.addGestureRecognizer(suffixswipeupGesture)
        loadIntialData()
    }
    //for landscape mode
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        let appDel = UIApplication.shared.delegate as! AppDelegate
        //        appDel.currentOrientation = .landscapeRight
        //        UIDevice.current.setValue( UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        //        UIViewController.attemptRotationToDeviceOrientation()
        
    }
    
    //in viewWillDisappear rotate to portrait can not fix the bug
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewWidthSettings()
    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        //        let appDel = UIApplication.shared.delegate as! AppDelegate
        //        appDel.currentOrientation = .portrait
        //        UIDevice.current.setValue( UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        //        UIViewController.attemptRotationToDeviceOrientation() //must call
        super.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetbtnClicked(_ sender: UIButton) {
        self.delegate?.loadDataFunctionAgain()
    }
    
    //MARK: Mode Management Functions
    func loadIntialData() {
        picker1.isUserInteractionEnabled = true
        picker2.isUserInteractionEnabled = true
        picker4.isUserInteractionEnabled = true
        picker5.isUserInteractionEnabled = true
        picker6.isUserInteractionEnabled = true
        picker1.alpha = 1.0
        picker2.alpha = 1.0
        picker4.alpha = 1.0
        picker5.alpha = 1.0
        picker6.alpha = 1.0
        movies = DBManager.shared.loadMovies()
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
            if wordArrayDB.contains(item.word) {
            }else{
                wordArrayDB.append(item.word)
            }
        }
        deviceScreenWidth = UIScreen.main.bounds.width
        //deviceScreenWidth/3
        pickerviewWidth = 40
        picker1Leading.constant = 40
        picker3Leading.constant = 0
        picker6Leading.constant = 0
        Prview2.isHidden = true
        Prview4.isHidden = true
        Prview5.isHidden = true
        picker1Width.constant = (deviceScreenWidth - 60)/3
        picker3Width.constant = (deviceScreenWidth - 60)/3
        picker6Width.constant = (deviceScreenWidth - 60)/3
        picker6Trailing.constant = 40
        rootBtn.alpha = 0.0
        self.rootBtn.alpha = 1.0
//        UIView.animate(withDuration: 1.0,
//                       delay: 0.0,
//                       options: [UIView.AnimationOptions.curveLinear,
//                                 UIView.AnimationOptions.repeat,
//                                 UIView.AnimationOptions.autoreverse],
//                       animations: { self.rootBtn.alpha = 1.0 },
//                       completion: nil)
        self.view.layoutIfNeeded()
    }
    func viewWidthSettings() {
        //        if UIDevice.current.orientation.isLandscape {
        //                   deviceScreenWidth = UIScreen.main.bounds.height
        //               } else {
        //                   deviceScreenWidth = UIScreen.main.bounds.width
        //               }
        deviceScreenWidth = UIScreen.main.bounds.width
        picker1Width.constant = (deviceScreenWidth - 60)/3
        picker3Width.constant = (deviceScreenWidth - 60)/3
        picker6Width.constant = (deviceScreenWidth - 60)/3
    }
    //MARK: PopUpView Ations
    @IBAction func meanigpopupACtion(_ sender: UIButton) {
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
            self.meaningPopupView.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func showMeaningPopupView(_ sender: UIButton) {
        meaningPopupView.alpha = 0
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.meaningPopupView.isHidden = false
            self.meaningPopupView.alpha = 1
        }, completion: nil)
        switch sender.tag {
        case 10:
            meaningHeadLbl.text = prefix1Value
            meaningheadTextview.text = prefix1Lbl.text
            break
        case 11:
            meaningHeadLbl.text = prefix2Value
            meaningheadTextview.text = prefix2lbl.text
            break
        case 12:
            meaningHeadLbl.text = rootValue
            meaningheadTextview.text = rootlbl.text
            break
        case 13:
            meaningHeadLbl.text = suffix1Value
            meaningheadTextview.text = suffix1Lbl.text
            break
        case 14:
            meaningHeadLbl.text = suffix2Value
            meaningheadTextview.text = suffix2Lbl.text
            break
        case 15:
            meaningHeadLbl.text = suffix3Value
            meaningheadTextview.text = suffix3lbl.text
            break
        default:
            break
        }
    }
    @IBAction func CLOSE(_ sender: UIButton) {
        sender.setImage(UIImage(named:"bown"), for: .normal)
        prefix1Img.layer.removeAllAnimations()
        rootImg.layer.removeAllAnimations()
        prefix2Img.layer.removeAllAnimations()
        suffix1Img.layer.removeAllAnimations()
        suffix2Img.layer.removeAllAnimations()
        suffix3Img.layer.removeAllAnimations()
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            if  self.popupviewBottom.constant == -667+(UIScreen.main.bounds.height){
                self.popupviewBottom.constant =  -541
                self.view.layoutIfNeeded()
            }
            else{
                self.popupviewBottom.constant = -667
                self.view.layoutIfNeeded()
            }
        }, completion: nil)
    }
    @IBAction func ShowDetailsOfWord(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            meaningButton.isSelected = true
            meaningButton.setTitleColor(UIColor.getCustomBlueColor(), for: .normal)
            listButton.isSelected = false
            listButton.setTitleColor(UIColor.white, for: .normal)
            synonymsButton.isSelected = false
            synonymsButton.setTitleColor(UIColor.white, for: .normal)
        case 2:
            meaningButton.isSelected = false
            meaningButton.setTitleColor(UIColor.white, for: .normal)
            listButton.isSelected = true
            listButton.setTitleColor(UIColor.getCustomBlueColor(), for: .normal)
            synonymsButton.isSelected = false
            synonymsButton.setTitleColor(UIColor.white, for: .normal)
        case 3:
            meaningButton.isSelected = false
            meaningButton.setTitleColor(UIColor.white, for: .normal)
            listButton.isSelected = false
            listButton.setTitleColor(UIColor.white, for: .normal)
            synonymsButton.isSelected = true
            synonymsButton.setTitleColor(UIColor.getCustomBlueColor(), for: .normal)
        default:
            meaningButton.isSelected = false
            meaningButton.setTitleColor(UIColor.white, for: .normal)
            listButton.isSelected = false
            listButton.setTitleColor(UIColor.white, for: .normal)
            synonymsButton.isSelected = false
            synonymsButton.setTitleColor(UIColor.white, for: .normal)
        }
        closeBtn.setImage(UIImage(named:"close"), for: .normal)
        UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
            self.popupviewBottom.constant = -667+(UIScreen.main.bounds.height)
            self.view.layoutIfNeeded()
        }, completion: nil)
        switch sender.tag {
        case 1:
            listView.isHidden = true
            self.MeaningTextView.isHidden = false
            print(".......ShowDetailsOfWord.........")
            print(selectedWordArr)
            moviesRoot=DBManager.shared.loadMovie(withDataWord: selectedWordArr[0], prefix2: selectedWordArr[1], root: selectedWordArr[2], suffix1: selectedWordArr[3], suffix2: selectedWordArr[4], suffix3: selectedWordArr[5])
            let meaningArr : NSMutableArray = []
            let partofSpeachArr : NSMutableArray = []
            for item in moviesRoot {
                if item.meaning != "" {
                    meaningArr.add(item.meaning)
                    partofSpeachArr.add(item.part_speech)
                }
            }
            var str: String = ""
            for var i in (0..<meaningArr.count){
                str += "\(partofSpeechDict["\(partofSpeachArr[i])"] as! String):\n\(meaningArr[i])\n"
            }
            let stringVar : NSString = str as NSString
            let newString  = stringVar.replacingOccurrences(of: "<br />", with: "", options: .literal, range: NSRange(location: 0, length: stringVar.length))
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Corbel", size: 24.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            let myAttrString = NSAttributedString(string: newString, attributes: myAttribute)
            self.MeaningTextView.attributedText = myAttrString
            self.MeaningTextView.textAlignment = .center
            break
        case 2:
            items = DBManager.shared.loadMovie(withRoot: rootValue as NSString)
            var str: [String] = []
            for var i in (0..<items.count){
                str.append(items[i].word)
            }
            let stringRepresentation = str.joined(separator: ", ")
            self.MeaningTextView.text = stringRepresentation as String
            self.MeaningTextView.textAlignment = .center
            self.MeaningTextView.isHidden = false
            listView.isHidden = true
            break
        case 3:
            self.MeaningTextView.isHidden = true
            listView.isHidden = false
            synonymLbl.text = "Select the right synonym for  " + "\"" + (resultLbl.text! as String) + "\""
            items = DBManager.shared.loadMovie(withRoot: rootValue as NSString)
            testArr.removeAllObjects()
            didselectStatus = false
            
            if let id = resultLbl.text {
                DBManager.shared.loadMovie(withWordSynonym: id, completionHandler: { (movie) in
                    DispatchQueue.main.async {
                        if movie != nil {
                            if movie?.synonym != "" {
                                self.nosynonymLbl.isHidden = true
                                self.templateList.isHidden = false
                                self.MeaningTextView.text = movie?.synonym
                                for var i in (0..<self.items.count) {
                                    if self.items[i].synonym != ""{
                                        if self.testArr.count < 4 {
                                            if self.items[i].synonym != movie?.synonym{
                                                self.testArr.add(self.items[i].synonym)
                                            } else if self.items[self.items.count-1].synonym != movie?.synonym{
                                                self.testArr.add(self.items[self.items.count-1].synonym)
                                                
                                            }
                                        }
                                    }
                                }
                                // self.testArr.add((movie?.synonym)! as String)
                                if self.testArr.contains((movie?.synonym)! as String){
                                }
                                else{
                                    let   random1 :Int = Int(arc4random_uniform(4))
                                    self.testArr.removeObject(at: random1)
                                    self.testArr.insert((movie?.synonym)! as String, at: random1)
                                }
                                self.templateList.reloadData()
                            }
                            else{
                                self.nosynonymLbl.isHidden = false
                                self.templateList.isHidden = true
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
    func attributedText(str : NSString)->NSAttributedString{
        var attributedString = NSMutableAttributedString(string: str as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont(name: "corbel", size: CGFloat(17.0))]
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: str.length))
        attributedString.addAttributes(boldFontAttribute, range: str.range(of: ":"))
        return attributedString
    }
    //MARK: Picker Button Actions
    @IBAction func prefixbtnClicked(_ sender: UIButton) {
        let   random1 :Int = Int(arc4random_uniform(10000))
        prefixBtn.isHidden = true
        picker1.isHidden = false
        prefixOverlayBtn.isHidden = true
        self.picker1.selectRow(random1, inComponent: 0, animated: true)
        self.pickerView(self.picker1, didSelectRow: random1, inComponent: 0)
    }
    @IBAction func rootbtnClicked(_ sender: UIButton) {
        rootBtn.isHidden = true
        rootOverlayBtn.isHidden = true
        picker3.isHidden = false
        let   random1 :Int = Int(arc4random_uniform(10000))
        self.picker3.selectRow(random1, inComponent: 0, animated: true)
        //deviceScreenWidth/3
        self.pickerView(self.picker3, didSelectRow: random1, inComponent: 0)
    }
    
    @IBAction func suffixbtnClicked(_ sender: UIButton) {
        let   random1 :Int = Int(arc4random_uniform(10000))
        suffixbtn.isHidden = true
        picker6.isHidden = false
        suffixOverlayBtn.isHidden = true
        self.picker6.selectRow(random1, inComponent: 0, animated: true)
        self.pickerView(self.picker6, didSelectRow: random1, inComponent: 0)
    }
    
    //MARK: MenuButton Actions
    @IBAction func menuBtnClicked(_ sender: UIButton) {
        if menubtnClicked{
            self.menubtnClicked = false
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.grammerTop.constant = -28
                self.instructionTop.constant = -28
                self.view.layoutIfNeeded()
            }, completion: { finish in
                UIView.animate(withDuration: 0.1){
                    self.menuBtnView.isHidden = true
                }
            })
        }
        else{
            self.menubtnClicked = true
            self.menuBtnView.isHidden = false
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.grammerTop.constant = 0
                self.instructionTop.constant = 7
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    @IBAction func GrammerClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "grammerVC", sender: self)
    }
    @IBAction func instructionClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toInstructionAnyVC", sender: self)
    }
    
    //MARK: UITapgesture Actions
    @objc func tapprefix1PickerButton(_ sender: UITapGestureRecognizer) {
        if prefix1Value != ""{
            let id = prefix1Value
            DBManager.shared.loadWordmeaning(withWord: id, completionHandler: { (movie) in
                DispatchQueue.main.async {
                    if movie != nil {
                        self.prefix1lblView.isHidden = false
                        self.prefix1Lbl.text = movie?.meaning
                    }
                    else{
                        self.prefix1lblView.isHidden = false
                        self.prefix1Lbl.text = ""
                    }
                }
            })
        }
    }
    @objc func tapPrefix2PickerButton(_ sender: UITapGestureRecognizer) {
        if prefix2Value != ""{
            let id = prefix2Value
            DBManager.shared.loadWordmeaning(withWord: id, completionHandler: { (movie) in
                DispatchQueue.main.async {
                    if movie != nil {
                        self.prefix2lblView.isHidden = false
                        self.prefix2lbl.text = movie?.meaning
                    }
                    else{
                        self.prefix2lblView.isHidden = false
                        self.prefix2lbl.text = ""
                    }
                }
            })
        }
    }
    @objc func tapRootPickerButton(_ sender: UITapGestureRecognizer) {
        if rootValue != ""{
            let id = rootValue
            DBManager.shared.loadWordmeaning(withWord: id, completionHandler: { (movie) in
                DispatchQueue.main.async {
                    if movie != nil {
                        self.rootlblView.isHidden = false
                        self.rootlbl.text = movie?.meaning
                    }
                    else{
                        self.rootlblView.isHidden = false
                        self.rootlbl.text = ""
                    }
                }
            })
        }
    }
    @objc func tapSuffix1PickerButton(_ sender: UITapGestureRecognizer) {
        if suffix1Value != ""{
            let id = suffix1Value
            DBManager.shared.loadWordmeaning(withWord: id, completionHandler: { (movie) in
                DispatchQueue.main.async {
                    if movie != nil {
                        self.suffix1lblView.isHidden = false
                        self.suffix1Lbl.text = movie?.meaning
                    }
                    else{
                        self.suffix1lblView.isHidden = false
                        self.suffix1Lbl.text = ""
                    }
                }
            })
        }
    }
    @objc func tapSuffix2PickerButton(_ sender: UITapGestureRecognizer) {
        if suffix2Value != ""{
            let id = suffix2Value
            DBManager.shared.loadWordmeaning(withWord: id, completionHandler: { (movie) in
                DispatchQueue.main.async {
                    if movie != nil {
                        self.suffix2lblView.isHidden = false
                        self.suffix2Lbl.text = movie?.meaning
                    }
                    else{
                        self.suffix2lblView.isHidden = false
                        self.suffix2Lbl.text = ""
                    }
                }
            })
        }
    }
    @objc func tapSuffix3PickerButton(_ sender: UITapGestureRecognizer) {
        if suffix3Value != ""{
            //            var myStringArr = suffix3Value.components(separatedBy: " ")
            //            let id = myStringArr[0]
            let id = suffix3Value
            
            DBManager.shared.loadWordmeaning(withWord: id, completionHandler: { (movie) in
                DispatchQueue.main.async {
                    if movie != nil {
                        self.suffix3LblView.isHidden = false
                        self.suffix3lbl.text = "\((movie?.meaning)! as String)(\((movie?.part_speech)! as String))"
                    }
                    else{
                        self.suffix3LblView.isHidden = false
                        self.suffix3lbl.text = ""
                    }
                }
            })
        }
    }
    
    @objc func showMeaningGestureTapped(_ sender: UITapGestureRecognizer){
        self.wordformBtn.isHidden = true
        print(".......showMeaningGestureTapped.........")
        print(selectedWordArr)
        DBManager.shared.loadwordFromDB(withWord: selectedWordArr[0], prefix2: selectedWordArr[1], root: selectedWordArr[2], suffix1: selectedWordArr[3], suffix2: selectedWordArr[4], suffix3: selectedWordArr[5], completionHandler: { (movie) in
            DispatchQueue.main.async {
                if movie != nil {
                    self.resultWord = movie!.word
                    if self.wordArrayDB.contains(self.resultWord){
                        self.randomTimer.invalidate()
                        self.resultView.isHidden = false
                        self.resultLbl.text = self.resultWord  as String
                        self.meaningButton.isSelected = false
                        self.meaningButton.setTitleColor(UIColor.white, for: .normal)
                        self.listButton.isSelected = false
                        self.listButton.setTitleColor(UIColor.white, for: .normal)
                        self.synonymsButton.isSelected = false
                        self.synonymsButton.setTitleColor(UIColor.white, for: .normal)
                        if self.popupviewBottom.constant   ==  -541 {
                            UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
                                if  self.popupviewBottom.constant == -667+(UIScreen.main.bounds.height){
                                    self.popupviewBottom.constant =  -541
                                    self.view.layoutIfNeeded()
                                }
                                else{
                                    self.popupviewBottom.constant = -667
                                    self.view.layoutIfNeeded()
                                }
                            }, completion: nil)
                        }
                        else{
                            UIView.animate(withDuration:0.5, delay: 0, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
                                self.popupviewBottom.constant =  -541
                                self.view.layoutIfNeeded()
                            }, completion: nil)
                        }
                    }
                }
            }
        })
    }
    //MARK: WordCheckking Function
    func wordform() {
        self.wordformBtn.isHidden = true
        print(".......wordform().........")
        print(selectedWordArr)
        DBManager.shared.loadwordFromDB(withWord: selectedWordArr[0], prefix2: selectedWordArr[1], root: selectedWordArr[2], suffix1: selectedWordArr[3], suffix2: selectedWordArr[4], suffix3: selectedWordArr[5], completionHandler: { (movie) in
            DispatchQueue.main.async {
                if movie != nil {
                    self.resultWord = movie!.word
                    if self.wordArrayDB.contains(self.resultWord){
                        self.wordformBtn.isHidden = false
                    }
                }
            }
        })
    }
    
    //MARK: Back Navigation Function
    @IBAction func back(_ sender: UIButton) {
        randomTimer.invalidate()
        print( self.navigationController!.viewControllers)
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK:UIPicker Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10000
    }
    
    //MARK:UIPicker Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.picker1{
            return pickerdataPrefix1[row%pickerdataPrefix1.count]}
        else if pickerView == self.picker2{
            return pickerdataPrefix2[row%pickerdataPrefix2.count]}
        else if pickerView == self.picker3{
            return pickerdataRoot[row%pickerdataRoot.count]}
        else if pickerView == self.picker4{
            return pickerdataSuffix1[row%pickerdataSuffix1.count]}
        else if pickerView == self.picker5{
            return pickerdataSuffix2[row%pickerdataSuffix2.count]}
        else{
            return pickerdataSuffix3[row%pickerdataSuffix3.count]
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
        let pickerLabel = UILabel()
        pickerLabel.minimumScaleFactor = 0.5
        pickerLabel.adjustsFontSizeToFitWidth = true
        prefix1Img.layer.removeAllAnimations()
        rootImg.layer.removeAllAnimations()
        prefix2Img.layer.removeAllAnimations()
        suffix1Img.layer.removeAllAnimations()
        suffix2Img.layer.removeAllAnimations()
        suffix3Img.layer.removeAllAnimations()
        pickerLabel.adjustsFontSizeToFitWidth = true
        pickerLabel.minimumScaleFactor = 0.2
        var fontstyleBold :NSString = "corbel-Bold"
        if SharedInstance.sharedInstance.fontStylePicker == "AmericanTypewriter-Condensed"{
            fontstyleBold = "AmericanTypewriter-CondensedBold"
        }
        else if SharedInstance.sharedInstance.fontStylePicker == "ChalkboardSE-Regular" {
            fontstyleBold = "ChalkboardSE-Bold"
        }
        else if SharedInstance.sharedInstance.fontStylePicker == "Papyrus-Condensed" {
            fontstyleBold = "Papyrus-Condensed"
        }
        else if SharedInstance.sharedInstance.fontStylePicker == "ArialRoundedMTBold" {
            fontstyleBold = "ArialRoundedMTBold"
        }
        else{
            fontstyleBold  = "\(SharedInstance.sharedInstance.fontStylePicker)-Bold" as NSString
        }
        if row == Numberlist {
            if Numberlist == -1 {
            }else{
                pickerLabel.font = UIFont(name: fontstyleBold as String, size: shared.FontSizePicker-5)
                pickerLabel.textAlignment = NSTextAlignment.center
                pickerLabel.textColor = UIColor.black
                if pickerView == selectPiceker {
                    pickerLabel.alpha = 0
                    UIView.animate(withDuration: 1.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                        pickerLabel.alpha = 0.5
                        self.view.layoutIfNeeded()
                    }, completion: { finish in
                        UIView.animate(withDuration: 1.5){
                            pickerLabel.alpha = 1
                        }
                    })
                }else{
                    pickerLabel.textColor = UIColor.gray
                    pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
                    pickerLabel.textAlignment = NSTextAlignment.center
                }
            }
        }
        else{
            pickerLabel.textColor = UIColor.gray
            pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
            pickerLabel.textAlignment = NSTextAlignment.center
        }
        if (pickerView == self.picker1 && pickerdataPrefix1.count>0){
            pickerLabel.text =  pickerdataPrefix1[row%pickerdataPrefix1.count]
            pickerLabel.textColor = UIColor.gray
            pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
            pickerLabel.textAlignment = NSTextAlignment.center
        }
        else if (pickerView == self.picker2 && pickerdataPrefix2.count>0){
            pickerLabel.text =  pickerdataPrefix2[row%pickerdataPrefix2.count]
            pickerLabel.textColor = UIColor.gray
            pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
            pickerLabel.textAlignment = NSTextAlignment.center
        }
        else if (pickerView == self.picker3 && pickerdataRoot.count>0){
            pickerLabel.text =  pickerdataRoot[row%pickerdataRoot.count]
            pickerLabel.textColor = UIColor.gray
            pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
            pickerLabel.textAlignment = NSTextAlignment.center
        }
        else if (pickerView == self.picker4 && pickerdataSuffix1.count>0){
            pickerLabel.text =  pickerdataSuffix1[row%pickerdataSuffix1.count]
        }
        else if (pickerView == self.picker5&&pickerdataSuffix2.count>0){
            pickerLabel.textColor = UIColor.gray
            pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
            pickerLabel.textAlignment = NSTextAlignment.center
            pickerLabel.text =  pickerdataSuffix2[row%pickerdataSuffix2.count]
        }
        else if (pickerView == self.picker6&&pickerdataSuffix3.count>0) {
            pickerLabel.textColor = UIColor.gray
            pickerLabel.font = UIFont(name: SharedInstance.sharedInstance.fontStylePicker as String, size: shared.FontSizePicker-10)
            pickerLabel.textAlignment = NSTextAlignment.center
            pickerLabel.text =  pickerdataSuffix3[row%pickerdataSuffix3.count]
        }
        pickerLabel.font = UIFont(name: fontstyleBold as String, size: shared.FontSizePicker - 5)
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = pickerLabel.text?.uppercased()
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        Numberlist = pickerView.selectedRow(inComponent: 0)
        if  self.popupviewBottom.constant ==  -541 {
            self.CLOSE(UIButton())
        }
        selectPiceker = pickerView
        if pickerView == self.picker3&&pickerdataRoot.count>0{
            rootValue = pickerdataRoot[row%pickerdataRoot.count]
            NumberPicker3 = pickerView.selectedRow(inComponent: 0)
            if boolRoot{
                boolRoot = true
                let indexOfA = moviesbool.index(of: "root")
                if indexOfA == 0{
                    prefix1Value = ""
                    suffix3Value = ""
                    boolPrefix = false
                    boolSuffix = false
                    if moviesbool.count == 3{
                        moviesbool.removeLast()
                        moviesbool.removeLast()
                    }
                    else if moviesbool.count == 2{
                        moviesbool.removeLast()
                    }
                    selectedWordArr = ["","",pickerdataRoot[row%pickerdataRoot.count],"","",""]
                    pickerfirstValueActiondone(withFirstValue: "root",withFirstValueData:pickerdataRoot[row%pickerdataRoot.count] as NSString)
                }
                else if indexOfA == 1{
                    if moviesbool[0] == "prefix"{
                        suffix3Value = ""
                        boolSuffix = false
                    }else{
                        boolPrefix = false
                        prefix1Value = ""
                    }
                    if moviesbool.count == 3{
                        moviesbool.removeLast()
                    }
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",pickerdataRoot[row%pickerdataRoot.count],"","",""]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                    else{
                        selectedWordArr = ["","",pickerdataRoot[row%pickerdataRoot.count],"","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                }else if indexOfA == 2{
                    selectedWordArr = [prefix1Value,"",pickerdataRoot[row%pickerdataRoot.count],"","",suffix3Value]
                    if moviesbool[0] == "prefix"{
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "root" , thirdValueData:pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                    else{
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "prefix" , SecondValueData: prefix1Value as NSString,thirdValue: "root" , thirdValueData:pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                }
                else{
                }
            }else{
                boolRoot = true
                if moviesbool.count == 1 {
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",pickerdataRoot[row%pickerdataRoot.count],"","",""]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                    else{
                        selectedWordArr = ["","",pickerdataRoot[row%pickerdataRoot.count],"","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                }else if moviesbool.count == 2 {
                    selectedWordArr = [prefix1Value,"",pickerdataRoot[row%pickerdataRoot.count],"","",suffix3Value]
                    if moviesbool[0] == "prefix"{
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "root" , thirdValueData:pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                    else{
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "prefix" , SecondValueData: prefix1Value as NSString,thirdValue: "root" , thirdValueData:pickerdataRoot[row%pickerdataRoot.count] as NSString)
                    }
                }
                else{
                    selectedWordArr = ["","",pickerdataRoot[row%pickerdataRoot.count],"","",""]
                    pickerfirstValueActiondone(withFirstValue: "root",withFirstValueData:pickerdataRoot[row%pickerdataRoot.count] as NSString)
                }
            }
        }
        else if pickerView == self.picker1&&pickerdataPrefix1.count>0{
            boolPrefix1 = false
            pickerdataPrefix2.removeAll()
            prefix1Value = pickerdataPrefix1[row%pickerdataPrefix1.count]
            NumberPicker1 = pickerView.selectedRow(inComponent: 0)
            if boolPrefix{
                boolPrefix = true
                print(moviesbool)
                let indexOfA = moviesbool.index(of: "prefix")
                if indexOfA == 0
                {
                    if moviesbool.count == 3
                    {
                        moviesbool.removeLast()
                        moviesbool.removeLast()
                    }else if moviesbool.count == 2{
                        moviesbool.removeLast()
                    }
                    prefix2Value = ""
                    boolPrefix1 = false
                    rootValue = ""
                    suffix3Value = ""
                    boolRoot = false
                    boolSuffix = false
                    print(".......prefix1Value.........")
                    print(selectedWordArr)
                    selectedWordArr = [prefix1Value,"","","","",""]
                    pickerfirstValueActiondone(withFirstValue: "prefix",withFirstValueData:pickerdataPrefix1[row%pickerdataPrefix1.count] as NSString)
                }
                else if indexOfA == 1{
                    if moviesbool[0] == "root"{
                        boolSuffix = false
                        suffix3Value = ""
                    }else{
                        boolRoot = false
                        rootValue = ""
                    }
                    if moviesbool.count == 3
                    {
                        moviesbool.removeLast()
                    }
                    if rootValue != ""{
                        pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "prefix" , SecondValueData: pickerdataPrefix1[row%pickerdataPrefix1.count] as NSString)
                        selectedWordArr = [prefix1Value,"",rootValue,"","",""]
                    } else{
                        selectedWordArr = [prefix1Value,"","","","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "prefix" , SecondValueData: pickerdataPrefix1[row%pickerdataPrefix1.count] as NSString)
                    }
                }
                else{
                    if moviesbool[0] == "root"{
                        if suffix2Value != ""{
                            selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString,forthValue: "prefix" , forthValueData: prefix1Value as NSString)
                        }
                        else{
                            selectedWordArr = [prefix1Value,"",rootValue,"","",suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "prefix" , thirdValueData:prefix1Value as NSString)
                        }
                    }
                    else if moviesbool[0] == "suffix"{
                        if suffix2Value != ""{
                            selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString,forthValue: "prefix" , forthValueData: prefix1Value as NSString)
                        }
                        else{
                            selectedWordArr = [prefix1Value,"",rootValue,"","",suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "prefix" , thirdValueData:prefix1Value as NSString)
                        }
                    }
                }
            }else{
                boolPrefix = true
                if moviesbool.count == 1 {
                    if rootValue != ""{
                        pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "prefix" , SecondValueData: pickerdataPrefix1[row%pickerdataPrefix1.count] as NSString)
                        selectedWordArr = [prefix1Value,"",rootValue,"","",""]
                    } else{
                        selectedWordArr = [prefix1Value,"","","","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "prefix" , SecondValueData: pickerdataPrefix1[row%pickerdataPrefix1.count] as NSString)
                    }
                }
                else if moviesbool.count == 2 {
                    if suffix2Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString,forthValue: "prefix" , forthValueData: prefix1Value as NSString)
                    }
                    else{
                        selectedWordArr = [prefix1Value,"",rootValue,"","",suffix3Value]
                        if moviesbool[0] == "root"{
                            pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "prefix" , thirdValueData:prefix1Value as NSString)
                        }else{
                            pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "prefix" , thirdValueData:prefix1Value as NSString)
                        }
                    }
                }
                else{
                    selectedWordArr = [prefix1Value,"","","","",""]
                    pickerfirstValueActiondone(withFirstValue: "prefix",withFirstValueData:pickerdataPrefix1[row%pickerdataPrefix1.count] as NSString)
                }
            }
        }
        else if pickerView == self.picker6&&pickerdataSuffix3.count>0{
            boolSuffix1 = false
            boolSuffix2 = false
            pickerdataSuffix2.removeAll()
            pickerdataSuffix1.removeAll()
            suffix3Value = pickerdataSuffix3[row%pickerdataSuffix3.count]
            if boolSuffix{
                boolSuffix = true
                let indexOfA = moviesbool.index(of: "suffix")
                if indexOfA == 0
                {
                    rootValue = ""
                    prefix1Value = ""
                    boolRoot = false
                    boolPrefix = false
                    if moviesbool.count == 3
                    {
                        moviesbool.removeLast()
                        moviesbool.removeLast()
                    }else if moviesbool.count == 2{
                        moviesbool.removeLast()
                    }
                    selectedWordArr = ["","","","","",suffix3Value]
                    pickerfirstValueActiondone(withFirstValue: "suffix",withFirstValueData:pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                }else if indexOfA == 1{
                    if moviesbool[0] == "root"{
                        boolPrefix = false
                        prefix1Value = ""
                    }else{
                        boolRoot = false
                        rootValue = ""
                    }
                    if moviesbool.count == 3
                    {
                        moviesbool.removeLast()
                    }
                    if rootValue != ""{
                        selectedWordArr = ["","",rootValue,"","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "suffix" , SecondValueData: pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                    }
                    else{
                        selectedWordArr = [prefix1Value,"","","","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "suffix" , SecondValueData: pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                    }
                }else{
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,"","",suffix3Value]
                        if moviesbool[0] == "root"{
                            pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "prefix" , SecondValueData: prefix1Value as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString)
                        }else{
                            pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString)
                        }
                    }
                    else{
                        selectedWordArr = ["","","","","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue: "suffix",withFirstValueData:pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                    }
                    
                }
                
            }else{
                boolSuffix = true
                if moviesbool.count == 1 {
                    if rootValue != ""{
                        selectedWordArr = ["","",rootValue,"","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "suffix" , SecondValueData: pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                    }
                    else{
                        selectedWordArr = [prefix1Value,"","","","",suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "suffix" , SecondValueData: pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                    }
                }else if moviesbool.count == 2 {
                    selectedWordArr = [prefix1Value,"",rootValue,"","",suffix3Value]
                    if moviesbool[0] == "root"{
                        pickerfirstValueActiondone(withFirstValue:"root" ,withFirstValueData:rootValue as NSString,SecondValue: "prefix" , SecondValueData: prefix1Value as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString)
                    }else{
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString)
                    }
                }else{
                    selectedWordArr = ["","","","","",suffix3Value]
                    pickerfirstValueActiondone(withFirstValue: "suffix",withFirstValueData:pickerdataSuffix3[row%pickerdataSuffix3.count] as NSString)
                }
            }
            NumberPicker6 = pickerView.selectedRow(inComponent: 0)
        }
        else if pickerView == self.picker5&&pickerdataSuffix2.count>0{
            suffix2Value = pickerdataSuffix2[row%pickerdataSuffix2.count]
            boolSuffix1data = true
            NumberPicker5 = pickerView.selectedRow(inComponent: 0)
            if boolSuffix1{
                boolSuffix1 = true
                let indexOfA = moviesbool2nd.index(of: "suffix1")
                if indexOfA == 0
                {
                    if moviesbool2nd.count == 2
                    {
                        moviesbool2nd.removeLast()
                    }
                    prefix2Value = ""
                    suffix1Value = ""
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString)
                    }
                    else{
                        selectedWordArr = ["","",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString)
                    }
                }else if indexOfA == 1{
                    suffix1Value = ""
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,"",suffix2Value,suffix3Value]
                    pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "prefix1" , forthValueData: prefix2Value as NSString  ,fifthValue: "suffix1" , fifthValueData: suffix2Value as NSString)
                }
                else{
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString)
                    }
                    else{
                        selectedWordArr = ["","",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString)
                    }
                }
            }else{
                boolSuffix1 = true
                if moviesbool2nd.count == 1 {
                    if prefix1Value != ""{
                        if prefix2Value != ""{
                            selectedWordArr = [prefix1Value,prefix2Value,rootValue,"",suffix2Value,suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "prefix1" , forthValueData: prefix2Value as NSString  ,fifthValue: "suffix1" , fifthValueData: suffix2Value as NSString)
                        }
                        else{
                            selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString)
                        }
                    }
                    else{
                        selectedWordArr = ["","",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString)
                    }
                }
                else{
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString)
                    }
                    else{
                        selectedWordArr = ["","",rootValue,"",suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"suffix" ,withFirstValueData:suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix2Value as NSString)
                    }
                }
            }
        }
        else if pickerView == self.picker4&&pickerdataSuffix1.count>0{
            suffix1lblView.isHidden = true
            suffix1Value = pickerdataSuffix1[row%pickerdataSuffix1.count]
            if boolSuffix2{
                boolSuffix2 = true
                let indexOfA = moviesbool2nd.index(of: "suffix2")
                if indexOfA == 1
                {
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString  ,fifthValue: "suffix2" , fifthValueData: suffix1Value as NSString)
                    }
                    else{
                        selectedWordArr = ["","",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        if moviesbool[0] == "root"{
                            pickerfirstValueActiondone(withFirstValue: "root", withFirstValueData: rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString )
                        }
                        else{
                            pickerfirstValueActiondone(withFirstValue: "suffix", withFirstValueData: suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString )
                        }
                    }
                }
                else if indexOfA == 2{
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,suffix1Value,suffix2Value,suffix3Value]
                }
                else{
                    if prefix1Value != ""{
                        if boolPrefix1{
                            selectedWordArr = [prefix1Value,prefix2Value,rootValue,suffix1Value,suffix2Value,suffix3Value]
                        }
                        else{
                            selectedWordArr = [prefix1Value,"",rootValue,suffix1Value,suffix2Value,suffix3Value]
                            pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString  ,fifthValue: "suffix2" , fifthValueData: suffix1Value as NSString)
                        }
                    }
                    else{
                        selectedWordArr = ["","",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        if moviesbool[0] == "root"{
                            pickerfirstValueActiondone(withFirstValue: "root", withFirstValueData: rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString )
                        }
                        else{
                            pickerfirstValueActiondone(withFirstValue: "suffix", withFirstValueData: suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString )
                        }
                    }
                }
            }
            else{
                boolSuffix2 = true
                if moviesbool2nd.count == 2 {
                    if prefix2Value != ""{
                        selectedWordArr = [prefix1Value,prefix2Value,rootValue,suffix1Value,suffix2Value,suffix3Value]
                    }
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString  ,fifthValue: "suffix2" , fifthValueData: suffix1Value as NSString)
                    }
                    else{
                        selectedWordArr = ["","",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        if moviesbool[0] == "root"{
                            pickerfirstValueActiondone(withFirstValue: "root", withFirstValueData: rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString)
                        }
                        else{
                            pickerfirstValueActiondone(withFirstValue: "suffix", withFirstValueData: suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString)
                        }
                    }
                }
                else{
                    if prefix1Value != ""{
                        selectedWordArr = [prefix1Value,"",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString  ,fifthValue: "suffix2" , fifthValueData: suffix1Value as NSString       )
                    }
                    else{
                        selectedWordArr = ["","",rootValue,suffix1Value,suffix2Value,suffix3Value]
                        if moviesbool[0] == "root"{
                            pickerfirstValueActiondone(withFirstValue: "root", withFirstValueData: rootValue as NSString,SecondValue: "suffix" , SecondValueData: suffix3Value as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString )
                        }
                        else{
                            pickerfirstValueActiondone(withFirstValue: "suffix", withFirstValueData: suffix3Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix1" , thirdValueData:suffix1Value as NSString,forthValue: "suffix2" , forthValueData: suffix1Value as NSString )
                        }
                    }
                }
            }
            self.picker4.reloadComponent(0)
        }
        else if pickerView == self.picker2&&pickerdataPrefix2.count>0{
            NumberPicker2 = pickerView.selectedRow(inComponent: 0)
            prefix2Value = pickerdataPrefix2[row%pickerdataPrefix2.count]
            if boolPrefix1{
                boolPrefix1 = true
                let indexOfA = moviesbool2nd.index(of: "prefix1")
                if indexOfA == 0
                {
                    if moviesbool2nd.count == 2
                    {
                        moviesbool2nd.removeLast()
                    }
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,"","",suffix3Value]
                    pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "prefix1" , forthValueData: prefix2Value as NSString)
                }else if indexOfA == 1{
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,"",suffix2Value,suffix3Value]
                    pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString  ,fifthValue: "prefix1" , fifthValueData: prefix2Value as NSString )
                }
                else if indexOfA == 2{
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,suffix1Value,suffix2Value,suffix3Value]
                }
            }else{
                boolSuffix2 = true
                if moviesbool2nd.count == 2 {
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,suffix1Value,suffix2Value,suffix3Value]
                }else if moviesbool2nd.count == 1 {
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,"",suffix2Value,suffix3Value]
                    pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "suffix1" , forthValueData: suffix2Value as NSString  ,fifthValue: "prefix1" , fifthValueData: prefix2Value as NSString       )
                }
                else{
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,"","",suffix3Value]
                    pickerfirstValueActiondone(withFirstValue:"prefix" ,withFirstValueData:prefix1Value as NSString,SecondValue: "root" , SecondValueData: rootValue as NSString,thirdValue: "suffix" , thirdValueData:suffix3Value as NSString,forthValue: "prefix1" , forthValueData: prefix2Value as NSString)
                }
            }
            boolPrefix1 = true
            if boolSuffix1 {
                if boolSuffix2 {
                    selectedWordArr = [prefix1Value,prefix2Value,rootValue,suffix1Value,suffix2Value,suffix3Value]
                }else{
                }
                
            }else{
                if moviesbool.count == 3{
                }
            }
        }
        self.view.layoutIfNeeded()
        wordform()
    }
    
    func pickerfirstValueActiondone(withFirstValue FirstValue: NSString,withFirstValueData FirstValueData: NSString,SecondValue: NSString , SecondValueData: NSString,thirdValue: NSString , thirdValueData: NSString,forthValue: NSString , forthValueData: NSString,fifthValue: NSString , fifthValueData: NSString){
        if fifthValue == "prefix"{
            if moviesbool.count == 2{
                moviesbool.append(forthValue as String)
            }else{
                moviesbool[2] = forthValue as String
            }
        }
        else{
            if moviesbool2nd.count == 1{
                moviesbool2nd.append(fifthValue as String)
            }else{
                moviesbool2nd[1] = fifthValue as String
            }
        }
        let   random1 :Int = Int(arc4random_uniform(10000))
        if fifthValue == "prefix1"{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: rootValue as NSString, SecondValue:"prefix", SecondValueData: prefix1Value as NSString,ThirdValue:"suffix",ThirdValueData:suffix3Value as NSString,ForthValue:"suffix1",ForthValueData:suffix2Value as NSString,FifthValue:"prefix1",FifthValueData:prefix2Value as NSString)
            if moviesRoot != nil{
                if boolSuffix1 == false{
                    pickerdataSuffix1.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataSuffix1.contains(item.suffix_1) {
                    }else{
                        if item.suffix_1 != "" {
                            pickerdataSuffix1.append(item.suffix_1)
                        }
                    }
                }
                pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix1.count > 0{
                    self.pickerView(self.picker4, didSelectRow: random1, inComponent: 0)
                    self.picker4.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        else if fifthValue == "suffix1"{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: rootValue as NSString, SecondValue:"prefix", SecondValueData: prefix1Value as NSString,ThirdValue:"suffix",ThirdValueData:suffix3Value as NSString,ForthValue:"prefix1",ForthValueData:prefix2Value as NSString,FifthValue:"suffix1",FifthValueData:suffix2Value as NSString)
            if moviesRoot != nil{
                if boolSuffix1 == false{
                    pickerdataSuffix1.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataSuffix1.contains(item.suffix_1) {
                    }else{
                        if item.suffix_1 != "" {
                            pickerdataSuffix1.append(item.suffix_1)
                        }
                    }
                }
                pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix1.count > 0{
                    self.pickerView(self.picker4, didSelectRow: random1, inComponent: 0)
                    self.picker4.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        else{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: rootValue as NSString, SecondValue:"prefix", SecondValueData: prefix1Value as NSString,ThirdValue:"suffix",ThirdValueData:suffix3Value as NSString,ForthValue:"suffix1",ForthValueData:suffix2Value as NSString,FifthValue:"suffix2",FifthValueData:suffix1Value as NSString)
            if moviesRoot != nil{
                if boolPrefix1 == false{
                    pickerdataPrefix2.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataPrefix2.contains(item.prefex_2) {
                    }else{
                        if item.prefex_2 != "" {
                            pickerdataPrefix2.append(item.prefex_2)
                        }
                    }
                }
                pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataPrefix2.count > 0{
                    self.pickerView(self.picker2, didSelectRow: random1, inComponent: 0)
                    self.picker2.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        if pickerdataPrefix2.count > 0{
            if pickerdataSuffix2.count > 0{
                if pickerdataSuffix1.count > 0{
                    /*deviceScreenWidth/6*/
                    picker1Width.constant = (deviceScreenWidth - 60)/6+25
                    picker3Width.constant = (deviceScreenWidth - 60)/6+25
                    picker6Width.constant = (deviceScreenWidth - 60)/6+25
                    picker2Width.constant = (deviceScreenWidth - 60)/6-15
                    picker4Width.constant = (deviceScreenWidth - 60)/6-15
                    picker5Width.constant = (deviceScreenWidth - 60)/6-15
                    picker5Leading.constant = picker4Width.constant
                    picker1Leading.constant = 30
                    picker3Leading.constant = picker2Width.constant
                    picker6Leading.constant = picker4Width.constant*2
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = false
                    Prview4.isHidden = false
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
                else{
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/5+20
                    picker3Width.constant = (deviceScreenWidth - 60)/5+20
                    picker6Width.constant = (deviceScreenWidth - 60)/5+20
                    picker2Width.constant = (deviceScreenWidth - 60)/5-30
                    picker4Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/5-30
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant = picker2Width.constant
                    picker6Leading.constant = picker5Width.constant
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = false
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
            }else{
                /*deviceScreenWidth/4*/
                picker1Width.constant = (deviceScreenWidth - 60)/4+20
                picker3Width.constant = (deviceScreenWidth - 60)/4+20
                picker6Width.constant = (deviceScreenWidth - 60)/4+20
                picker2Width.constant = (deviceScreenWidth - 60)/4-60
                picker4Width.constant = 0
                picker5Width.constant = 0
                picker5Leading.constant = 0
                picker1Leading.constant = 30
                picker3Leading.constant =  picker2Width.constant
                picker6Leading.constant = 0
                picker2Leading.constant = 0
                Prview2.isHidden = false
                Prview4.isHidden = true
                Prview5.isHidden = true
                picker6Trailing.constant = 40
            }
        }else{
            if pickerdataSuffix2.count > 0{
                /*deviceScreenWidth/4*/
                if pickerdataSuffix1.count > 0{
                    picker1Width.constant = (deviceScreenWidth - 60)/5+(36/3)
                    picker3Width.constant = (deviceScreenWidth - 60)/5+(36/3)
                    picker6Width.constant = (deviceScreenWidth - 60)/5+(36/3)
                    picker2Width.constant = 0
                    picker4Width.constant = (deviceScreenWidth - 60)/5-18
                    picker5Width.constant = (deviceScreenWidth - 60)/5-18
                    picker5Leading.constant =  picker4Width.constant
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant =  picker4Width.constant*2
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = false
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
                else{
                    picker1Width.constant = (deviceScreenWidth - 60)/4+20
                    picker3Width.constant = (deviceScreenWidth - 60)/4+20
                    picker6Width.constant = (deviceScreenWidth - 60)/4+20
                    picker2Width.constant = 0
                    picker4Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/4-60
                    picker4leading.constant = 0
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant = picker5Width.constant
                    picker2Leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
            }else{
                picker2Width.constant = 0
                picker4Width.constant = 0
                picker5Width.constant = 0
                picker5Leading.constant = 0
                Prview2.isHidden = true
                Prview4.isHidden = true
                Prview5.isHidden = true
                //deviceScreenWidth/3
                picker1Leading.constant = 30
                picker3Leading.constant = 0
                picker6Leading.constant = 0
                picker1Width.constant = (deviceScreenWidth - 60)/3
                picker3Width.constant = (deviceScreenWidth - 60)/3
                picker6Width.constant = (deviceScreenWidth - 60)/3
                picker6Trailing.constant = 40
            }
        }
        self.view.layoutIfNeeded()
    }
    
    func pickerfirstValueActiondone(withFirstValue FirstValue: NSString,withFirstValueData FirstValueData: NSString,SecondValue: NSString , SecondValueData: NSString,thirdValue: NSString , thirdValueData: NSString,forthValue: NSString , forthValueData: NSString){
        boolSuffix1 = false
        if forthValue == "prefix"{
            if moviesbool.count == 2{
                moviesbool.append(forthValue as String)
            }else{
                moviesbool[2] = forthValue as String
            }
        }
        else{
            if moviesbool2nd.count == 0{
                moviesbool2nd.append(forthValue as String)
            }else{
                moviesbool2nd[0] = forthValue as String
            }
        }
        let   random1 :Int = Int(arc4random_uniform(10000))
        if forthValue == "prefix1"{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: rootValue as NSString, SecondValue:"prefix", SecondValueData: prefix1Value as NSString,ThirdValue:"suffix",ThirdValueData:suffix3Value as NSString,ForthValue:"prefix1",ForthValueData:forthValueData as NSString)
            if moviesRoot != nil{
                if boolSuffix1 == false{
                    pickerdataSuffix1.removeAll()
                }
                if boolSuffix2 == false{
                    pickerdataSuffix2.removeAll()
                }
                for item in moviesRoot
                {
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
                }
                pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix1.count > 0{
                    self.picker4.reloadComponent(0)
                }
                if pickerdataSuffix2.count > 0{
                    self.pickerView(self.picker5, didSelectRow: random1, inComponent: 0)
                    self.picker5.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        else if forthValue == "suffix1"{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: rootValue as NSString, SecondValue:"prefix", SecondValueData: prefix1Value as NSString,ThirdValue:"suffix",ThirdValueData:suffix3Value as NSString,ForthValue:"suffix1",ForthValueData:forthValueData as NSString)
            if moviesRoot != nil{
                if boolSuffix2 == false{
                    pickerdataSuffix2.removeAll()
                }
                if boolPrefix1 == false{
                    pickerdataPrefix2.removeAll()
                }
                if boolSuffix1 == false{
                    pickerdataSuffix1.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataPrefix2.contains(item.prefex_2) {
                    }else{
                        if item.prefex_2 != "" {
                            pickerdataPrefix2.append(item.prefex_2)
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
                }
                pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix1.count > 0{
                    self.pickerView(self.picker4, didSelectRow: random1, inComponent: 0)
                    self.picker4.reloadComponent(0)
                }
                if pickerdataPrefix2.count > 0{
                    self.pickerView(self.picker2, didSelectRow: random1, inComponent: 0)
                    self.picker2.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        else if forthValue == "suffix2"{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "suffix", StartValueData: suffix3Value as NSString, SecondValue:"root", SecondValueData: rootValue as NSString,ThirdValue:"suffix1",ThirdValueData:suffix2Value as NSString,ForthValue:"suffix2",ForthValueData:forthValueData as NSString)
            if moviesRoot != nil{
                if boolPrefix == false{
                    pickerdataPrefix1.removeAll()
                }
                if boolPrefix1 == false{
                    pickerdataPrefix2.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataPrefix2.contains(item.prefex_2) {
                    }else{
                        if item.prefex_2 != "" {
                            pickerdataPrefix2.append(item.prefex_2)
                        }
                    }
                    if pickerdataPrefix1.contains(item.prefex_1) {
                    }else{
                        if item.prefex_1 != "" {
                            pickerdataPrefix1.append(item.prefex_1)
                        }
                    }
                }
                pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataPrefix1.count > 0{
                    self.picker1.reloadComponent(0)
                }
                if pickerdataPrefix2.count > 0{
                    self.pickerView(self.picker2, didSelectRow: random1, inComponent: 0)
                    self.picker2.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        else{
            moviesRoot=DBManager.shared.loadMovie(withStartValue: "suffix", StartValueData: suffix3Value as NSString, SecondValue:"root", SecondValueData: rootValue as NSString,ThirdValue:"suffix1",ThirdValueData:suffix2Value as NSString,ForthValue:"prefix",ForthValueData:forthValueData as NSString)
            if moviesRoot != nil{
                if boolSuffix1 == false{
                    pickerdataSuffix1.removeAll()
                }
                if boolPrefix1 == false{
                    pickerdataPrefix2.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataPrefix2.contains(item.prefex_2) {
                    }else{
                        if item.prefex_2 != "" {
                            pickerdataPrefix2.append(item.prefex_2)
                        }
                    }
                    if pickerdataSuffix1.contains(item.suffix_1) {
                    }else{
                        if item.suffix_1 != "" {
                            pickerdataSuffix1.append(item.suffix_1)
                        }
                    }
                }
                pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix1.count > 0{
                    self.pickerView(self.picker4, didSelectRow: random1, inComponent: 0)
                    self.picker4.reloadComponent(0)
                }
                if pickerdataPrefix2.count > 0{
                    self.pickerView(self.picker2, didSelectRow: random1, inComponent: 0)
                    self.picker2.reloadComponent(0)
                }
            }
            else{
                self.resetbtnClicked(UIButton())
            }
        }
        if pickerdataPrefix2.count > 0{
            if pickerdataSuffix2.count > 0{
                if pickerdataSuffix1.count > 0{
                    /*deviceScreenWidth/6*/
                    picker1Width.constant = (deviceScreenWidth - 60)/6+25
                    picker3Width.constant = (deviceScreenWidth - 60)/6+25
                    picker6Width.constant = (deviceScreenWidth - 60)/6+25
                    picker2Width.constant = (deviceScreenWidth - 60)/6-15
                    picker4Width.constant = (deviceScreenWidth - 60)/6-15
                    picker5Width.constant = (deviceScreenWidth - 60)/6-15
                    picker5Leading.constant = picker4Width.constant
                    picker1Leading.constant = 30
                    picker3Leading.constant = picker2Width.constant
                    picker6Leading.constant = picker4Width.constant*2
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = false
                    Prview4.isHidden = false
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
                else{
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/5+20
                    picker3Width.constant = (deviceScreenWidth - 60)/5+20
                    picker6Width.constant = (deviceScreenWidth - 60)/5+20
                    picker2Width.constant = (deviceScreenWidth - 60)/5-30
                    picker4Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/5-30
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant = picker2Width.constant
                    picker6Leading.constant = picker5Width.constant
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = false
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
            }else{
                /*deviceScreenWidth/4*/
                picker1Width.constant = (deviceScreenWidth - 60)/4+20
                picker3Width.constant = (deviceScreenWidth - 60)/4+20
                picker6Width.constant = (deviceScreenWidth - 60)/4+20
                picker2Width.constant = (deviceScreenWidth - 60)/4-60
                picker4Width.constant = 0
                picker5Width.constant = 0
                picker5Leading.constant = 0
                picker1Leading.constant = 30
                picker3Leading.constant =  picker2Width.constant
                picker6Leading.constant = 0
                picker2Leading.constant = 0
                Prview2.isHidden = false
                Prview4.isHidden = true
                Prview5.isHidden = true
                picker6Trailing.constant = 40
            }
        }else{
            if pickerdataSuffix2.count > 0{
                /*deviceScreenWidth/4*/
                if pickerdataSuffix1.count > 0{
                    picker1Width.constant = (deviceScreenWidth - 60)/5+(36/3)
                    picker3Width.constant = (deviceScreenWidth - 60)/5+(36/3)
                    picker6Width.constant = (deviceScreenWidth - 60)/5+(36/3)
                    picker2Width.constant = 0
                    picker4Width.constant = (deviceScreenWidth - 60)/5-18
                    picker5Width.constant = (deviceScreenWidth - 60)/5-18
                    picker5Leading.constant =  picker4Width.constant
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant =  picker4Width.constant*2
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = false
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }else{
                    picker1Width.constant = (deviceScreenWidth - 60)/4+20
                    picker3Width.constant = (deviceScreenWidth - 60)/4+20
                    picker6Width.constant = (deviceScreenWidth - 60)/4+20
                    picker2Width.constant = 0
                    picker4Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/4-60
                    picker4leading.constant = 0
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant = picker5Width.constant
                    picker2Leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
            }else{
                picker2Width.constant = 0
                picker4Width.constant = 0
                picker5Width.constant = 0
                picker5Leading.constant = 0
                Prview2.isHidden = true
                Prview4.isHidden = true
                Prview5.isHidden = true
                //deviceScreenWidth/3
                picker1Leading.constant = 30
                picker3Leading.constant = 0
                picker6Leading.constant = 0
                picker1Width.constant = (deviceScreenWidth - 60)/3
                picker3Width.constant = (deviceScreenWidth - 60)/3
                picker6Width.constant = (deviceScreenWidth - 60)/3
                picker6Trailing.constant = 40
            }
        }
        self.view.layoutIfNeeded()
    }
    
    func pickerfirstValueActiondone(withFirstValue FirstValue: NSString,withFirstValueData FirstValueData: NSString,SecondValue: NSString , SecondValueData: NSString,thirdValue: NSString , thirdValueData: NSString){
        boolPrefix1 = false
        boolSuffix1 = false
        if thirdValue == "suffix1"{
            if moviesbool2nd.count == 0{
                moviesbool2nd.append(thirdValue as String)
            }else{
                moviesbool2nd[0] = thirdValue as String
            }
        }
        else{
            moviesbool2nd.removeAll()
            if moviesbool.count == 2{
                moviesbool.append(thirdValue as String)
            }else{
                moviesbool[2] = thirdValue as String
            }
        }
        let   random1 :Int = Int(arc4random_uniform(10000))
        if FirstValue == "root"{
            if SecondValue == "prefix" {
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: FirstValueData as NSString, SecondValue:"prefix", SecondValueData: SecondValueData as NSString,ThirdValue:"suffix",ThirdValueData:thirdValueData as NSString)
            }else{
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: FirstValueData as NSString, SecondValue:"suffix", SecondValueData: SecondValueData as NSString,ThirdValue:"prefix",ThirdValueData:thirdValueData as NSString)
            }
        }else if FirstValue == "prefix"{
            if SecondValue == "root" {
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "prefix", StartValueData: FirstValueData as NSString, SecondValue:"root", SecondValueData: SecondValueData as NSString,ThirdValue:"suffix",ThirdValueData:thirdValueData as NSString)
            }else{
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "prefix", StartValueData: FirstValueData as NSString, SecondValue:"suffix", SecondValueData: SecondValueData as NSString,ThirdValue:"root",ThirdValueData:thirdValueData as NSString)
            }
        }else if FirstValue == "suffix"{
            if SecondValue == "root" {
                if thirdValue == "suffix1"{
                    moviesRoot=DBManager.shared.loadMovie(withStartValue: "suffix", StartValueData: FirstValueData as NSString, SecondValue:"root", SecondValueData: SecondValueData as NSString,ThirdValue:"suffix1",ThirdValueData:thirdValueData as NSString)
                }
                else{
                    moviesRoot=DBManager.shared.loadMovie(withStartValue: "suffix", StartValueData: FirstValueData as NSString, SecondValue:"root", SecondValueData: SecondValueData as NSString,ThirdValue:"prefix",ThirdValueData:thirdValueData as NSString)
                }
            }
            else{
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "suffix", StartValueData: FirstValueData as NSString, SecondValue:"prefix", SecondValueData: SecondValueData as NSString,ThirdValue:"root",ThirdValueData:thirdValueData as NSString)
            }
        }
        if moviesRoot != nil{
            
            if boolRoot == false{
                pickerdataRoot.removeAll()
            }
            if boolSuffix1 == false{
                pickerdataSuffix1.removeAll()
            }
            if boolSuffix2 == false{
                pickerdataSuffix2.removeAll()
            }
            if boolPrefix1 == false{
                pickerdataPrefix2.removeAll()
            }
            if boolPrefix == false{
                pickerdataPrefix1.removeAll()
            }
            for item in moviesRoot
            {
                if pickerdataPrefix1.contains(item.prefex_1) {
                }else{
                    if item.prefex_1 != "" {
                        pickerdataPrefix1.append(item.prefex_1)
                    }
                }
                if pickerdataPrefix2.contains(item.prefex_2) {
                }else{
                    if item.prefex_2 != "" {
                        pickerdataPrefix2.append(item.prefex_2)
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
                if pickerdataRoot.contains(item.root) {
                }else{
                    if item.root != "" {
                        pickerdataRoot.append(item.root)
                    }
                }
            }
            pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            if pickerdataPrefix2.count > 0 && boolPrefix{
                self.pickerView(self.picker2, didSelectRow: random1, inComponent: 0)
                self.picker2.reloadComponent(0)
            }
            if pickerdataSuffix1.count > 0&&boolSuffix2{
                self.pickerView(self.picker4, didSelectRow: random1, inComponent: 0)
                self.picker4.reloadComponent(0)
            }
            if pickerdataSuffix2.count > 0 {
                self.picker5.reloadComponent(0)
            }
        }
        else{
            self.resetbtnClicked(UIButton())
        }
        if pickerdataPrefix1.count > 0{
            if pickerdataPrefix2.count > 0&&boolPrefix{
                if pickerdataSuffix2.count > 0{
                    prefixBtn.isHidden = true
                    prefixOverlayBtn.isHidden = true
                    self.Prview1.isHidden = false
                    self.picker1.isHidden = false
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/5+20
                    picker3Width.constant = (deviceScreenWidth - 60)/5+20
                    picker6Width.constant = (deviceScreenWidth - 60)/5+20
                    picker2Width.constant = (deviceScreenWidth - 60)/5-30
                    picker4Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/5-30
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant = picker2Width.constant
                    picker6Leading.constant = picker5Width.constant
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = false
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                    
                }else{
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/4+20
                    picker3Width.constant = (deviceScreenWidth - 60)/4+20
                    picker6Width.constant = (deviceScreenWidth - 60)/4+20
                    picker2Width.constant = (deviceScreenWidth - 60)/4-60
                    picker4Width.constant = 0
                    picker5Width.constant = 0
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant =  picker2Width.constant
                    picker6Leading.constant = 0
                    picker2Leading.constant = 0
                    Prview2.isHidden = false
                    Prview4.isHidden = true
                    Prview5.isHidden = true
                    picker6Trailing.constant = 40
                }
            }
            else if pickerdataSuffix2.count > 0{
                if pickerdataSuffix1.count > 0&&boolSuffix2{
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/5+20
                    picker3Width.constant = (deviceScreenWidth - 60)/5+20
                    picker6Width.constant = (deviceScreenWidth - 60)/5+20
                    picker4Width.constant = (deviceScreenWidth - 60)/5-30
                    picker2Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/5-30
                    picker5Leading.constant = picker4Width.constant
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant = picker5Width.constant*2
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = false
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
                else{
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/4+20
                    picker3Width.constant = (deviceScreenWidth - 60)/4+20
                    picker6Width.constant = (deviceScreenWidth - 60)/4+20
                    picker5Width.constant = (deviceScreenWidth - 60)/4-60
                    picker4Width.constant = 0
                    picker2Width.constant = 0
                    picker2Leading.constant = 0
                    picker1Leading.constant = 30
                    picker6Leading.constant =  picker5Width.constant
                    picker2Leading.constant = 0
                    picker5Leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
            }
            else{
                picker2Width.constant = 0
                picker4Width.constant = 0
                picker5Width.constant = 0
                picker5Leading.constant = 0
                Prview2.isHidden = true
                Prview4.isHidden = true
                Prview5.isHidden = true
                //deviceScreenWidth/3
                picker1Leading.constant = 30
                picker3Leading.constant = 0
                picker6Leading.constant = 0
                picker1Width.constant = (deviceScreenWidth - 60)/3
                picker3Width.constant = (deviceScreenWidth - 60)/3
                picker6Width.constant = (deviceScreenWidth - 60)/3
                picker6Trailing.constant = 40
            }
        }
        else{
            if pickerdataSuffix2.count>0{
                if pickerdataSuffix1.count > 0{
                    /*deviceScreenWidth/4*/
                    picker1Width.constant = (deviceScreenWidth - 60)/5+20
                    picker3Width.constant = (deviceScreenWidth - 60)/5+20
                    picker6Width.constant = (deviceScreenWidth - 60)/5+20
                    picker2Width.constant = 0
                    picker4Width.constant = (deviceScreenWidth - 60)/5-30
                    picker5Width.constant = (deviceScreenWidth - 60)/5-30
                    picker5Leading.constant = picker4Width.constant
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant = picker5Width.constant*2
                    picker2Leading.constant = 0
                    picker4leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = false
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
                else{
                    /*deviceScreenWidth/4*/
                    prefixOverlayBtn.isHidden = true
                    prefixBtn.isHidden = true
                    self.Prview1.isHidden = false
                    self.picker1.isHidden = false
                    self.picker1.reloadComponent(0)
                    picker1Width.constant = (deviceScreenWidth - 60)/4+20
                    picker3Width.constant = (deviceScreenWidth - 60)/4+20
                    picker6Width.constant = (deviceScreenWidth - 60)/4+20
                    picker2Width.constant = 0
                    picker4Width.constant = 0
                    picker5Width.constant = (deviceScreenWidth - 60)/4-60
                    picker4leading.constant = 0
                    picker5Leading.constant = 0
                    picker1Leading.constant = 30
                    picker3Leading.constant = 0
                    picker6Leading.constant = picker5Width.constant
                    picker2Leading.constant = 0
                    Prview2.isHidden = true
                    Prview4.isHidden = true
                    Prview5.isHidden = false
                    picker6Trailing.constant = 40
                }
            }
            else{
                picker2Width.constant = 0
                picker4Width.constant = 0
                picker5Width.constant = 0
                picker5Leading.constant = 0
                Prview2.isHidden = true
                Prview4.isHidden = true
                Prview5.isHidden = true
                //deviceScreenWidth/3
                picker1Leading.constant = 30
                picker3Leading.constant = 0
                picker6Leading.constant = 0
                picker1Width.constant = (deviceScreenWidth - 60)/3
                picker3Width.constant = (deviceScreenWidth - 60)/3
                picker6Width.constant = (deviceScreenWidth - 60)/3
                picker6Trailing.constant = 40
            }
        }
        self.view.layoutIfNeeded()
    }
    
    func pickerfirstValueActiondone(withFirstValue FirstValue: NSString,withFirstValueData FirstValueData: NSString,SecondValue: NSString , SecondValueData: NSString){
        prefix1lblView.isHidden = true
        prefix2lblView.isHidden = true
        rootlblView.isHidden = true
        suffix1lblView.isHidden = true
        suffix2lblView.isHidden = true
        suffix3LblView.isHidden = true
        pickerdataPrefix2.removeAll()
        pickerdataSuffix2.removeAll()
        moviesbool2nd.removeAll()
        boolSuffix2 = false
        boolSuffix1 = false
        boolPrefix1 = false
        print(FirstValueData,SecondValueData)
        if moviesbool.count == 1{
            moviesbool.append(SecondValue as String)
        }else{
            moviesbool[1] = SecondValue as String
        }
        let   random1 :Int = Int(arc4random_uniform(10000))
        if FirstValue == "root"{
            if SecondValue == "prefix" {
                suffixbtn.isHidden = false
                picker6.isHidden = true
                suffixOverlayBtn.isHidden = false
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: FirstValueData as NSString, SecondValue:"prefix", SecondValueData: SecondValueData as NSString)
            }else{
                prefixBtn.isHidden = false
                picker1.isHidden = true
                prefixOverlayBtn.isHidden = false
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: FirstValueData as NSString, SecondValue:"suffix", SecondValueData: SecondValueData as NSString)
            }
        }else if FirstValue == "prefix"{
            if SecondValue == "root" {
                suffixbtn.isHidden = false
                picker6.isHidden = true
                suffixOverlayBtn.isHidden = false
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData: SecondValueData as NSString, SecondValue:"prefix", SecondValueData:FirstValueData  as NSString)
            }else{
                rootBtn.isHidden = false
                rootOverlayBtn.isHidden = false
                picker3.isHidden = true
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "prefix", StartValueData: FirstValueData as NSString, SecondValue:"suffix", SecondValueData: SecondValueData as NSString)
            }
        }else if FirstValue == "suffix"{
            if SecondValue == "root" {
                prefixBtn.isHidden = false
                picker1.isHidden = true
                prefixOverlayBtn.isHidden = false
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "root", StartValueData:SecondValueData  as NSString, SecondValue:"suffix", SecondValueData: FirstValueData as NSString)
            }else{
                rootBtn.isHidden = false
                rootOverlayBtn.isHidden = false
                picker3.isHidden = true
                moviesRoot=DBManager.shared.loadMovie(withStartValue: "prefix", StartValueData: SecondValueData as NSString, SecondValue:"suffix", SecondValueData: FirstValueData as NSString)
            }
        }
        if moviesRoot != nil{
            if boolSuffix1 == false{
                pickerdataSuffix1.removeAll()
            }
            if boolRoot == false{
                pickerdataRoot.removeAll()
            }
            if boolSuffix2 == false{
                pickerdataSuffix2.removeAll()
            }
            if boolPrefix1 == false{
                pickerdataPrefix2.removeAll()
            }
            for item in moviesRoot
            {
                if pickerdataPrefix2.contains(item.prefex_2) {
                }else{
                    if item.prefex_2 != "" {
                        pickerdataPrefix2.append(item.prefex_2)
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
                if pickerdataRoot.contains(item.root) {
                }else{
                    if item.root != "" {
                        pickerdataRoot.append(item.root)
                    }
                }
            }
            pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            switch (FirstValue,SecondValue) {
            case ("root","prefix"):
                if(moviesRoot.count > 0){
                    pickerdataPrefix2.removeAll()
                    pickerdataSuffix1.removeAll()
                    pickerdataSuffix2.removeAll()
                    pickerdataSuffix3.removeAll()
                }
                if boolSuffix == false{
                    pickerdataSuffix3.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataSuffix3.contains(item.suffix_3) {
                    }else{
                        if item.suffix_3 != "" {
                            pickerdataSuffix3.append(item.suffix_3)
                        }
                    }
                }
                pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix3.count > 0{
                    self.picker6.selectRow(random1, inComponent: 0, animated: true)
                }
                self.picker6.reloadComponent(0)
                break
            case ("root","suffix"):
                if(moviesRoot.count > 0){
                    pickerdataPrefix2.removeAll()
                    pickerdataPrefix1.removeAll()
                }
                if boolPrefix == false{
                    pickerdataPrefix1.removeAll()
                }
                if boolSuffix2 == false{
                    pickerdataSuffix2.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataPrefix1.contains(item.prefex_1) {
                    }else{
                        if item.prefex_1 != "" {
                            pickerdataPrefix1.append(item.prefex_1)
                        }
                    }
                    if pickerdataSuffix2.contains(item.suffix_2) {
                    }else{
                        if item.suffix_2 != "" {
                            pickerdataSuffix2.append(item.suffix_2)
                        }
                    }
                }
                pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataPrefix1.count > 0{
                    self.pickerView(self.picker1, didSelectRow: random1, inComponent: 0)
                    self.picker1.reloadComponent(0)
                }
                if pickerdataSuffix2.count > 0{
                    self.pickerView(self.picker5, didSelectRow: random1, inComponent: 0)
                    self.picker5.reloadComponent(0)
                }
                break
            case ("prefix","suffix"):
                if(moviesRoot.count > 0){
                    pickerdataRoot.removeAll()
                }
                if boolRoot == false{
                    pickerdataRoot.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataRoot.contains(item.root) {
                    }else{
                        if item.root != "" {
                            pickerdataRoot.append(item.root)
                        }
                    }
                }
                pickerdataRoot = pickerdataRoot.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataRoot.count > 0{
                    self.picker3.selectRow(random1, inComponent: 0, animated: true)
                }
                self.picker3.reloadComponent(0)
                break
            case ("prefix","root"):
                if(moviesRoot.count > 0){
                    pickerdataSuffix2.removeAll()
                    pickerdataSuffix3.removeAll()
                }
                if boolSuffix == false{
                    pickerdataSuffix3.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataSuffix3.contains(item.suffix_3) {
                    }else{
                        if item.suffix_3 != "" {
                            pickerdataSuffix3.append(item.suffix_3)
                        }
                    }
                }
                pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataSuffix3.count > 0{
                    self.picker6.selectRow(random1, inComponent: 0, animated: true)
                }
                self.picker6.reloadComponent(0)
                break
            case ("suffix","root"):
                if(moviesRoot.count > 0){
                    pickerdataPrefix2.removeAll()
                    pickerdataPrefix1.removeAll()
                }
                if boolPrefix == false{
                    pickerdataPrefix1.removeAll()
                }
                if boolSuffix2 == false{
                    pickerdataSuffix2.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataPrefix1.contains(item.prefex_1) {
                    }
                    else{
                        if item.prefex_1 != "" {
                            pickerdataPrefix1.append(item.prefex_1)
                        }
                    }
                    if pickerdataSuffix2.contains(item.suffix_2) {
                    }
                    else{
                        if item.suffix_2 != "" {
                            pickerdataSuffix2.append(item.suffix_2)
                        }
                    }
                }
                pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataPrefix1.count > 0{
                    self.pickerView(self.picker5, didSelectRow: random1, inComponent: 0)
                    self.picker1.reloadComponent(0)
                }
                if pickerdataSuffix2.count > 0{
                    self.pickerView(self.picker5, didSelectRow: random1, inComponent: 0)
                    self.picker5.reloadComponent(0)
                }
                break
            case ("prefix","suffix"):
                if(moviesRoot.count > 0){
                    pickerdataRoot.removeAll()
                }
                if boolRoot == false{
                    pickerdataRoot.removeAll()
                }
                for item in moviesRoot
                {
                    if pickerdataRoot.contains(item.root) {
                    }else{
                        if item.root != "" {
                            pickerdataRoot.append(item.root)
                        }
                    }
                }
                pickerdataRoot = pickerdataRoot.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                if pickerdataRoot.count > 0{
                    self.picker3.selectRow(random1, inComponent: 0, animated: true)
                }
                self.picker3.reloadComponent(0)
                break
            default:break
            }
        }
        else{
            self.resetbtnClicked(UIButton())
        }
        prefix2Value = ""
        suffix1Value = ""
        suffix2Value = ""
        if pickerdataPrefix2.count > 0{
            self.picker2.selectRow(random1, inComponent: 0, animated: false)
        }
        if pickerdataSuffix1.count > 0{
            self.picker4.selectRow(random1, inComponent: 0, animated: false)
        }
        if pickerdataSuffix2.count > 0{
            self.picker5.selectRow(random1, inComponent: 0, animated: false)
        }
        self.picker1.isUserInteractionEnabled = true
        self.picker6.isUserInteractionEnabled = true
        self.picker3.isUserInteractionEnabled = true
        picker1.alpha = 1.0
        picker2.alpha = 1.0
        picker4.alpha = 1.0
        picker5.alpha = 1.0
        picker6.alpha = 1.0
        picker3.alpha = 1.0
        NumberPicker5 = -1
        NumberPicker2 = -1
        if pickerdataPrefix2.count > 0{
            self.picker2.reloadComponent(0)
        }
        if pickerdataSuffix1.count > 0{
            self.picker4.reloadComponent(0)
        }
        if pickerdataSuffix2.count > 0{
            self.picker5.reloadComponent(0)
        }
        if pickerdataSuffix2.count > 0{
            picker1Width.constant = (deviceScreenWidth - 60)/4+20
            picker3Width.constant = (deviceScreenWidth - 60)/4+20
            picker6Width.constant = (deviceScreenWidth - 60)/4+20
            picker2Width.constant = 0
            picker4Width.constant = 0
            picker5Width.constant = (deviceScreenWidth - 60)/4-60
            picker4leading.constant = 0
            picker5Leading.constant = 0
            picker1Leading.constant = 30
            picker3Leading.constant = 0
            picker6Leading.constant = picker5Width.constant
            picker2Leading.constant = 0
            Prview2.isHidden = true
            Prview4.isHidden = true
            Prview5.isHidden = false
            picker6Trailing.constant = 40
        }
        else if pickerdataPrefix2.count > 0{
            picker1Width.constant = (deviceScreenWidth - 60)/4+20
            picker3Width.constant = (deviceScreenWidth - 60)/4+20
            picker6Width.constant = (deviceScreenWidth - 60)/4+20
            picker5Width.constant = 0
            picker4Width.constant = 0
            picker2Width.constant = (deviceScreenWidth - 60)/4-60
            picker4leading.constant = 0
            picker5Leading.constant = 0
            picker1Leading.constant = 30
            picker6Leading.constant = 0
            picker3Leading.constant = picker2Width.constant
            picker2Leading.constant = 0
            Prview2.isHidden = false
            Prview4.isHidden = true
            Prview5.isHidden = true
            picker6Trailing.constant = 40
        }
        else{
            Prview2.isHidden = true
            Prview4.isHidden = true
            Prview5.isHidden = true
            picker2Width.constant = 0
            picker4Width.constant = 0
            picker5Width.constant = 0
            picker5Leading.constant = 0
            picker1Leading.constant = 30
            picker3Leading.constant = 0
            picker6Leading.constant = 0
            picker1Width.constant = (deviceScreenWidth - 60)/3
            picker3Width.constant = (deviceScreenWidth - 60)/3
            picker6Width.constant = (deviceScreenWidth - 60)/3
            picker6Trailing.constant = 40
        }
        self.view.layoutIfNeeded()
    }
    
    func pickerfirstValueActiondone(withFirstValue FirstValue: NSString,withFirstValueData FirstValueData: NSString){
        prefix1lblView.isHidden = true
        prefix2lblView.isHidden = true
        rootlblView.isHidden = true
        suffix1lblView.isHidden = true
        suffix2lblView.isHidden = true
        suffix3LblView.isHidden = true
        pickerdataPrefix2.removeAll()
        pickerdataSuffix2.removeAll()
        moviesRoot=DBManager.shared.loadMovie(withStartValue: FirstValue as NSString , StartValueData:FirstValueData as NSString  )
        moviesbool2nd.removeAll()
        if moviesbool.count == 0{
            moviesbool.append(FirstValue as String)
        }else{
            moviesbool[0] = FirstValue as String
        }
        if FirstValue == "root"
        {
            prefixBtn.isHidden = false
            picker1.isHidden = true
            prefixOverlayBtn.isHidden = false
            suffixbtn.isHidden = false
            picker6.isHidden = true
            suffixOverlayBtn.isHidden = false
            self.picker3.reloadComponent(0)
            suffix3Value = ""
            prefix1Value = ""
            if(moviesRoot.count > 0){
                pickerdataPrefix1.removeAll()
                pickerdataPrefix2.removeAll()
                pickerdataSuffix1.removeAll()
                pickerdataSuffix2.removeAll()
                pickerdataSuffix3.removeAll()
            }
        }else if FirstValue == "prefix"
        {
            suffixbtn.isHidden = false
            picker6.isHidden = true
            suffixOverlayBtn.isHidden = false
            rootBtn.isHidden = false
            rootOverlayBtn.isHidden = false
            picker3.isHidden = true
            self.picker1.reloadComponent(0)
            suffix3Value = ""
            rootValue = ""
            if(moviesRoot.count > 0){
                pickerdataRoot.removeAll()
                pickerdataPrefix2.removeAll()
                pickerdataSuffix1.removeAll()
                pickerdataSuffix2.removeAll()
                pickerdataSuffix3.removeAll()
            }
        }
        else{
            rootValue = ""
            prefix1Value = ""
            prefixBtn.isHidden = false
            picker1.isHidden = true
            prefixOverlayBtn.isHidden = false
            rootBtn.isHidden = false
            rootOverlayBtn.isHidden = false
            picker3.isHidden = true
            self.picker6.reloadComponent(0)
            if(moviesRoot.count > 0){
                pickerdataPrefix1.removeAll()
                pickerdataPrefix2.removeAll()
                pickerdataSuffix1.removeAll()
                pickerdataSuffix2.removeAll()
                pickerdataRoot.removeAll()
            }
        }
        prefix2Value = ""
        suffix1Value = ""
        suffix2Value = ""
        if FirstValue == "root"
        {
            if boolSuffix == false{
                pickerdataSuffix3.removeAll()
            }
            if boolPrefix == false{
                pickerdataPrefix1.removeAll()
            }
            for item in moviesRoot {
                if pickerdataPrefix1.contains(item.prefex_1) {
                }else{
                    if item.prefex_1 != "" {
                        pickerdataPrefix1.append(item.prefex_1)
                    }
                }
                if pickerdataSuffix3.contains(item.suffix_3) {
                }else{
                    if item.suffix_3 != "" {
                        pickerdataSuffix3.append(item.suffix_3)
                    }
                }
            }
        }
        else if FirstValue == "prefix"{
            if boolSuffix == false{
                pickerdataSuffix3.removeAll()
            }
            if boolRoot == false{
                pickerdataRoot.removeAll()
            }
            for item in moviesRoot {
                if pickerdataSuffix3.contains(item.suffix_3) {
                }else{
                    if item.suffix_3 != "" {
                        pickerdataSuffix3.append(item.suffix_3)
                    }
                }
                if pickerdataRoot.contains(item.root) {
                }else{
                    if item.root != "" {
                        pickerdataRoot.append(item.root)
                    }
                }
            }
        }
        else{
            if boolRoot == false{
                pickerdataRoot.removeAll()
            }
            if boolPrefix == false{
                pickerdataPrefix1.removeAll()
            }
            if boolSuffix1 == false{
                pickerdataSuffix1.removeAll()
            }
            if boolRoot == false{
                pickerdataRoot.removeAll()
            }
            if boolSuffix2 == false{
                pickerdataSuffix2.removeAll()
            }
            if boolPrefix1 == false{
                pickerdataPrefix2.removeAll()
            }
            for item in moviesRoot {
                if pickerdataPrefix1.contains(item.prefex_1) {
                }else{
                    if item.prefex_1 != "" {
                        pickerdataPrefix1.append(item.prefex_1)
                    }
                }
                if pickerdataRoot.contains(item.root) {
                }else{
                    if item.root != "" {
                        pickerdataRoot.append(item.root)
                    }
                }
                if pickerdataPrefix2.contains(item.prefex_2) {
                }else{
                    if item.prefex_2 != "" {
                        pickerdataPrefix2.append(item.prefex_2)
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
            }
        }
        pickerdataSuffix3 = pickerdataSuffix3.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataSuffix2 = pickerdataSuffix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataSuffix1 = pickerdataSuffix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataPrefix1 = pickerdataPrefix1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataPrefix2 = pickerdataPrefix2.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        pickerdataRoot = pickerdataRoot.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        let   random1 :Int = Int(arc4random_uniform(10000))
        if pickerdataPrefix2.count > 0{
            self.picker2.selectRow(random1, inComponent: 0, animated: false)
        }
        if pickerdataSuffix1.count > 0{
            self.picker4.selectRow(random1, inComponent: 0, animated: false)
        }
        if pickerdataSuffix2.count > 0{
            self.picker5.selectRow(random1, inComponent: 0, animated: false)
        }
        self.picker1.isUserInteractionEnabled = true
        self.picker6.isUserInteractionEnabled = true
        self.picker3.isUserInteractionEnabled = true
        picker1.alpha = 1.0
        picker2.alpha = 1.0
        picker4.alpha = 1.0
        picker5.alpha = 1.0
        picker6.alpha = 1.0
        picker3.alpha = 1.0
        NumberPicker5 = -1
        NumberPicker2 = -1
        if FirstValue == "root"{
            self.picker1.reloadComponent(0)
            self.picker6.reloadComponent(0)
            if pickerdataPrefix1.count > 0{
                self.picker1.selectRow(random1, inComponent: 0, animated: true)
            }
            if pickerdataSuffix3.count > 0{
                self.picker6.selectRow(random1, inComponent: 0, animated: true)
            }
        }
        else if FirstValue == "prefix"{
            self.picker3.reloadComponent(0)
            self.picker6.reloadComponent(0)
            if pickerdataRoot.count > 0{
                self.picker3.selectRow(random1, inComponent: 0, animated: true)
            }
            if pickerdataSuffix3.count > 0{
                self.picker6.selectRow(random1, inComponent: 0, animated: true)
            }
        }else{
            self.picker3.reloadComponent(0)
            self.picker1.reloadComponent(0)
            if pickerdataPrefix1.count > 0{
                self.picker1.selectRow(random1, inComponent: 0, animated: true)
            }
            if pickerdataRoot.count > 0{
                self.picker3.selectRow(random1, inComponent: 0, animated: true)
            }
        }
        if pickerdataPrefix2.count > 0{
            self.picker2.reloadComponent(0)
        }
        if pickerdataSuffix1.count > 0{
            self.picker4.reloadComponent(0)
        }
        if pickerdataSuffix2.count > 0{
            self.picker5.reloadComponent(0)
        }
        Prview2.isHidden = true
        Prview4.isHidden = true
        Prview5.isHidden = true
        picker2Width.constant = 0
        picker4Width.constant = 0
        picker5Width.constant = 0
        picker5Leading.constant = 0
        picker1Leading.constant = 30
        picker3Leading.constant = 0
        picker6Leading.constant = 0
        picker1Width.constant = (deviceScreenWidth - 60)/3
        picker3Width.constant = (deviceScreenWidth - 60)/3
        picker6Width.constant = (deviceScreenWidth - 60)/3
        picker6Trailing.constant = 40
        self.view.layoutIfNeeded()
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath as IndexPath) as! GalleryCollectionCell
        cell.namelbl.text = testArr[indexPath.row] as? String
        cell.backgroundColor = UIColor.clear
        cell.statusBtn.isHidden = true
        if didselectStatus{
            if didselectValue == indexPath.row{
                cell.statusBtn.isHidden = false
                didStatus = true
                cell.statusBtn.setBackgroundImage(#imageLiteral(resourceName: "no"), for: .normal)
            }else{
                cell.statusBtn.isHidden = true
            }
            if let id = resultLbl.text {
                DBManager.shared.loadMovie(withWordSynonym: id, completionHandler: { (movie) in
                    DispatchQueue.main.async {
                        if movie != nil {
                            if  self.testArr[indexPath.row] as? String == movie?.synonym{
                                cell.statusBtn.isHidden = false
                                cell.statusBtn.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
                            }
                        }
                    }
                })
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didselectStatus = true
        didselectValue = indexPath.row
        self.templateList.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40)/2, height: 50)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInstructionAnyVC"{
            let instVc = segue.destination as! InstructionVC
            instVc.pushFrom = "instVC"
        }
        if segue.identifier == "grammerVC"{
            let instVc = segue.destination as! InstructionVC
            instVc.pushFrom = "grammerVC"
        }
    }
}
