//  Created by Axel Ancona Esselmann on 3/18/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import CoreGraphics

public struct UIViewStyle: Codable {
    public struct Padding: Codable {
        public var left: CGFloat?
        public var right: CGFloat?
        public var top: CGFloat?
        public var bottom: CGFloat?
    }

    public enum TextAlignment: String, Codable {
        case left
        case center
        case right
        case justified
        case natural
    }

    public var inherited: [String]?
    public var padding: Padding?
    public var textAlignment: TextAlignment?
    public var textColor: Color?
    public var backgroundColor: Color?
    public var cornerRadius: CGFloat?
    public var borderWidth: CGFloat?
    public var borderColor: Color?
    public var isHidden: Bool?
    public var numberOfLines: Int?

    public init(
        padding: Padding? = nil,
        textAlignment: TextAlignment? = nil,
        textColor: Color? = nil,
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: Color? = nil,
        isHidden: Bool? = nil,
        numberOfLines: Int? = nil
    ) {
        self.padding = padding
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.isHidden = isHidden
        self.numberOfLines = numberOfLines
    }

    public func combined(with styles: [String: UIViewStyle]?) -> UIViewStyle? {
        let style = self
        guard let styles = styles, let inheritedNames = style.inherited else {
            return nil
        }
        var result = UIViewStyle()
        for inheritedName in inheritedNames {
            guard let inheritedStyle = styles[inheritedName] else {
                continue
            }
            result = result + inheritedStyle
        }
        return result + style
    }
}

public func +(lhs: UIViewStyle, rhs: UIViewStyle) -> UIViewStyle {
    var result = UIViewStyle()
    result.padding = UIViewStyle.Padding()

    if let left = rhs.padding?.left ?? lhs.padding?.left {
        result.padding?.left = left
    }
    if let right = rhs.padding?.right ?? lhs.padding?.right {
        result.padding?.right = right
    }
    if let top = rhs.padding?.top ?? lhs.padding?.top {
        result.padding?.top = top
    }
    if let bottom = rhs.padding?.bottom ?? lhs.padding?.bottom {
        result.padding?.bottom = bottom
    }

    result.textAlignment = rhs.textAlignment ?? lhs.textAlignment

    result.textColor = rhs.textColor ?? lhs.textColor
    result.backgroundColor = rhs.backgroundColor ?? lhs.backgroundColor
    result.cornerRadius = rhs.cornerRadius ?? lhs.cornerRadius
    result.borderWidth = rhs.borderWidth ?? lhs.borderWidth
    result.borderColor = rhs.borderColor ?? lhs.borderColor
    result.isHidden = rhs.isHidden ?? lhs.isHidden
    result.numberOfLines = rhs.numberOfLines ?? lhs.numberOfLines
    return result
}
