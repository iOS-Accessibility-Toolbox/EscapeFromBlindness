//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class LocalLevelFactoryTests: XCTestCase {
    
    private let expectedNumberOfLevels = 4
    private let expectedNumberOfSublevels = 5
    
    func test_build_shouldReturnCorrectNumberOfLevels() {
        let chapters = LocalLevelFactory.build()
        
        XCTAssertEqual(chapters.count, expectedNumberOfLevels)
        for i in 0..<expectedNumberOfLevels {
            XCTAssertEqual(chapters[i].levels.count, expectedNumberOfSublevels)
        }
    }
    
    func test_build_shouldReturnEqualNumberOfEachLevelTypes() {
        let chapters = LocalLevelFactory.build()
        
        XCTAssertEqual(chapters[0].levels.filter { $0 is ClosedQuestionLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(chapters[1].levels.filter { $0 is RotorLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(chapters[2].levels.filter { $0 is OpenQuestionLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(chapters[3].levels.filter { $0 is SearchLevel }.count, expectedNumberOfSublevels)
    }
    
}
