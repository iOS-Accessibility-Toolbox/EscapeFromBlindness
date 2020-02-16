//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation
import XCTest
@testable import EscapeFromBlindness

class LocalLevelFactoryTests: XCTestCase {
    
    private let expectedNumberOfLevels = 5
    private let expectedNumberOfSublevels = 5
    
    func test_build_shouldReturnCorrectNumberOfLevels() {
        let levels = LocalLevelFactory.build()
        
        XCTAssertEqual(levels.count, expectedNumberOfLevels * expectedNumberOfSublevels)
    }
    
    func test_build_shouldReturnEqualNumberOfEachLevelTypes() {
        let levels = LocalLevelFactory.build()
        
        XCTAssertEqual(levels.filter { $0 is ClosedQuestionLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(levels.filter { $0 is RotorLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(levels.filter { $0 is OpenQuestionLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(levels.filter { $0 is SearchLevel }.count, expectedNumberOfSublevels)
        XCTAssertEqual(levels.filter { $0 is MazeLevel }.count, expectedNumberOfSublevels)
    }
    
}
