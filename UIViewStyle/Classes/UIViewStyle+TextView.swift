//  Created by Axel Ancona Esselmann on 5/5/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

open class TextView: UITextView {
    public var placeholder: String?

    private var padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) {
        didSet {
            self.textContainerInset = padding
        }
    }

    open func apply(textViewStyle style: UIViewStyle) -> Self {
        super.apply(style)
        if let color = style.textColor {
            text(color: color.uiColor)
        }
        padding(style.padding)
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

    @discardableResult
    open func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
    }

    @discardableResult
    open func text(color: UIColor) -> Self {
        textColor = color
        return self
    }

    @discardableResult
    open func cursor(color: UIColor) -> Self {
        tintColor = color
        return self
    }

    @discardableResult
    open func barItem(text: String?, color: UIColor, action: Selector) -> Self {
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
