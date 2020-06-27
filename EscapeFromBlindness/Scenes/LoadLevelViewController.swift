//
//  Created by Michael Martinez on 21/04/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class LoadLevelViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?
    private var chapters: [Chapter] = []
    private var currentChapterIndex: Int = 0
    private var currentLevelIndex: Int = 0
    private static let headerReuseId = "header"
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    convenience init(chapters: [Chapter], currentChapterIndex: Int, currentLevelIndex: Int) {
        self.init()
        self.chapters = chapters
        self.currentChapterIndex = currentChapterIndex
        self.currentLevelIndex = currentLevelIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize = CGSize(width: view.bounds.width, height: 156)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: self.currentLevelIndex, section: self.currentChapterIndex - 1)
        if isRunningTest {
            EscapeFromBlindnessAccessibility.shared.post(notification: .layoutChanged, argument: self.collectionView.cellForItem(at: indexPath))
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
                EscapeFromBlindnessAccessibility.shared.post(notification: .layoutChanged, argument: self.collectionView.cellForItem(at: indexPath))
            }
        }
    }
    
    private func setupCollectionView() {
        self.collectionView.register(LoadLevelCollectionViewCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LoadLevelViewController.headerReuseId)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(LoadLevelCollectionViewCell.self)
        
        self.collectionView.frame = CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height)
        self.view.addSubview(self.collectionView)
    }
    
}

extension LoadLevelViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.chapters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chapters[section].levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: LoadLevelViewController.headerReuseId,
                for: indexPath
            ) as! LoadLevelCollectionViewCellHeader
            
            let chapter = self.chapters[indexPath.section]
            header.titleLabel.text = "\(L10n.chapter) \(chapter.index): \(chapter.title ?? "")"
            header.titleLabel.textColor = .white
            header.titleLabel.font = .custom(style: .montserratExtraBold, size: 20.0)
            header.setNeedsLayout()
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LoadLevelCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        let candidateChapterIndex = indexPath.section
        let candidateLevelIndex = indexPath.item
        let state = getLevelState(candidateChapterIndex, candidateLevelIndex)
        
        cell.configure(chapterIndex: indexPath.section, levelIndex: indexPath.row, state: state)
        return cell
    }
    
    private func getLevelState(_ candidateChapterIndex: Int, _ candidateLevelIndex: Int) -> LoadLevelCollectionViewCell.State {
        let state: LoadLevelCollectionViewCell.State
        if candidateChapterIndex < (currentChapterIndex - 1) {
            state = .completed
        } else if candidateChapterIndex > (currentChapterIndex - 1) {
            state = .locked
        } else {
            if candidateLevelIndex < currentLevelIndex {
                state = .completed
            } else if candidateLevelIndex > currentLevelIndex {
                state = .locked
            } else {
                state = .unlocked
            }
        }
        return state
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chapterIndex = indexPath.section
        let levelIndex = indexPath.item
        
        if getLevelState(chapterIndex, levelIndex) != .locked {
            coordinator?.loadLevel(chapterIndex, levelIndex: levelIndex)
        }
    }
    
}
