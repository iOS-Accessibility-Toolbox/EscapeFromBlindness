//
//  Created by Michael Martinez on 19/02/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

struct RandomFramesGenerator {
    static func generateFrames(count: Int) -> [CGRect] {
        var frames: [CGRect] = []
        for i in 0..<count {
            let frame = CGRect(x: 80 * i, y: 140 + 120 * i, width: 80, height: 80)
            frames.append(frame)
        }
        return frames
    }
}
