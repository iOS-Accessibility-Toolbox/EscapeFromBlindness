//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    
    // MARK: - Initialization
    private var level: SearchLevel!
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var actionViews: [UIView] = []
    
    convenience init(level: SearchLevel) {
        self.init()
        self.level = level
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLevelDescriptionLabel()
        setupActionsViews()
    }
    
    // MARK: - Private Methods
    private func setupLevelDescriptionLabel() {
        self.view.addSubview(self.mainLabel)
        
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        self.mainLabel.text = level.levelDescription
    }
    
    private func setupActionsViews() {
        let frameCount = level.levelActions.count
        let frames = RandomFramesGenerator.generateFrames(count: frameCount)
        for i in 0..<frameCount {
            let action = level.levelActions[i]
            
            let frame = frames[i]
            let actionView = UIView(frame: frame)
            actionView.isAccessibilityElement = true
            actionView.accessibilityLabel = action.description
            
            var customActions: [UIAccessibilityCustomAction] = []
            
            for i in 0..<action.actions.count {
                let act = action.actions[i]
                
                let customAction = UIAccessibilityCustomAction(name: act, target: self, selector: #selector(performAction))
                customActions.append(customAction)
            }
            
            actionView.accessibilityCustomActions = customActions
            
            self.actionViews.append(actionView)
            self.view.addSubview(actionView)
        }
    }
    
    @objc internal func performAction(action: UIAccessibilityCustomAction) -> Bool {
        guard let result = getResult(for: action) else {
            return false
        }
        EscapeFromBlindnessAccessibility.shared.post(notification: .announcement, argument: result)
        return true
    }
    
    private func getResult(for action: UIAccessibilityCustomAction) -> String? {
        var levelActionIndex: Int? = nil
        var actionIndex: Int? = nil
        
        levelActionIndex = self.level.levelActions.firstIndex { (levelAction) -> Bool in
            
            actionIndex = levelAction.actions.firstIndex { (inputAction) -> Bool in
                let isMatchingAction = action.name == inputAction
                return isMatchingAction
            }
            if let _ = actionIndex {
                return true
            } else {
                return false
            }
        }
        
        if let levelActionIndex = levelActionIndex, let actionIndex = actionIndex {
            let levelAction = self.level.levelActions[levelActionIndex]
            let result = levelAction.results[actionIndex]
            return result
        } else {
            return nil
        }
    }

}
