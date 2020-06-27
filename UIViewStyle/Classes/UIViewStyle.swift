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

        public init(left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) {
            self.left = left
            self.right = right
            self.top = top
            self.bottom = bottom
        }

        public init(_ padding: CGFloat) {
            self.init(left: padding, right: padding, top: padding, bottom: padding)
        }
    }

    public enum TextAlignment: String, Codable {
        case left
        case center
        case right
        case justified
        case natural
    }

    public enum FontTrait: String, Codable {
        case italic
        case bold
        case expanded
        case condensed
        case monoSpace
        case vertical
        case uiOptimized
        case tightLeading
        case looseLeading
    }

    public enum FontStyle: String, Codable {
        case largeTitle
        case title1
        case title2
        case title3
        case headline
        case subheadline
        case body
        case callout
        case footnote
        case caption1
        case caption2
    }

    public struct Point: Codable {
        public var x: CGFloat
        public var y: CGFloat

        public init(x: CGFloat = 0, y: CGFloat = 0) {
            self.x = x
            self.y = y
        }

        public init(_ value: CGFloat) {
            self.init(x: value, y: value)
        }
    }

    public var inherited: [String]?
    public var padding: Padding?
    public var textAlignment: TextAlignment?
    public var textColor: Color?
    public var fontSize: CGFloat?
    public var fontStyle: FontStyle?
    public var fontTrait: FontTrait?
    public var backgroundColor: Color?
    public var cornerRadius: CGFloat?
    public var borderWidth: CGFloat?
    public var borderColor: Color?
    public var isHidden: Bool?
    public var clipsToBounds: Bool?
    public var numberOfLines: Int?
    public var shadowColor: Color?
    public var shadowOpacity: Float?
    public var shadowOffset: Point?
    public var shadowRadius: CGFloat?

    public init(
        padding: Padding? = nil,
        textAlignment: TextAlignment? = nil,
        textColor: Color? = nil,
        fontStyle: FontStyle? = nil,
        fontTrait: FontTrait? = nil,
        fontSize: CGFloat? = nil,
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: Color? = nil,
        isHidden: Bool? = nil,
        clipsToBounds: Bool? = nil,
        numberOfLines: Int? = nil,
        shadowColor: Color? = nil,
        shadowOpacity: Float? = nil,
        shadowOffset: Point? = nil,
        shadowRadius: CGFloat? = nil
    ) {
        self.padding = padding
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.fontStyle = fontStyle
        self.fontTrait = fontTrait
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.isHidden = isHidden
        self.clipsToBounds = clipsToBounds
        self.numberOfLines = numberOfLines
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
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

    mutating public func combine(with styles: [String: UIViewStyle]?) {
        guard let combined = self.combined(with: styles) else {
            return
        }
        self = combined
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
    result.fontSize = rhs.fontSize ?? lhs.fontSize
    result.fontStyle = rhs.fontStyle ?? lhs.fontStyle
    result.fontTrait = rhs.fontTrait ?? lhs.fontTrait
    result.cornerRadius = rhs.cornerRadius ?? lhs.cornerRadius
    result.borderWidth = rhs.borderWidth ?? lhs.borderWidth
    result.borderColor = rhs.borderColor ?? lhs.borderColor
    result.isHidden = rhs.isHidden ?? lhs.isHidden
    result.clipsToBounds = rhs.clipsToBounds ?? lhs.clipsToBounds
    result.numberOfLines = rhs.numberOfLines ?? lhs.numberOfLines
    result.shadowColor = rhs.shadowColor ?? lhs.shadowColor
    result.shadowOpacity = rhs.shadowOpacity ?? lhs.shadowOpacity
    result.shadowOffset = rhs.shadowOffset ?? lhs.shadowOffset
    result.shadowRadius = rhs.shadowRadius ?? lhs.shadowRadius
    return result
}

public extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func bold() -> UIFont {
        withTraits(.traitBold)
    }

    func italic() -> UIFont {
        withTraits(.traitItalic)
    }
}

public extension UIViewStyle.FontStyle {
    init(uiFontTextStyle: UIFont.TextStyle) {
        if #available(iOS 11.0, *) {
            if uiFontTextStyle == .largeTitle {
                self = .largeTitle
                return
            } else {
                self = .title1
                return
            }
        }
        switch uiFontTextStyle {
        case UIFont.TextStyle.title1:
            self = .title1
        case UIFont.TextStyle.title2:
            self = .title2
        case UIFont.TextStyle.title3:
            self = .title3
        case UIFont.TextStyle.headline:
            self = .headline
        case UIFont.TextStyle.subheadline:
            self = .subheadline
        case UIFont.TextStyle.body:
            self = .body
        case UIFont.TextStyle.callout:
            self = .callout
        case UIFont.TextStyle.footnote:
            self = .footnote
        case UIFont.TextStyle.caption1:
            self = .caption1
        case UIFont.TextStyle.caption2:
            self = .caption2
        default:
            self = .body
        }
    }

    var uiFontTextStyle: UIFont.TextStyle {
        switch self {
        case .largeTitle:
            if #available(iOS 11.0, *) {
                return .largeTitle
            } else {
                return .title1
            }
        case .title1:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption1:
            return .caption1
        case .caption2:
            return .caption2
        }
    }
}

public extension UIViewStyle.FontTrait {
    var symbolicTraits: UIFontDescriptor.SymbolicTraits {
        switch self {
        case .italic:
            return .traitItalic
        case .bold:
            return .traitBold
        case .expanded:
            return .traitExpanded
        case .condensed:
            return .traitCondensed
        case .monoSpace:
            return .traitMonoSpace
        case .vertical:
            return .traitVertical
        case .uiOptimized:
            return .traitUIOptimized
        case .tightLeading:
            return .traitTightLeading
        case .looseLeading:
            return .traitLooseLeading
        }
    }
}
