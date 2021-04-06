//
//  WordModel.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 09/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import Foundation

class WordModel {
 
    var DbUpdated = false
    var ModeValue = 2 // 0 - Root, 1 - random, 2 - Nonsense
    static let shared = WordModel()
    
}

struct DictionaryInfo {
   var word_id: Int!
   var word_database_id: String!
   var word: String!
   var meaning: String!
   var prefex_1: String!
   var prefex_2: String!
   var root: String!
   var suffix_1: String! //not using in app 2021
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
/*

 class WordModel {
     
     var wordId = ""
     var word_database_id = ""
     var word = ""
     var meaning = ""
     var prefex_1 = ""
     var prefex_2 = ""
     var root = ""
     var suffix_1 = ""
     var suffix_2 = ""
     var suffix_3 = ""
     var synonym = ""
     var partOfSpeech = ""
     
     var DbUpdated = false
     
     static let shared = WordModel()
     
     func createModel(data:[String:Any]) -> WordModel {
         wordId = anyToStringConverter(dict: data, key: "word_id")
         word = data["word"] as? String ?? ""
         meaning = data["meaning"] as? String ?? ""
         prefex_1 = data["prefix_1"] as? String ?? ""
         prefex_2 = data["prefix_2"] as? String ?? ""
         root = data["root"] as? String ?? ""
         suffix_1 = data["suffix_1"] as? String ?? ""
         suffix_2 = data["suffix_2"] as? String ?? ""
         suffix_3 = data["suffix_3"] as? String ?? ""
         synonym = data["synonym"] as? String ?? ""
         partOfSpeech = data["work"] as? String ?? ""
         return self
     }
 }

 class WordMeaningModel {
     var wordId = ""
     var word_database_id = ""
     var word = ""
     var meaning = ""
     var type = ""
     var m_cat_id = ""
     var partOfSpeech = ""
     
     func createModel(data:[String:Any]) -> WordMeaningModel {
         wordId = anyToStringConverter(dict: data, key: "w_id")
         word = data["word"] as? String ?? ""
         meaning = data["meaning"] as? String ?? ""
         type = data["type"] as? String ?? ""
         m_cat_id = data["m_cat_id"] as? String ?? ""
         partOfSpeech = data["part_of_speech"] as? String ?? ""
         
         return self
     }
 }

 */
