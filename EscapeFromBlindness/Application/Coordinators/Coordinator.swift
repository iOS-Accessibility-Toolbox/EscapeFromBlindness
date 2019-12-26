//
//  Created by Michael Martinez on 26/06/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    var rootViewController: UIViewController { get }
    
    var children: [Coordinator] { get set }
    
}

extension Coordinator {
    
    /// Add a child coordinator to the parent
    func add(child: Coordinator) {
        self.children.append(child)
    }
    
    /// Remove a child coordinator from the parent
    func remove(child: Coordinator) {
        self.children = self.children.filter { $0 !== child }
    }
    
}
