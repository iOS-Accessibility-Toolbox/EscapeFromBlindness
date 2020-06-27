protocol Router {
    func routeToChapter(_ chapter: Chapter, isNewChapter: Bool)
    func routeToLevel(_ level: Level)
    func routeToResults()
}

protocol GameFlowProtocol {
    func getCurrentChapterIndex() -> Int
    func getChapters() -> [Chapter]
    func getTitleForChapter(chapterIndex: Int?) -> String?
    func getCurrentLevelIndex(levelIndex: Int?) -> Int
    func start()
    func loadLevel(_ chapterIndex: Int, _ levelIndex: Int)
    func restart()
    func validate(_ answers: [Level.Answer])
    func validateChapter()
}

extension GameFlowProtocol {
    func getTitleForChapter(chapterIndex: Int? = nil) -> String? {
        self.getTitleForChapter(chapterIndex: chapterIndex)
    }
    
    func getCurrentLevelIndex(levelIndex: Int? = nil) -> Int {
        self.getCurrentLevelIndex(levelIndex: levelIndex)
    }
}

class GameFlow: GameFlowProtocol {
    private let chapters: [Chapter]
    private var currentChapterIndex: Int
    private var currentLevelIndex: Int
    
    func getChapters() -> [Chapter] {
        return self.chapters
    }
    
    private var currentChapter: Chapter? {
        return self.chapters[safe: max(0, self.currentChapterIndex - 1)]
    }
    private var currentLevel: Level? {
        return self.currentChapter?.levels[safe: self.currentLevelIndex]
    }
    
    var router: Router?
    
    init(chapters: [Chapter], currentChapterIndex: Int, currentLevelIndex: Int) {
        self.chapters = chapters
        self.currentChapterIndex = currentChapterIndex
        self.currentLevelIndex = currentLevelIndex
    }
    
    func getCurrentChapterIndex() -> Int {
        return self.currentChapterIndex
    }
    
    func getTitleForChapter(chapterIndex: Int? = nil) -> String? {
        return chapterIndex == nil ? self.currentChapter?.title : self.chapters[safe: chapterIndex!]?.title
    }
    
    func getCurrentLevelIndex(levelIndex: Int? = nil) -> Int {
        return levelIndex == nil ? self.currentLevelIndex : levelIndex!
    }
    
    func start() {
        if let currentChapter = self.currentChapter {
            router?.routeToChapter(currentChapter, isNewChapter: false)
        }
    }
    
    func loadLevel(_ chapterIndex: Int, _ levelIndex: Int) {
        if let chapter = self.chapters[safe: chapterIndex], let level = chapter.levels[safe: levelIndex] {
            //router?.routeToChapter(chapter, isNewChapter: false)
            router?.routeToLevel(level)
        }
    }
    
    func restart() {
        self.currentChapterIndex = 0
        self.currentLevelIndex = 0
    }
    
    func validate(_ answers: [Level.Answer]) {
        if validateAnswers(answers) {
            self.currentLevelIndex += 1
            
            if hasReachedNewChapter() {
                self.currentChapterIndex += 1
                let levelIndexSwap = self.currentLevelIndex
                self.currentLevelIndex = 0
                
                if let chapter = self.currentChapter {
                    router?.routeToChapter(chapter, isNewChapter: true)
                } else {
                    self.currentChapterIndex -= 1
                    self.currentLevelIndex = levelIndexSwap
                    router?.routeToResults()
                }
            } else {
                if let level = self.currentLevel {
                    router?.routeToLevel(level)
                }
            }
        }
    }
    
    private func hasReachedNewChapter() -> Bool {
        if let currentChapter = self.currentChapter {
            return self.currentLevelIndex >= currentChapter.levels.count
        } else {
            return false
        }
    }
    
    func validateChapter() {
        guard currentChapterIndex > 0 else {
            self.currentChapterIndex += 1
            guard let currentChapter = currentChapter else { return }
            router?.routeToChapter(currentChapter, isNewChapter: true)
            return
        }
        
        if let level = self.currentLevel {
            router?.routeToLevel(level)
        }
    }
    
    private func validateAnswers(_ answers: [Level.Answer]) -> Bool {
        if let currentLevel = self.currentLevel {
            return currentLevel.validAnswers == answers
        } else {
            return false
        }
    }
    
}
