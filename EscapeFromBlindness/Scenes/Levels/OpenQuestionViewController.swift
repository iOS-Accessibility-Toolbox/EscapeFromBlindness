//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class OpenQuestionViewController: LevelBaseViewController {
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .white
        textField.returnKeyType = .done
        return textField
    }()
    
    // MARK: - Initialization
    private var level: OpenQuestionLevel!
    
    convenience init(level: OpenQuestionLevel) {
        self.init()
        self.level = level
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        setupHints()
        super.viewDidLoad()
        setupViews()
        self.mainLabel.text = level.question
        self.textField.delegate = self
    }
    
    private func setupHints() {
        self.hints = level.hints
    }
    
    private func setupViews() {
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(self.textField)
        
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.mainLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.mainLabel.numberOfLines = 2
        self.mainLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        self.textField.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 30).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: CGFloat(-350.heightScaledFromIphoneX())).isActive = true
    }

}

extension OpenQuestionViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            let sanitizedAnswer = sanitizeAnswer(text)
            coordinator?.validate([sanitizedAnswer])
        }
    }
    
    private func sanitizeAnswer(_ answer: String) -> String {
        return answer.folding(options: .diacriticInsensitive, locale: .current).lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
