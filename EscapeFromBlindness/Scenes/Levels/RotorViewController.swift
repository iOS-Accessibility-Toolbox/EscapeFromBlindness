//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class RotorViewController: LevelBaseViewController {
    
    // MARK: - Outlets
    var clueViews: [UIView] = []
    var lockedDoorView = UIView()

    // MARK: - Initialization
    private var level: RotorLevel!
    
    convenience init(level: RotorLevel) {
        self.init()
        self.level = level
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        setupHints()
        super.viewDidLoad()
        setupClueViews()
        setupLockedDoorView()
    }
    
    private func setupHints() {
        self.hints = level.hints
    }
    
    private func setupClueViews() {
        let frameCount = level.clues.count
        let frames = RandomFramesGenerator.generateFrames(count: frameCount)
        for i in 0..<frameCount {
            let clue = level.clues[i]
            
            let frame = frames[i]
            let clueView = UIView(frame: frame)
            clueView.isAccessibilityElement = true
            clueView.accessibilityLabel = clue
            self.clueViews.append(clueView)
            self.view.addSubview(clueView)
        }
    }
    
    private func setupLockedDoorView() {
        let customRotors = makeAccessibilityCustomRotors(for: level.answers)
        
        let height = 100.heightScaledFromIphoneX()
        let frame = CGRect(
            x: UIScreen.main.bounds.width/2 - CGFloat(height)/2,
            y: UIScreen.main.bounds.height - CGFloat((100 + 60).heightScaledFromIphoneX()),
            width: 100,
            height: CGFloat(height)
        )
        self.lockedDoorView.frame = frame
        self.lockedDoorView.isAccessibilityElement = true
        self.lockedDoorView.accessibilityLabel = L10n.doorScript
        self.lockedDoorView.accessibilityCustomRotors = customRotors
        self.view.addSubview(self.lockedDoorView)
    }
    
    private func makeAccessibilityCustomRotors(for answers: [String]) -> [UIAccessibilityCustomRotor] {
        var customRotors: [UIAccessibilityCustomRotor] = []
        
        for i in 0..<answers.count {
            let answer = answers[i]
            
            let customRotor = UIAccessibilityCustomRotor.init(name: answer) { (predicate) -> UIAccessibilityCustomRotorItemResult? in
                self.coordinator?.validate([answer])
                return nil
            }
            
            customRotors.append(customRotor)
        }
        
        return customRotors
    }
    
}
