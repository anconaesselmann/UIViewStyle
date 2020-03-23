//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public extension UIButton {

    @discardableResult
    func apply(buttonStyle style: UIViewStyle) -> Self {
        super.apply(style)
        padding(style.padding)
        if let color = style.textColor {
            text(color: color)
        }
        return self
    }

    @discardableResult
    func padding(_ padding: UIViewStyle.Padding?) -> Self {
        if let padding = padding {
            contentEdgeInsets.apply(padding)
        }
        return self
    }

    @discardableResult
    func padding(_ padding: CGFloat) -> Self {
        contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return self
    }

    @discardableResult
    func padding(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> Self {
        contentEdgeInsets = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
        return self
    }

    @discardableResult
    func text(color: UIColor) -> Self {
        setTitleColor(color, for: .normal)
        return self
    }

    @discardableResult
    func text(color: Color) -> Self {
        text(color: color.uiColor)
    }

    @discardableResult
    func text(_ text: String?) -> Self {
        setTitle(text, for: .normal)
        return self
    }

}
