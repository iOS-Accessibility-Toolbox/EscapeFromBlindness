//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class Chapter: CustomStringConvertible {
    public let index: Int
    public let title: String?
    public let chapterDescription: String?
    public let keywords: [String]
    public let levels: [Level]
    
    init(index: Int, title: String, description: String? = nil, keywords: [String] = [], levels: [Level]) {
        self.index = index
        self.title = title
        self.chapterDescription = description
        self.keywords = keywords
        self.levels = levels
    }
    
    init(index: Int, title: String? = nil, description: String? = nil, keywords: [String] = [], levels: [Level]) {
        self.index = index
        self.title = title
        self.chapterDescription = description
        self.keywords = keywords
        self.levels = levels
    }
    
    var description: String {
        return "Chapter \(index): \(title ?? ""). \(chapterDescription ?? "")\n\(levels.count) levels: \(levels)"
    }
}
