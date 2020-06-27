//
//  Created by Michael Martinez on 19/02/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

struct RandomFramesGenerator {
    static func generateFrames(startY: Int = Int(165.0.heightScaledFromIphoneX()), count: Int) -> [CGRect] {
        var frames: [CGRect] = []
        for i in 0..<count {
            let frame = CGRect(x: 80 * i, y: startY + (120 * i).heightScaledFromIphoneX(), width: 80, height: 80.heightScaledFromIphoneX())
            frames.append(frame)
        }
        return frames
    }
}

public extension Int {
    func heightScaledFromIphoneX() -> Int {
        return Int((Double(self) / 812.0) * Double(UIScreen.main.bounds.height))
    }
}

public extension Double {
    func heightScaledFromIphoneX() -> Double {
        return (self / 812.0) * Double(UIScreen.main.bounds.height)
    }
}
