//
//  Created by Michael Martinez on 19/03/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

func randomDigits(_ count: Int) -> Int {
    let digits = 0...9
    let shuffledDigits = digits.shuffled()
    let fourDigits = shuffledDigits.prefix(4)
    let value = fourDigits.reduce(0) {
        $0*10 + $1
    }
    return value
}
