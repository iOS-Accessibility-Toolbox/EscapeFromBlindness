//
//  Created by Michael Martinez on 06/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

protocol AccessibilityNotificationCenterProtocol {
    var isVoiceOverRunning: Bool { get }
    func post(
        notification: UIAccessibility.Notification,
        argument: Any?
    )
}

class EscapeFromBlindnessAccessibility: AccessibilityNotificationCenterProtocol {
    
    static var shared: AccessibilityNotificationCenterProtocol = EscapeFromBlindnessAccessibility()
    private init() {}
    
    var isVoiceOverRunning: Bool {
        return UIAccessibility.isVoiceOverRunning
    }
    
    func post(
        notification: UIAccessibility.Notification,
        argument: Any?
    ) {
        UIAccessibility.post(notification: notification, argument: argument)
    }
    
    class LabelBuilder {
        private var _value: String
        private let separator: String

        init(_ value: String?, separator: String = ", ") {
            self._value = value ?? ""
            self.separator = separator
        }

        func append(_ value: String?) -> LabelBuilder {
            if let value = value {
                self._value += value + self.separator
            }
            return self
        }

        func build() -> String {
            return self._value
        }
    }
}
