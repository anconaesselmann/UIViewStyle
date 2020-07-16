//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public enum RgbColorComponent {
    case red(UInt8)
    case green(UInt8)
    case blue(UInt8)
    case alpha(CGFloat)

    public init?(_ string: String?) {
        guard let string = string else {
            return nil
        }
        let components = string.split(separator: ":")
        guard
            components.count == 2,
            let colorString = components.first,
            let valueString = components.last
        else {
            return nil
        }
        switch colorString {
            case "r", "red":
                guard let value = UInt8(valueString) else {
                    return nil
                }
                self = .red(value)
            case "g", "green":
                guard let value = UInt8(valueString) else {
                    return nil
                }
                self = .green(value)
            case "b", "blue":
                guard let value = UInt8(valueString) else {
                    return nil
                }
                self = .blue(value)
            case "a", "alpha":
                guard let value = Double(valueString) else {
                    return nil
                }
                self = .alpha(CGFloat(value))
        default:
            return nil
        }
    }
}

public struct Color: Codable {

    enum Error: Swift.Error {
        case notAHexString
    }

    enum Keys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
        case hex
    }

    public var red: UInt8
    public var green: UInt8
    public var blue: UInt8
    public var alpha: CGFloat?

    public init(red: UInt8 = 0, green: UInt8 = 0, blue: UInt8 = 0, alpha: CGFloat? = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    public init?(hexString: String) {
        guard let (r, g, b, a) = UIColor.hexStringToCgFloat(hexString) else {
            return nil
        }
        self.init(red: UInt8(r), green: UInt8(g), blue: UInt8(b), alpha: a)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        if let hexString = try? container.decode(String.self, forKey: .hex) {
            (self.red, self.green, self.blue, self.alpha) = try Self.hexToRgb(hexString)
        } else {
            self.red   = try  container.decode(UInt8.self,   forKey: .red)
            self.green = try  container.decode(UInt8.self,   forKey: .green)
            self.blue  = try  container.decode(UInt8.self,   forKey: .blue)
            self.alpha = try? container.decode(CGFloat.self, forKey: .alpha)
        }
    }

    private static func hexToRgb(_ hexString: String) throws -> (UInt8, UInt8, UInt8, CGFloat) {
        guard let (r, g, b, a) = UIColor.hexStringToUInt8(hexString) else {
            throw Error.notAHexString
        }
        return (r, g, b, a)
    }

    public func encode(to encoder: Encoder) throws { fatalError("Not yet implemented") }

    /// Example: "r:168,g:33,b:22,a:0.5"
    public init(rgbString: String) {
        let components: [RgbColorComponent] = rgbString
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .compactMap { RgbColorComponent($0) }
        var color = Color()
        for compoent in components {
            color.update(component: compoent)
        }
        self = color
    }

    public mutating func update(component: RgbColorComponent) {
        switch component {
        case .red(let red):
            self.red = red
        case .green(let green):
            self.green = green
        case .blue(let blue):
            self.blue = blue
        case .alpha(let alpha):
            self.alpha = alpha
        }
    }

    public var uiColor: UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
    }

    public var cgColor: CGColor {
        uiColor.cgColor
    }
}

public extension UIColor {
    convenience init?(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        guard
            red   >= 0 && red   <= 255,
            green >= 0 && green <= 255,
            blue  >= 0 && blue  <= 255
        else {
            return nil
        }
        let alpha: CGFloat = (0.0...1.0).clamp(alpha)
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(_ red: UInt8, _ green: UInt8, _ blue: UInt8) {
        self.init(red: red, green: green, blue: blue)
    }

    convenience init?(hexString: String) {
        guard let (r, g, b, a) = Self.hexStringToCgFloat(hexString) else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    static func hexStringToCgFloat(_ hexString: String) -> (CGFloat, CGFloat, CGFloat, CGFloat)? {
        guard let (r, g, b, a) = Self.hexStringToUInt8(hexString) else {
            return nil
        }
        return (CGFloat(r / 255), CGFloat(g / 255), CGFloat(b / 255), a)
    }

    static func hexStringToUInt8(_ hexString: String) -> (UInt8, UInt8, UInt8, CGFloat)? {
        guard hexString.hasPrefix("#") else {
            return nil
        }
        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...])
        guard hexColor.count == 8 else {
            return nil
        }
        let r, g, b: UInt8
        let a: CGFloat
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }
        r = UInt8((hexNumber & 0xff000000) >> 24)
        g = UInt8((hexNumber & 0x00ff0000) >> 16)
        b = UInt8((hexNumber & 0x0000ff00) >> 8)
        a = CGFloat(hexNumber & 0x000000ff) / 255
        return (r, g, b, a)
    }

    static func rgb(_ red: UInt8, _ green: UInt8, _ blue: UInt8) -> UIColor {
        UIColor(red, green, blue)
    }

    // taken from https://www.hackingwithswift.com/example-code/uicolor/how-to-read-the-red-green-blue-and-alpha-color-components-from-a-uicolor
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }

    var color: Color {
        let (red, green, blue, alpha) = rgba
        return Color(red: UInt8(red * 255), green: UInt8(green * 255), blue: UInt8(blue * 255), alpha: alpha )
    }

}

public extension ClosedRange {
    func clamp(_ value : Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}
