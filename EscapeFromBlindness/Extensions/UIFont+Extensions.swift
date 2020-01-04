//
//  Created by Stanislas Chevallier on 27/03/2019.
//  Copyright © 2019 Michael Martinez. All rights reserved.
//

import UIKit

extension UIFont {

    /// Usage: textLabel.font = UIFont.custom(style: .montserratSemiBold, size: 30)
    enum CustomFont: String {
        case lucioleRegular  = "Luciole-Regular"
        case montserratBlack = "Montserrat-Black"
        case montserratBold  = "Montserrat-Bold"
        case montserratExtraBold  = "Montserrat-ExtraBold"
        case montserratSemiBold   = "Montserrat-SemiBold"
    }
    
    static func custom(style: CustomFont, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
    
    func scaled(using textStyle: UIFont.TextStyle) -> UIFont {
        let pointSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let updatedFont = UIFont(name: fontName, size: pointSize)!
        return UIFontMetrics.default.scaledFont(for: updatedFont)
    }
}
