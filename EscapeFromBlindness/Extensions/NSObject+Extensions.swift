//
//  Created by Michael Martinez on 10/02/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

public extension NSObject {
    var isRunningTest: Bool {
        return NSClassFromString("XCTest") != nil
    }
    
    var isRunningUITest: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
}
