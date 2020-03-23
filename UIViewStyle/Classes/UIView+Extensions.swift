//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    func apply(_ style: UIViewStyle) -> Self {
        if let color = style.backgroundColor {
            background(color: color)
        }
        if let cornerRadius = style.cornerRadius {
            self.cornerRadius(cornerRadius)
        }
        if let borderWidth = style.borderWidth {
            self.border(width: borderWidth)
        }
        if let borderColor = style.borderColor {
            self.border(color: borderColor)
        }
        if style.isHidden ?? false {
            hide()
        }
        return self
    }

    @discardableResult
    func background(color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    func background(color: Color) -> Self {
        background(color: color.uiColor)
    }

    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        return self
    }

    @discardableResult
    func border(width: CGFloat, color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func border(width: CGFloat, color: Color) -> Self {
        border(width: width, color: color.uiColor)
    }

    @discardableResult
    func border(width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func border(color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    func border(color: Color) -> Self {
        border(color: color.uiColor)
    }

    @discardableResult
    func hide() -> Self {
        isHidden = true
        return self
    }

    @discardableResult
    func show() -> Self {
        isHidden = false
        return self
    }
}
