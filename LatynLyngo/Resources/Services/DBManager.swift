//
//  DBManager.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/21/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    
    let field_id = "word_id"
    let field_word_id = "word_id_data"
    let field_word = "word"
    let field_meaning = "meaning"
    let field_prefex_1 = "prefex_1"
    let field_prefex_2 = "prefex_2"
    let field_root = "root"
    let field_suffix_1 = "suffix_1" // not using in app 2021
    let field_suffix_2 = "suffix_2"
    let field_suffix_3 = "suffix_3"
    let field_type = "type"
    let field_synonym = "synonym"
    let field_speech = "part_of_speech"
    let field_m_id = "m_id"
    static let shared: DBManager = DBManager()
    let databaseFileName = "database.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    func createDatabase() -> Bool {
        var created = false
        do{
            try  FileManager.default.removeItem(atPath: pathToDatabase)
        }
        catch{
            print(error.localizedDescription)
            
        }
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createWordTableQuery = "create table wordList (\(field_id) integer primary key autoincrement not null, \(field_word_id) text not null, \(field_word) text not null, \(field_meaning) text not null, \(field_prefex_1) text not null, \(field_prefex_2) text, \(field_root) text not null, \(field_suffix_1) text not null, \(field_suffix_2) text,\(field_suffix_3) text,\(field_synonym) text,\(field_speech) text)"
                    
                    let createMeaningTableQuery = "create table meaningList (\(field_id) integer primary key autoincrement not null, \(field_word_id) text not null, \(field_word) text not null, \(field_meaning) text not null, \(field_type) text not null, \(field_m_id) text not null,\(field_speech) text)"
                    
                    
                    do {
                        try database.executeUpdate(createWordTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    do {
                        try database.executeUpdate(createMeaningTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                }
                else {
                }
            }
        }
        return created
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
    func insertWordTableData(passDict:NSArray) {
        if openDatabase() {
            for case let movie as NSDictionary in passDict {
                var query = ""
                print(".........insertWordTableData")
                print(movie)
                let List_word_id = movie.object(forKey: "word_id") as? String ?? ""
                let List_word = movie.object(forKey: "word") as? String ?? ""
                let List_meaning = movie.object(forKey: "meaning") as? String ?? ""
                let List_prefex_1 = movie.object(forKey: "prefix_1") as? String ?? ""//movie.object(forKey: "prefex_1") as? String ?? ""
                let List_prefex_2 = movie.object(forKey: "prefix_2") as? String ?? ""
                let List_root = movie.object(forKey: "root") as? String ?? ""
                let List_suffix_1 = movie.object(forKey: "suffix_1") as? String ?? ""
                let List_suffix_2 = movie.object(forKey: "suffix_2") as? String ?? ""
                let List_suffix_3 = movie.object(forKey: "suffix_3") as? String ?? ""
                let List_synonym = movie.object(forKey: "synonym") as? String ?? ""
                let List_part_of_speech = movie.object(forKey: "part_of_speech") as? String ?? ""
                
                var arr :[NSString] = []
                arr.removeAll()
                arr.append(List_word_id as NSString)
                arr.append(List_word.uppercased() as NSString)
                arr.append(List_meaning as NSString)
                arr.append(List_prefex_1.uppercased()  as NSString)
                arr.append(List_prefex_2.uppercased() as NSString)
                arr.append(List_root.uppercased()  as NSString)
                arr.append(List_suffix_1.uppercased() as NSString )
                arr.append(List_suffix_2.uppercased()  as NSString)
                arr.append(List_suffix_3.uppercased()  as NSString)
                arr.append(List_synonym as NSString )
                arr.append(List_part_of_speech  as NSString)
                
                query = "insert into wordList (\(field_id),\(field_word_id), \(field_word), \(field_meaning), \(field_prefex_1), \(field_prefex_2), \(field_root), \(field_suffix_1), \(field_suffix_2), \(field_suffix_3), \(field_synonym), \(field_speech)) values (null,?,?, ?, ?, ?, ?, ?, ?, ?, ?,?);"
                
                print(query)
                
                if !database.executeUpdate(query, withArgumentsIn: arr){
                    print(database.lastError(), database.lastErrorMessage())
                }
            }
        }
        database.close()
    }
    
    func insertMeaningTableData(passDict:NSArray) {
        if openDatabase() {
            for case let movie as NSDictionary in passDict {
                print(".........insertMeaningTableData 145")
                print(movie)
                var query = ""
                let List_word_id = movie.object(forKey: "w_id") as? String ?? ""
                let List_word = movie.object(forKey: "word" )as? String ?? ""
                //               var List_meaning = ""
                //                if let meaning = movie.object(forKey: "meaning") as? String{
                //                    List_meaning = meaning as String
                //                }
                let List_meaning = movie.object(forKey: "meaning") as? String ?? ""
                let List_type = movie.object(forKey: "type") as? String ?? ""
                let List_m_id = movie.object(forKey: "m_cat_id") as? String ?? ""
                let List_speech = movie.object(forKey: "part_of_speech") as? String ?? ""
                var arr :[NSString] = []
                arr.removeAll()
                arr.append(List_word_id as NSString)
                arr.append(List_word.uppercased() as NSString)
                arr.append(List_meaning as NSString)
                arr.append(List_type  as NSString)
                arr.append(List_m_id as NSString )
                arr.append(List_speech  as NSString)
                
                query = "insert into meaningList (\(field_id),\(field_word_id), \(field_word), \(field_meaning), \(field_type),\(field_m_id),\(field_speech)) values (null,?, ?, ?, ?, ?, ?);"
                if !database.executeUpdate(query, withArgumentsIn: arr){
                    print(database.lastError(), database.lastErrorMessage())
                }
            }
            
            database.close()
        }
    }
    
    
    func loadMovies() -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            if let rs = database.executeQuery("SELECT COUNT(*) as Count FROM wordList", withArgumentsIn: nil) {
                while rs.next() {
                    print("Total Records:", rs.int(forColumn: "Count"))
                }
            }
            let query = "select * from wordList"
            
            do {
                print(".........loadMovies() 180")
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let movie = DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    if movies == nil {
                        movies = [DictionaryInfo]()
                    }
                    
                    movies.append(movie)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        
        return movies
    }
    func loadnonsenceData() -> [WordMeaningInfo]! {
        var movies: [WordMeaningInfo]!
        
        if openDatabase() {
            let query = "select * from meaningList"
            
            do {
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let movie = WordMeaningInfo(w_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), type: results.string(forColumn: field_type), m_cat_id: results.string(forColumn: field_m_id), part_speech: results.string(forColumn: field_speech))
                    
                    
                    if movies == nil {
                        movies = [WordMeaningInfo]()
                    }
                    
                    movies.append(movie)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return movies
    }
    
    func loadwordFromDB(withWord prefix1: String, prefix2 : String, root : String, suffix1:String, suffix2:String, suffix3:String, completionHandler: (_ movieInfo: DictionaryInfo?) -> Void)  {
        var movieInfo:DictionaryInfo!
        print(".........loadwordFromDB")
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_prefex_2)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=? AND \(field_suffix_1)=?"
            do{
                let results = try database.executeQuery(query, values: [root,prefix1,prefix2,suffix3,suffix2,suffix1])
                
                if results.next() {
                    movieInfo =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    print(movieInfo as Any)
                }
                else {
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        completionHandler(movieInfo)
    }
    
    func loadWordmeaning(withWord Word: String, completionHandler: (_ movieInfo: WordMeaningInfo?) -> Void) {
        var movieInfo: WordMeaningInfo!
        if openDatabase() {
            let query = "select * from meaningList where \(field_word)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Word])
                print(".........loadWordmeaning 616")
                print(Word)
                
                if results.next() {
                    movieInfo = WordMeaningInfo(w_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), type: results.string(forColumn: field_type), m_cat_id: results.string(forColumn: field_m_id), part_speech: results.string(forColumn: field_speech))
                    
                }
                else {
                    
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        completionHandler(movieInfo)
    }
    
    func loadMovie(withWordSynonym Word: String, completionHandler: (_ movieInfo: DictionaryInfo?) -> Void) {
        var movieInfo: DictionaryInfo!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_word)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Word])
                
                if results.next() {
                    movieInfo =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
                }
                else {
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        completionHandler(movieInfo)
    }    
    
    func loadMovieList(withDataWord  prefix1: String, prefix2: String, root: String, suffix1: String, suffix2: String, suffix3: String) -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            
            var query = "select * from wordList where "
            var valueArr = [String]()
            if root != "" {
                query = query + "\(field_root)=?"
            }
            if prefix1 != "" {
                query = query + "\(field_prefex_1)=?"
            }
            if prefix2 != "" {
                query = query + "\(field_prefex_2)=?"
            }
            if suffix3 != "" {
                query = query + "\(field_suffix_3)=?"
            }
            if suffix2 != "" {
                query = query + "\(field_suffix_2)=?"
            }
            if suffix1 != "" {
                query = query + "\(field_suffix_1)=?"
                valueArr.insert(suffix1, at: 0)
            }
            if suffix2 != "" {
                valueArr.insert(suffix2, at: 0)
            }
            if suffix3 != "" {
                valueArr.insert(suffix3, at: 0)
            }
            if prefix2 != "" {
                valueArr.insert(prefix2, at: 0)
            }
            if prefix1 != "" {
                valueArr.insert(prefix1, at: 0)
            }
            if root != "" {
                valueArr.insert(root, at: 0)
            }
            if valueArr.count == 0 {
                
                query = "select * from wordList"
            } else if valueArr.count > 1 {
                
                query = query.replacingOccurrences(of: "=?", with: "=? AND ")
                query = String(query.dropLast(5))
            }
            print("query...............\(query)")
            print(valueArr)
            do {
                let results = try database.executeQuery(query, values: valueArr)
                
                while results.next() {
                    let  movieInfo =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    if movies == nil {
                        movies = [DictionaryInfo]()
                    }
                    
                    movies.append(movieInfo)
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return movies
    }
}
