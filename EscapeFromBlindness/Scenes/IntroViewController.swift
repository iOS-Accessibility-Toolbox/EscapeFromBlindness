//
//  IntroViewController.swift
//  EscapeFromBlindness
//
//  Created by Michael Martinez on 04/01/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

extension IntroViewController: XibLoadable {}

class IntroViewController: UIViewController, Coordinated {
    var coordinator: AppCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
