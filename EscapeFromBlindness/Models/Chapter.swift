//
//  Created by Michael Martinez on 07/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

class Chapter {
    public let index: Int
    public let title: String?
    public let levels: [Level]
    
    init(index: Int, title: String? = nil, levels: [Level]) {
        self.index = index
        self.title = title
        self.levels = levels
    }
}
