//
//  Created by Michael Martinez on 26/06/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import UIKit

protocol Coordinated where Self: UIViewController {
    var coordinator: AppCoordinatorProtocol? { get set }
}
