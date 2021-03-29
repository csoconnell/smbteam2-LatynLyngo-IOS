//
//  WordViewModel.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 09/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import Foundation
class WordViewModel: NSObject {
    
    func GetWordListRequest(onCompletion: @escaping (Bool,String) -> ()) {
        NetworkManager.shared.fetchingResponse(from: URLs.getWordList, parameters: [:], method: .get, encoder: .urlEncoding) { (responseData, responseDic, message, status) in
            if let dataObject = responseDic?["data"] as? NSDictionary {
                guard let wordsArray = dataObject.value(forKey: "word") as? NSArray  else {return}
                guard let meaningArray = dataObject.value(forKey: "meaning") as? NSArray  else {return}
                if DBManager.shared.createDatabase() {
                    WordModel.shared.DbUpdated = true
                    DBManager.shared.insertWordTableData(passDict: wordsArray)
                    DBManager.shared.insertMeaningTableData(passDict: meaningArray)
                }
            }
            onCompletion(status,message)
        }
        
    }
}
