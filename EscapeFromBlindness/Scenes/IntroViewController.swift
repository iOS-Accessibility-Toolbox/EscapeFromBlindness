//
//  IntroViewController.swift
//  EscapeFromBlindness
//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

extension IntroViewController: XibLoadable {}

class IntroViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    var interactor: IntroInteractorProtocol? = IntroInteractor()
    private var instructions: [String] = []
    private var currentInstructionIndex = 0
    private var currentInstruction: String? {
        return self.instructions[safe: self.currentInstructionIndex]
    }
    
    @IBOutlet weak var instructionsButton: UIButton!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let instructions = interactor?.fetchInstructions() else {
            return
        }
        
        self.instructions = instructions
        
        EscapeFromBlindnessAccessibility.shared.post(
            notification: .layoutChanged,
            argument: self.instructionsButton
        )
        
        startInstructionsUpdateTimer()
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
            coordinator?.validateChapter()//.presentChapterController(1)
        }
    }
    
    private func setInstructionsText(_ text: String) {
        self.instructionsButton.setTitle(text, for: .normal)
    }

}
