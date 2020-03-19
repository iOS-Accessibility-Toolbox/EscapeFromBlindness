//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class SearchAccessibilityCustomAction: UIAccessibilityCustomAction {
    let uuid: String
    
    init(uuid: String, name: String, target: Any?, selector: Selector) {
        self.uuid = uuid
        super.init(name: name, target: target, selector: selector)
    }
}

class SearchViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    
    // MARK: - Initialization
    private var level: SearchLevel!
    private var performedActions: [String?]!
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var actionViews: [UIView] = []
    
    convenience init(level: SearchLevel) {
        self.init()
        self.level = level
        self.performedActions = [String?].init(repeating: nil, count: self.level.levelActions.count)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLevelDescriptionLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupActionsViews()
    }
    
    // MARK: - Private Methods
    private func setupLevelDescriptionLabel() {
        self.view.addSubview(self.mainLabel)
        
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.mainLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        self.mainLabel.text = level.levelDescription
    }
    
    private func setupActionsViews() {
        let frameCount = level.levelActions.count
        let frames = RandomFramesGenerator.generateFrames(startY: Int(self.mainLabel.frame.maxY) + 5, count: frameCount)
        for i in 0..<frameCount {
            let action = level.levelActions[i]
            
            let frame = frames[i]
            let actionView = UIView(frame: frame)
            actionView.isAccessibilityElement = true
            actionView.accessibilityLabel = action.description
            
            var customActions: [UIAccessibilityCustomAction] = []
            
            for j in 0..<action.actions.count {
                let act = action.actions[j]
                let uuid = makeUuidName(i, j, act)
                
                let customAction = SearchAccessibilityCustomAction(
                    uuid: uuid,
                    name: act,
                    target: self,
                    selector: #selector(performAction)
                )
                customActions.append(customAction)
            }
            
            actionView.accessibilityCustomActions = customActions
            
            self.actionViews.append(actionView)
            self.view.addSubview(actionView)
        }
    }
    
    private func makeUuidName(_ i: Int, _ j: Int, _ action: String) -> String {
        return "\(i)_\(j)_\(action)"
    }
    
    @objc internal func performAction(action: UIAccessibilityCustomAction) -> Bool {
        guard let result = getResult(for: action) else {
            return false
        }
        EscapeFromBlindnessAccessibility.shared.post(notification: .announcement, argument: result)
        handleResult(for: action)
        return true
    }
    
    private func handleResult(for action: UIAccessibilityCustomAction) {
        let (index, subindex) = getIndexes(for: action)
        guard let idx = index, let subidx = subindex else { return }
        self.performedActions![idx] = self.level.levelActions[idx].actions[subidx]
        let nonNilPerformedActions = self.performedActions.compactMap { $0 }
        
        if nonNilPerformedActions.count == self.level.levelActions.count {
            self.coordinator?.validate(nonNilPerformedActions)
        }
    }
    
    private func getResult(for action: UIAccessibilityCustomAction) -> String? {
        var levelActionIndex: Int? = nil
        var actionIndex: Int? = nil
        
        (levelActionIndex, actionIndex) = getIndexes(for: action)
        
        if let levelActionIndex = levelActionIndex, let actionIndex = actionIndex {
            print("Action \(levelActionIndex) \(actionIndex)")
            let levelAction = self.level.levelActions[levelActionIndex]
            let result = levelAction.results[actionIndex]
            return result
        } else {
            return nil
        }
    }
    
    private func getIndexes(for action: UIAccessibilityCustomAction) -> (Int?, Int?) {
        guard let searchAction = action as? SearchAccessibilityCustomAction else { return (nil, nil) }
        
        var levelActionIndex: Int? = nil
        var actionIndex: Int? = nil
        
        for i in 0..<self.level.levelActions.count {
            let levelAction = self.level.levelActions[i]
            for j in 0..<levelAction.actions.count {
                let inputAction = levelAction.actions[j]
                let uuidName = makeUuidName(i, j, inputAction)
                
                let isMatchingAction = searchAction.uuid == uuidName
                if isMatchingAction {
                    levelActionIndex = i
                    actionIndex = j
                }
            }
        }
        
        return (levelActionIndex, actionIndex)
    }

}
