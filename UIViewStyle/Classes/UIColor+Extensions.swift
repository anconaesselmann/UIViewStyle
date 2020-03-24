//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public struct Color: Codable {
    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8
    public let alpha: CGFloat?

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
