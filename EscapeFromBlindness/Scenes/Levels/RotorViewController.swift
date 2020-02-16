//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class RotorViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?

    // MARK: - Initialization
    private var level: RotorLevel!
    
    convenience init(level: RotorLevel) {
        self.init()
        self.level = level
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        self.accessibilityCustomRotors = makeAccessibilityCustomRotors()
    }
    
    private func makeAccessibilityCustomRotors() -> [UIAccessibilityCustomRotor] {
        return []
    }
    
}
