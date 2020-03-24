//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public extension UILabel {

    @discardableResult
    func apply(labelStyle style: UIViewStyle) -> Self {
        super.apply(style)
        if let color = style.textColor {
            text(color: color)
        }
        if let textAlignment = style.textAlignment?.nsTextAlignment {
            text(alignment: textAlignment)
        }
        if let numberOfLines = style.numberOfLines {
            self.numberOfLines(numberOfLines)
        }
        return self
    }

    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func text(_ formatter: () -> String?) -> Self {
        self.text = formatter()
        return self
    }

    @discardableResult
    func text(color: UIColor) -> Self {
        textColor = color
        return self
    }

    @discardableResult
    func text(color: Color) -> Self {
        text(color: color.uiColor)
    }

    @discardableResult
    func text(alignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func centered() -> Self {
        self.textAlignment = .center
        return self
    }

    @discardableResult
    func font(color: UIColor) -> Self {
        return text(color: color)
    }

    @discardableResult
    func multiline() -> Self {
        numberOfLines = 0
        return self
    }

    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
}
