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
    let field_suffix_1 = "suffix_1"
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
                print(movie)
                let List_word_id = movie.object(forKey: "word_id") as! NSString
                let List_word = movie.object(forKey: "word") as! NSString
                let List_meaning = movie.object(forKey: "meaning") as! NSString
                let List_prefex_1 = movie.object(forKey: "prefex_1") as! NSString
                let List_prefex_2 = movie.object(forKey: "prefex_2") as! NSString
                let List_root = movie.object(forKey: "root") as! NSString
                let List_suffix_1 = movie.object(forKey: "suffix_1") as! NSString
                let List_suffix_2 = movie.object(forKey: "suffix_2") as! NSString
                let List_suffix_3 = movie.object(forKey: "suffix_3") as! NSString
                let List_synonym = movie.object(forKey: "synonym") as! NSString
                let List_part_of_speech = movie.object(forKey: "part_of_speech") as! NSString
                
                var arr :[NSString] = []
                arr.removeAll()
                arr.append(List_word_id as NSString)
                arr.append(List_word.uppercased as NSString)
                arr.append(List_meaning as NSString)
                arr.append(List_prefex_1.uppercased  as NSString)
                arr.append(List_prefex_2.uppercased as NSString)
                arr.append(List_root.uppercased  as NSString)
                arr.append(List_suffix_1.uppercased as NSString )
                arr.append(List_suffix_2.uppercased  as NSString)
                arr.append(List_suffix_3.uppercased  as NSString)
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
                print(movie)
                var query = ""
                let List_word_id = movie.object(forKey: "w_id") as! NSString
                let List_word = movie.object(forKey: "word" )as! NSString
                var List_meaning = ""
                if let meaning = movie.object(forKey: "meaning") as? String{
                    List_meaning = meaning as String
                }
                let List_type = movie.object(forKey: "type") as! NSString
                let List_m_id = movie.object(forKey: "m_cat_id") as! NSString
                let List_speech = movie.object(forKey: "part_of_speech") as! NSString
                var arr :[NSString] = []
                arr.removeAll()
                arr.append(List_word_id as NSString)
                arr.append(List_word.uppercased as NSString)
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
            let query = "select * from wordList"
            
            do {
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
    
    func loadMovie(withRoot Root: NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? "
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    
    func loadMovie(withRoot Root: NSString, withSuffix Suffix3:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_suffix_3)=? "
            
            do {
                let results = try database.executeQuery(query, values: [Root,Suffix3])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString, withPrefix2 Prefix2:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_prefex_2)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1,Prefix2])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    
    func loadMovie(withRoot Root: NSString, withSuffix Suffix3:NSString, withSuffix2 Suffix2:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Suffix3,Suffix2])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString, withSuffix Suffix:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1,Suffix])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString, withSuffix Suffix:NSString, withSuffix2 Suffix2:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1,Suffix,Suffix2])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString, withSuffix Suffix:NSString, withSuffix2 Suffix2:NSString,withSuffix3 Suffix3:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_1)=? AND \(field_suffix_2)=? AND \(field_suffix_3)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1,Suffix,Suffix2,Suffix3])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
                    
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
    
    func loadMovie(withRoot Root: NSString, withSuffix1 Suffix1:NSString, withSuffix2 Suffix2:NSString, withSuffix3 Suffix3:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_suffix_1)=? AND \(field_suffix_2)=? AND \(field_suffix_3)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Suffix1,Suffix2,Suffix3])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
                    
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
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString, withPrefix2 Prefix2:NSString,withSuffix Suffix:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_prefex_2)=? AND \(field_suffix_3)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1,Prefix2,Suffix])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
    func loadMovie(withRoot Root: NSString, withPrefix Prefix1:NSString, withPrefix2 Prefix2:NSString,withSuffix2 Suffix2:NSString, withSuffix3 Suffix3:NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_prefex_2)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Root,Prefix1,Prefix2,Suffix3,Suffix2])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    
    func loadMovie(withDataWord  prefix1: String, prefix2 : String, root : String, suffix1:String, suffix2:String, suffix3:String) -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_prefex_2)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=? AND \(field_suffix_1)=?"
            
            do {
                let results = try database.executeQuery(query, values: [root,prefix1,prefix2,suffix3,suffix2,suffix1])
                
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
    func loadwordFromDB(withWord prefix1: String, prefix2 : String, root : String, suffix1:String, suffix2:String, suffix3:String, completionHandler: (_ movieInfo: DictionaryInfo?) -> Void)  {
        var movieInfo:DictionaryInfo!
        print(suffix1)
        if openDatabase() {
            let query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_prefex_2)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=? AND \(field_suffix_1)=?"
            do{
                let results = try database.executeQuery(query, values: [root,prefix1,prefix2,suffix3,suffix2,suffix1])
                
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
    
    func loadWordmeaning(withWord Word: String, completionHandler: (_ movieInfo: WordMeaningInfo?) -> Void) {
        var movieInfo: WordMeaningInfo!
        if openDatabase() {
            let query = "select * from meaningList where \(field_word)=?"
            
            do {
                let results = try database.executeQuery(query, values: [Word])
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
    
    // MARK: :- Load New Functions
    func loadMovie(withStartValue StartValue: NSString , StartValueData: NSString  )  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            
            var query = ""
            switch (StartValue) {
            case "root":
                query = "select * from wordList where \(field_root)=?"
                break
            case "prefix":
                query = "select * from wordList where \(field_prefex_1)=?"
                break
            case "suffix":
                query = "select * from wordList where \(field_suffix_3)=?"
                break
            default:
                
                query = "select * from wordList where \(field_root)=?"
                break
            }
            
            do {
                let results = try database.executeQuery(query, values: [StartValueData])
                
                while results.next() {
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
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
    func loadMovie(withStartValue StartValue: NSString , StartValueData: NSString,SecondValue: NSString , SecondValueData: NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            
            var query = ""
            
            switch (StartValue,SecondValue) {
            case ("root","prefix"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? "
                break
            case ("root","suffix"):
                query = "select * from wordList where \(field_root)=? AND \(field_suffix_3)=? "
                break
            case ("suffix","prefix"):
                query = "select * from wordList where \(field_suffix_3)=? AND \(field_prefex_1)=? "
                break
            case ("prefix","suffix"):
                query = "select * from wordList where \(field_prefex_1)=? AND \(field_suffix_3)=? "
                break
                
            default:
                
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? "
                break
            }
            do {
                let results = try database.executeQuery(query, values: [StartValueData,SecondValueData])
                
                while results.next() {
                    
                    
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
    
    func loadMovie(withStartValue StartValue: NSString , StartValueData: NSString,SecondValue: NSString , SecondValueData: NSString,ThirdValue: NSString , ThirdValueData: NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        print(StartValueData,SecondValueData,ThirdValueData)
        if openDatabase() {
            
            var query = ""
            switch (StartValue,SecondValue,ThirdValue) {
            case ("root","prefix","suffix"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=?"
                break
            case ("root","suffix","prefix"):
                query = "select * from wordList where \(field_root)=? AND \(field_suffix_3)=? AND \(field_prefex_1)=?"
                break
            case ("prefix","root","suffix"):
                query = "select * from wordList where \(field_prefex_1)=? AND \(field_root)=? AND \(field_suffix_3)=?"
                break
            case ("prefix","suffix","root"):
                query = "select * from wordList where \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_root)=?"
                break
            case ("suffix","root","prefix"):
                query = "select * from wordList where \(field_suffix_3)=? AND \(field_root)=? AND \(field_prefex_1)=?"
                break
            case ("suffix","prefix","root"):
                query = "select * from wordList where \(field_suffix_3)=? AND \(field_prefex_1)=? AND \(field_root)=?"
                break
            case ("suffix","root","suffix1"):
                query = "select * from wordList where \(field_suffix_3)=? AND \(field_root)=? AND \(field_suffix_2)=?"
                break
                
            default:
                break
            }
            do {
                let results = try database.executeQuery(query, values: [StartValueData,SecondValueData,ThirdValueData])
                
                while results.next() {
                    
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
        print(movies)
        
        return movies
    }
    func loadMovie(withStartValue StartValue: NSString , StartValueData: NSString,SecondValue: NSString , SecondValueData: NSString,ThirdValue: NSString , ThirdValueData: NSString,ForthValue: NSString , ForthValueData: NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        print(StartValue,StartValueData,SecondValueData,ThirdValueData,ForthValueData)
        
        if openDatabase() {
            
            var query = ""
            
            switch (StartValue,SecondValue,ThirdValue,ForthValue) {
            case ("root","prefix","suffix","prefix1"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_prefex_2)=?"
                break
            case ("root","prefix","suffix","suffix1"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=?"
                break
            case ("suffix","root","suffix1","prefix"):
                query = "select * from wordList where \(field_suffix_3)=? AND \(field_root)=? AND \(field_suffix_2)=? AND \(field_prefex_1)=?"
                break
            case ("suffix","root","suffix1","suffix2"):
                query = "select * from wordList where \(field_suffix_3)=? AND \(field_root)=? AND \(field_suffix_2)=? AND \(field_suffix_1)=?"
                break
            default:
                break
                
            }
            do {
                let results = try database.executeQuery(query, values: [StartValueData,SecondValueData,ThirdValueData,ForthValueData])
                
                while results.next() {
                    
                    
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
    
    func loadMovie(withStartValue StartValue: NSString , StartValueData: NSString,SecondValue: NSString , SecondValueData: NSString,ThirdValue: NSString , ThirdValueData: NSString,ForthValue: NSString , ForthValueData: NSString,FifthValue: NSString , FifthValueData: NSString)  -> [DictionaryInfo]! {
        var movies: [DictionaryInfo]!
        
        if openDatabase() {
            
            var query = ""
            
            switch (StartValue,SecondValue,ThirdValue,ForthValue,FifthValue) {
            case ("root","prefix","suffix","suffix1","suffix2"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=? AND \(field_suffix_1)=?"
                break
            case ("root","prefix","suffix","suffix1","prefix1"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_suffix_2)=? AND \(field_prefex_2)=?"
                break
            case ("root","prefix","suffix","prefix1","suffix1"):
                query = "select * from wordList where \(field_root)=? AND \(field_prefex_1)=? AND \(field_suffix_3)=? AND \(field_prefex_2)=? AND \(field_suffix_2)=?"
                break
                
            default:
                break
                
            }
            do {
                let results = try database.executeQuery(query, values: [StartValueData,SecondValueData,ThirdValueData,ForthValueData,FifthValueData])
                
                while results.next() {
                    
                    
                    let movie =  DictionaryInfo(word_id: Int(results.int(forColumn: field_id)), word_database_id: results.string(forColumn: field_word_id), word: results.string(forColumn: field_word), meaning: results.string(forColumn: field_meaning), prefex_1: results.string(forColumn: field_prefex_1), prefex_2: results.string(forColumn: field_prefex_2), root: results.string(forColumn: field_root), suffix_1: results.string(forColumn: field_suffix_1), suffix_2: results.string(forColumn: field_suffix_2), suffix_3: results.string(forColumn: field_suffix_3), synonym: results.string(forColumn: field_synonym), part_speech: results.string(forColumn: field_speech))
                    
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
    
}
