//
//  Created by Michael Martinez on 16/05/2018.
//  Copyright © 2018 Michael Martinez. All rights reserved.
//

import Foundation

public extension MutableCollection {
    subscript (safe index: Index) -> Iterator.Element? {
        get {
            guard startIndex <= index && index < endIndex else { return nil }
            return self[index]
        }
        set(newValue) {
            guard startIndex <= index && index < endIndex else { print("Index out of range."); return }
            guard let newValue = newValue else { print("Cannot remove out of bounds items"); return }
            self[index] = newValue
        }
    }
}

public extension Array where Element: FloatingPoint {
    
    func sum() -> Element {
        return self.reduce(0, +)
    }
    
    func avg() -> Element {
        return self.sum() / Element(self.count)
    }
    
    func std() -> Element {
        let mean = self.avg()
        let v = self.reduce(0, { $0 + ($1-mean)*($1-mean) })
        return sqrt(v / (Element(self.count) - 1))
    }
    
}
