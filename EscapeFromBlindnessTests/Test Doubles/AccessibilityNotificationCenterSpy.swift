//
//  Created by Michael Martinez on 06/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit
@testable import EscapeFromBlindness

// MARK: Test Doubles
class AccessibilityNotificationCenterSpy: AccessibilityNotificationCenterProtocol {
    var isVoiceOverRunning = false
    
    var notification: UIAccessibility.Notification? = nil
    var argument: Any? = nil
    
    func post(
        notification: UIAccessibility.Notification,
        argument: Any?
    ) {
        self.notification = notification
        self.argument = argument
    }
}
