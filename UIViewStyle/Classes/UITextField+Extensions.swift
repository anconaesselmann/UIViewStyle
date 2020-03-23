//  Created by Axel Ancona Esselmann on 3/23/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

open class TextField: UITextField {

    private var padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open func apply(textFieldStyle style: UIViewStyle) -> Self {
        padding(style.padding)
        super.apply(uiTextFieldStyle: style)
        return self
    }

    @discardableResult
    open func padding(_ padding: UIViewStyle.Padding?) -> Self {
       if let padding = padding {
            self.padding.apply(padding)
       }
       return self
    }

    @discardableResult
    open func padding(_ padding: CGFloat = 0) -> Self {
       self.padding = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
       return self
    }

    @discardableResult
    open func padding(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> Self {
       padding = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
       return self
    }
}

public extension UITextField {
    @discardableResult
    func apply(uiTextFieldStyle style: UIViewStyle) -> Self {
        super.apply(style)

        if let color = style.textColor {
            text(color: color.uiColor)
        }
        return self
    }

    @discardableResult
    func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
    }

    @discardableResult
    func text(color: UIColor) -> Self {
        textColor = color
        return self
    }

    @discardableResult
    func cursor(color: UIColor) -> Self {
        tintColor = color
        return self
    }

    @discardableResult
    func barItem(text: String?, color: UIColor, action: Selector) -> Self {
        let bar = UIToolbar()
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: action)
        done.tintColor = color
        bar.items = [/*flexibleSpace, */done]
        bar.sizeToFit()
        inputAccessoryView = bar
        return self
    }
}
