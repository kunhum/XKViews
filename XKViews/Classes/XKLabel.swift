//
//  XKLabel.swift
//  TcbOrderCentreModule
//
//  Created by Kenneth Tse on 2025/6/24.
//

import UIKit

open class XKLabel: UILabel {
    
    open var textInsets: UIEdgeInsets = .zero
    
    open override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: textInsets)
        super.drawText(in: insetRect)
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}
