//
//  Created by Michael Martinez on 26/06/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

protocol XibLoadable where Self: UIViewController {
    static var nibName: String { get }
    static func fromXib(bundle: Bundle?) -> Self
}

extension XibLoadable {
    static var nibName: String {
        return String(describing: type(of: Self()))
    }
    
    static func fromXib(bundle: Bundle? = nil) -> Self {
        let viewController = Self.init(nibName: nibName, bundle: bundle)
        return viewController
    }
}
