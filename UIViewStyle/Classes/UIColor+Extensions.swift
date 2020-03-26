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
