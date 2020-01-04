//
//  ChapterViewController.swift
//  EscapeFromBlindness
//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    
    // MARK: Outlets
    var chapterLabel: UILabel = {
        let label = UILabel()
        label.accessibilityTraits = .header
        label.textColor = .white
        label.font = UIFont.custom(style: .montserratSemiBold, size: 16)
        return label
    }()
    
    var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Go !", for: .normal)
        return button
    }()
    
    // MARK: Initialization
    private var chapter = 0
    
    convenience init(chapter: Int) {
        self.init()
        self.chapter = chapter
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.chapterLabel.text = presentChapterText(for: self.chapter)
    }
    
    // MARK: Actions
    @objc private func onContinueButtonTouched() {
        self.coordinator?.presentGameController()
    }
    
    // MARK: Private Methods
    private func setupView() {
        self.view.backgroundColor = .black
        
        self.view.addSubview(self.chapterLabel)
        self.view.addSubview(self.continueButton)
        
        self.chapterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.chapterLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.chapterLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
        self.chapterLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        self.continueButton.topAnchor.constraint(equalTo: self.chapterLabel.bottomAnchor, constant: 50).isActive = true
        let continueButtonWidth: CGFloat = 50.0
        self.continueButton.widthAnchor.constraint(equalToConstant: continueButtonWidth).isActive = true
        self.continueButton.widthAnchor.constraint(equalToConstant: continueButtonWidth).isActive = true
        
        self.continueButton.addTarget(self, action: #selector(onContinueButtonTouched), for: .touchUpInside)
    }
    
    private func presentChapterText(for chapter: Int) -> String {
        var chapterText = "Chapter \(chapter): "
        switch chapter {
        case 1:
            chapterText += "A new world"
        default:
            break
        }
        return chapterText
    }
    
}
