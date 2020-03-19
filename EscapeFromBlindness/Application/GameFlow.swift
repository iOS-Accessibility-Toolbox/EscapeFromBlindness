protocol Router {
    func routeToChapter(_ chapter: Chapter, isNewChapter: Bool)
    func routeToLevel(_ level: Level)
    func routeToResults()
}

protocol GameFlowProtocol {
    func getCurrentChapterIndex() -> Int
    func getCurrentChapterTitle() -> String?
    func getCurrentLevelIndex() -> Int
    func start()
    func restart()
    func validate(_ answers: [Level.Answer])
    func validateChapter()
}

class GameFlow: GameFlowProtocol {
    private let chapters: [Chapter]
    private var currentChapterIndex: Int
    private var currentLevelIndex: Int
    
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
    
    func getCurrentChapterTitle() -> String? {
        return self.currentChapter?.title
    }
    
    func getCurrentLevelIndex() -> Int {
        return self.currentLevelIndex
    }
    
    func start() {
        if let currentChapter = self.currentChapter {
            router?.routeToChapter(currentChapter, isNewChapter: false)
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
                self.currentLevelIndex = 0
                
                if let chapter = self.currentChapter {
                    router?.routeToChapter(chapter, isNewChapter: true)
                } else {
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
        print("GameFlow::validateChapter \(currentChapterIndex) \(currentLevelIndex)")
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
