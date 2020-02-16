protocol Router {
    func routeToChapter(_ chapter: Chapter, isNewChapter: Bool)
    func routeToLevel(_ level: Level)
    func routeToResults()
}

protocol GameFlowProtocol {
    func getCurrentChapterIndex() -> Int
    func getCurrentLevelIndex() -> Int
    func start()
    func validate(_ answer: Level.Answer)
    func validateChapter()
}

class GameFlow: GameFlowProtocol {
    private let chapters: [Chapter]
    private var currentChapterIndex: Int
    private var currentLevelIndex: Int
    
    private var currentChapter: Chapter? {
        return self.chapters[safe: self.currentChapterIndex]
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
    
    func getCurrentLevelIndex() -> Int {
        return self.currentLevelIndex
    }
    
    func start() {
        router?.routeToChapter(self.chapters[self.currentChapterIndex], isNewChapter: false)
    }
    
    func validate(_ answer: Level.Answer) {
        if validateAnswer(answer) {
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
        return self.currentLevelIndex >= self.chapters[self.currentChapterIndex].levels.count
    }
    
    func validateChapter() {
        print("GameFlow::validateChapter \(currentChapterIndex) \(currentLevelIndex)")
        if let level = self.currentLevel {
            router?.routeToLevel(level)
        }
    }
    
    private func validateAnswer(_ answer: Level.Answer) -> Bool {
        return self.chapters[safe: self.currentChapterIndex]?.levels[safe: self.currentLevelIndex]?.validAnswers.contains(answer) ?? false
    }
    
}
