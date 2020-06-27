//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

extension InstructionsViewController: XibLoadable {}

class InstructionsViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    
    enum Scenario {
        case intro
        case gameEnd
    }
    var scenario: Scenario!
    
    var interactor: InstructionsInteractorProtocol? = InstructionsInteractor()
    private var instructions: [String] = []
    private var currentInstructionIndex = 0
    private var currentInstruction: String? {
        return self.instructions[safe: self.currentInstructionIndex]
    }
    
    @IBOutlet weak var instructionsButton: UIButton!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.replayButton.setTitle(L10n.replay, for: .normal)
        
        guard let instructions = scenario == .intro ? interactor?.fetchIntroInstructions() : interactor?.fetchGameEndInstructions() else {
            return
        }
        
        self.instructions = instructions
        if let firstInstruction = instructions.first {
            self.instructionsButton.setTitle(firstInstruction, for: .normal)
        }
        
        EscapeFromBlindnessAccessibility.shared.post(
            notification: .layoutChanged,
            argument: self.instructionsButton
        )
        
        startInstructionsUpdateTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EscapeFromBlindnessAccessibility.shared.post(notification: .layoutChanged, argument: self.instructionsButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopInstructionsUpdateTimer()
    }
    
    private func startInstructionsUpdateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            
            strongSelf.currentInstructionIndex += 1
            strongSelf.handleInstruction(strongSelf.currentInstruction)
        }
        timer?.fire()
    }
    
    private func stopInstructionsUpdateTimer() {
        timer?.invalidate()
    }
    
    private func handleInstruction(_ nextInstruction: String?) {
        if let nextInstruction = nextInstruction {
            setInstructionsText(nextInstruction)
        } else {
            timer?.invalidate()
            if self.scenario == .intro {
                coordinator?.validateChapter()
            } else {
                self.replayButton.isHidden = false
                EscapeFromBlindnessAccessibility.shared.post(notification: .layoutChanged, argument: self.replayButton)
            }
        }
    }
    
    @IBOutlet weak var replayButton: UIButton!
    @IBAction func onReplayButtonTouched(_ sender: Any) {
        coordinator?.replay()
    }
    
    private func setInstructionsText(_ text: String) {
        let duration = 0.5
        UIView.animate(withDuration: duration, animations: {
            self.instructionsButton.alpha = 0
        }, completion: { _ in
            self.instructionsButton.setTitle(text, for: .normal)
            UIView.animate(withDuration: duration) {
                self.instructionsButton.alpha = 1
            }
            EscapeFromBlindnessAccessibility.shared.post(notification: .layoutChanged, argument: self.instructionsButton)
        })
        
    }

}
