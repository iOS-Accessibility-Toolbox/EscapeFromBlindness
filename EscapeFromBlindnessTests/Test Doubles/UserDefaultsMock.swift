//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class UserDefaultsMock: UserDefaults {
    private var keyValueMap: [String: Any] = [:]
    
    override func set(_ value: Int, forKey defaultName: String) {
        self.keyValueMap[defaultName] = value
    }
    
    override func value(forKey key: String) -> Any? {
        return self.keyValueMap[key]
    }
}
