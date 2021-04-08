//
//  Common Methods.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 25/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

func heightForView(text : NSAttributedString, frame : CGRect, font: UIFont) -> CGFloat {
    let label : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.attributedText = text
    label.sizeToFit()
    return label.bounds.size.height
}
func checkSynonymSuccess() -> Bool {
    //save in user default for every 2nd correct answer that the user gets on synonyms, a " confetti gif " has to appear.
    
    let synonymSuccessCount = UserDefaults.standard.object(forKey: "synonymSuccessCount") as? Int ?? 0
    if synonymSuccessCount == 2 {
        UserDefaults.standard.set(0, forKey: "synonymSuccessCount")
        UserDefaults.standard.synchronize()
        return true
    } else {
        UserDefaults.standard.set(synonymSuccessCount + 1, forKey: "synonymSuccessCount")
        UserDefaults.standard.synchronize()
        return false
    }
    
}

// MARK: - Split httml content
func splitAttributedStrings(inputString: NSAttributedString, seperator: String, length: Int) -> [NSAttributedString] {
    let input = inputString.string
    var result = [String]()
    var output = [NSAttributedString]()
    var collectedWords = [String]()
    collectedWords.reserveCapacity(length)
    var count = 0
    let words = input.components(separatedBy: CharacterSet.newlines)
    for word in words {
        count += word.count + 1 //add 1 to include space
        if (count > length) {
            // Reached the desired length

            result.append(collectedWords.map { String($0) }.joined(separator: seperator) )

            collectedWords.removeAll(keepingCapacity: true)

            count = word.count
            collectedWords.append(word)
        } else {
            collectedWords.append(word)
        }
    }

    // Append the remainder
    if !collectedWords.isEmpty {
        result.append(collectedWords.map { String($0) }.joined(separator: seperator))
    }
    var start = 0
    let stringArr = inputString.string.ls_wrap(maxWidth: length)
  // let stringArr = result
    for txt in stringArr {
        let range = NSMakeRange(start, txt.count)
        print("....range... \(range)")
        print("....txt......... \(txt)")
        let attribStr = inputString.attributedSubstring(from: range)
        output.append(attribStr)
        start += range.length + seperator.count
    }
    return output
}
extension String {
   func inserting(separator: String, every n: Int) -> [String] {
      var collectedWords = [String]()
       var result: String = ""
    let characters = Array(self)
       stride(from: 0, to: characters.count, by: n).forEach {
           result += String(characters[$0..<min($0+n, characters.count)])
           if $0+n < characters.count {
               result += separator
            collectedWords.append(result)
           }
       }
       return collectedWords
   }
    func ls_wrap(maxWidth: Int) -> [String] {
        guard maxWidth > 0 else {
          //  Logger.logError("wrap: maxWidth too small")
            return []
        }
        let addWord: (String, String) -> String = { (line: String, word: String) in
            line.isEmpty
                ? word
                : "\(line) \(word)"
        }
        let handleWord: (([String], String), String) -> ([String], String) = { (arg1: ([String], String), word: String) in
            let (acc, line): ([String], String) = arg1
            let lineWithWord: String = addWord(line, word)
            if lineWithWord.count <= maxWidth { // 'word' fits fine; append to 'line' and continue.
                return (acc, lineWithWord)
            } else if word.count > maxWidth { // 'word' doesn't fit in any way; split awkwardly.
                let splitted: [String] = lineWithWord.ls_chunks(of: maxWidth)
                let (intermediateLines, lastLine) = (splitted.ls_init, splitted.last!)
                return (acc + intermediateLines, lastLine)
            } else { // 'line' is full; start with 'word' and continue.
                return (acc + [line], word)
            }
        }
        let (accLines, lastLine) = ls_words().reduce(([],""), handleWord)
        return accLines + [lastLine]
    }
    
    // stolen from https://stackoverflow.com/questions/32212220/how-to-split-a-string-into-substrings-of-equal-length
    func ls_chunks(of length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        return results.map { String($0) }
    }
    
    // could be improved to split on whiteSpace instead of only " " and "\n"
    func ls_words() -> [String] {
       // return split(separator: " ").map{ String($0) }
        return split(separator: " ").flatMap{ $0.split(separator: "\n") }.map{ String($0) }
    }
}
extension Array {
    
    var ls_init: [Element] {
        return isEmpty
            ? self
            : Array(self[0..<count-1])
    }
}
