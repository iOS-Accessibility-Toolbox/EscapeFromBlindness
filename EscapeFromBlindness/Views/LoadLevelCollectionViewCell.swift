//
//  Created by Michael Martinez on 21/04/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class LoadLevelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelLockedImageView: UIImageView!
    
    enum State {
        case completed
        case unlocked
        case locked
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 10
    }
    
    func configure(chapterIndex: Int, levelIndex: Int, state: State) {
        let displayedChapterIndex = chapterIndex + 1
        let displayedLevelIndex = levelIndex + 1
        
        switch state {
        case .completed:
            self.levelLabel.text = "\(displayedLevelIndex)"
            self.levelLabel.accessibilityLabel = "\(L10n.level) \(displayedLevelIndex) (\(L10n.complete))"
            
            self.containerView.backgroundColor = UIColor.init(red: 80/255, green: 144/255, blue: 6/255, alpha: 1)
            self.levelLockedImageView.isHidden = true
        case .unlocked:
            self.levelLabel.text = "\(displayedLevelIndex)"
            self.levelLabel.accessibilityLabel = "\(L10n.continue) \(L10n.level) \(displayedLevelIndex) \(L10n.chapter) \(displayedChapterIndex)"
            
            self.containerView.backgroundColor = .white
            self.levelLockedImageView.isHidden = true
        case .locked:
            self.levelLabel.text = " "
            self.levelLabel.accessibilityLabel = "\(L10n.level) \(displayedLevelIndex) (\(L10n.locked))"
            
            self.containerView.backgroundColor = .white
            self.levelLockedImageView.isHidden = false
        }
    }

}
