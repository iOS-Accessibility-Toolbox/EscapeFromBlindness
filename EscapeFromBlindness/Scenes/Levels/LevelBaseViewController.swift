//
//  Created by Michael Martinez on 21/04/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class LevelBaseViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    var availableHints: [String] = []
    var hints: [String] = []
    internal var kHintUnlockTimeInterval = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hintsButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onHintsButtonTouched))
        hintsButtonItem.accessibilityLabel = L10n.hint
        let homeButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(onHomeButtonTouched))
        homeButtonItem.accessibilityLabel = "Menu"
        self.navigationItem.rightBarButtonItems = [
            hintsButtonItem,
            homeButtonItem
        ]
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    var timer: Timer?
    
    private func startTimer() {
        guard self.hints.count > 0 else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: kHintUnlockTimeInterval, repeats: true, block: { timer in
            
            self.availableHints.append(self.hints[self.availableHints.count])
            
            if self.availableHints.count == self.hints.count {
                self.stopTimer()
            }
        })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc internal func onHomeButtonTouched() {
        coordinator?.presentLoadLevelController()
    }
    
    @objc internal func onHintsButtonTouched() {
        var message = ""
        
        if self.availableHints.count == 0 {
            if self.hints.count == 0 {
                message += "Aucun indice n'est disponible pour ce niveau !"
            } else {
                message += "Patiente quelques instants pour obtenir des indices supplémentaires !"
            }
        } else {
            for i in 0..<availableHints.count {
                message += "\(L10n.hint) \(i + 1): \(hints[i]) . "
            }
        }
        
        if isRunningTest {
            EscapeFromBlindnessAccessibility.shared.post(notification: .announcement, argument: message)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                EscapeFromBlindnessAccessibility.shared.post(notification: .announcement, argument: message)
            }
        }
        
    }
    
}
