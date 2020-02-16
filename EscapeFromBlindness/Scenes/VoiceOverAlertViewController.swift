//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

extension VoiceOverAlertViewController: XibLoadable {}

class VoiceOverAlertViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var voiceOverActivationInstructionsView: UIStackView!
    @IBOutlet weak var userCanContinueInstructionsView: UIStackView!
    @IBOutlet weak var continueButton: UIButton!

    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.continueButton.setTitle("AAA", for: .normal)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(voiceOverStatusChanged),
            name: UIAccessibility.voiceOverStatusDidChangeNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    @IBAction func onContinueButtonTouched() {
        coordinator?.dismissActivateVoiceOverAlert()
    }
    
    @objc internal func voiceOverStatusChanged() {
        let isVoiceOverRunning = EscapeFromBlindnessAccessibility.shared.isVoiceOverRunning
        
        if isVoiceOverRunning {
            self.voiceOverActivationInstructionsView.isHidden = true
            self.userCanContinueInstructionsView.isHidden = false
        } else {
            self.voiceOverActivationInstructionsView.isHidden = false
            self.userCanContinueInstructionsView.isHidden = true
        }
    }

}
