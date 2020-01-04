//
//  Created by Michael Martinez on 03/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

extension String {
    public var prefix: String {
        get {
            return self.components(separatedBy: ".").first ?? self
        }
    }
    
    public var ext: String {
        get {
            let defaultExt = "m4a"
            if !self.contains(".") {
                return defaultExt
            } else {
                return self.components(separatedBy: ".").last ?? defaultExt
            }
        }
    }
}

extension String {
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    func replacingFirst( _ searchString: String,
                        _ replacementString: String,
                        caseInsensitive: Bool = true
        ) -> String {
        if let range = self.range(of: searchString) {
            return self.replacingCharacters(in: range, with: replacementString)
        } else {
            return self
        }
    }
    
    func replacingBeforeLast( _ searchString: String,
                        _ replacementString: String,
                        caseInsensitive: Bool = true
        ) -> String {
        let options: String.CompareOptions
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }
        var temp = self
        if let range = self.range(of: searchString,
                                  options: options,
                                  range: nil,
                                  locale: nil) {
            temp = temp.replacingCharacters(in: range, with: replacementString)
        } else {
            return self
        }
        
        if let range = temp.range(of: searchString,
                                  options: options,
                                  range: nil,
                                  locale: nil) {
            let out = temp.replacingCharacters(in: range, with: replacementString).replacingLast(replacementString, searchString)
            return out
        } else {
            return self
        }
    }
    
    func replacingLast( _ searchString: String,
                        _ replacementString: String,
                        caseInsensitive: Bool = true
    ) -> String {
        let options: String.CompareOptions
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }
        if let range = self.range(of: searchString,
                                  options: options,
                                  range: nil,
                                  locale: nil) {
            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
    }
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension StringProtocol where Index == String.Index {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
