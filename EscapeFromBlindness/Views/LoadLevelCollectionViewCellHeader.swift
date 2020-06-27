//
//  Created by Michael Martinez on 21/04/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import UIKit

class LoadLevelCollectionViewCellHeader: UICollectionReusableView {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
//        titleLabel.frame.origin = CGPoint(x: 15, y: 64 + (frame.height - 64 - titleLabel.frame.height) / 2)
        titleLabel.frame = CGRect(origin: CGPoint(x: 15, y: 64 + (frame.height - 64 - titleLabel.frame.height) / 2), size: CGSize(width: UIScreen.main.bounds.width - 35, height: titleLabel.frame.height))
    }
}
