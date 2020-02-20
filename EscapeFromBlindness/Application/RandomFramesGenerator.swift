//
//  Created by Michael Martinez on 19/02/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

struct RandomFramesGenerator {
    static func generateFrames(count: Int) -> [CGRect] {
        var frames: [CGRect] = []
        for i in 0..<count {
            let frame = CGRect(x: 100 * i, y: 200 * i, width: 100, height: 100)
            frames.append(frame)
        }
        return frames
    }
}
