//
//  Created by Michael Martinez on 19/03/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import Foundation

extension Bundle {
    
    static func customSoundURL(type: CustomSoundTypes) -> URL {
        let path = Bundle.main.path(forResource: type.rawValue, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        return url
    }
    
}
