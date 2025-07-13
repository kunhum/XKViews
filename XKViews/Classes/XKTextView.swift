//
//  XKTextView.swift
//  XKViews
//
//  Created by Kenneth Tse on 2025/4/27.
//

import UIKit

public protocol XKTextViewDelegate: NSObjectProtocol {
    func textView(didTapLink key: String) -> Bool
}
extension XKTextViewDelegate {
    public func textView(didTapLink key: String) -> Bool { return false }
}

open class XKTextView: UITextView {
    
    var linkKeys: [String] = []
    
    public weak var xkDelegate: XKTextViewDelegate?
    
    convenience public init(isEditable: Bool = false,
                     textContainerInset: UIEdgeInsets = .zero,
                     lineFragmentPadding: Double = 0,
                     backgroundColor: UIColor = .white,
                            delegate: (any XKTextViewDelegate)? = nil) {
        self.init()
        
        self.isEditable = isEditable
        self.textContainerInset = textContainerInset
        self.textContainer.lineFragmentPadding = lineFragmentPadding
        self.backgroundColor = backgroundColor
        self.delegate = self
        xkDelegate = delegate
    }
    
    /// 请确保已经设置了attributedText
    open func addLink(key: String, range: Range<String.Index>?) {
        guard let tmpAttText = self.attributedText else { return }
        let attributedText = NSMutableAttributedString(attributedString: tmpAttText)
        guard let range = range else { return }
        let tmpRange = NSRange(range, in: attributedText.string)
        attributedText.addAttribute(.link, value: key, range: tmpRange)
        self.attributedText = attributedText
        linkKeys.append(key)
    }
    
    open func setLinkTextAttributes(attributes: [NSAttributedString.Key : Any]) {
        linkTextAttributes = attributes
    }
    
}

extension XKTextView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let key = URL.absoluteString
        guard linkKeys.contains(where: { $0 == key }) else {
            return true
        }
        return xkDelegate?.textView(didTapLink: key) ?? false
    }
    
}
