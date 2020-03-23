//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    @discardableResult
    mutating func apply(_ padding: UIViewStyle.Padding) -> Self {
        if let left = padding.left {
            self.left = left
        }
        if let right = padding.right {
            self.right = right
        }
        if let top = padding.top {
            self.top = top
        }
        if let bottom = padding.bottom {
            self.bottom = bottom
        }
        return self
    }

    @discardableResult
    mutating func left(_ left: CGFloat = 0) -> Self {
        self.left = left
        return self
    }
    @discardableResult
    mutating func right(_ right: CGFloat = 0) -> Self {
        self.right = right
        return self
    }
    @discardableResult
    mutating func top(_ top: CGFloat = 0) -> Self {
        self.top = top
        return self
    }
    @discardableResult
    mutating func bottom(_ bottom: CGFloat = 0) -> Self {
        self.bottom = bottom
        return self
    }
}
