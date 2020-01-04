//
//  Created by Michael Martinez on 26/06/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

protocol StoryboardLoadable where Self: UIViewController {
    
    static var storyboardName: String { get }
    
    static func fromStoryboard(bundle: Bundle?) -> Self
}

extension StoryboardLoadable {
    
    static var storyboardName: String {
        return "Main"
    }
    
    static func fromStoryboard(bundle: Bundle? = nil) -> Self {
        
        let storyboard = UIStoryboard(name: Self.storyboardName, bundle: bundle)
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: type(of: Self()))) as! Self
    }
}
