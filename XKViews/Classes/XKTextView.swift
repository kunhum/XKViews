//
//  XKTextView.swift
//  XKViews
//
//  Created by Kenneth Tse on 2025/4/27.
//

import UIKit

public protocol XKTextViewDelegate: NSObjectProtocol {
    func textView(didTapLink key: String) -> Bool
    func textView(didChange text: String)
}
extension XKTextViewDelegate {
    public func textView(didTapLink key: String) -> Bool { return false }
    public func textView(didChange text: String) {}
}

open class XKTextView: UITextView {
    
    public weak var xkDelegate: XKTextViewDelegate?
    
    private var linkKeys: [String] = []
    
    private lazy var placeholderLabel = UILabel()
    
    private var attributedPlaceHolder: NSAttributedString?
    
    convenience public init(isEditable: Bool = false,
                            font: UIFont? = nil,
                            textColor: UIColor? = nil,
                            textContainerInset: UIEdgeInsets = .zero,
                            lineFragmentPadding: Double = 0,
                            backgroundColor: UIColor = .white,
                            attributedText: NSAttributedString? = nil,
                            attributedPlaceHolder: NSAttributedString? = nil,
                            delegate: (any XKTextViewDelegate)? = nil) {
        self.init()
        
        self.isEditable = isEditable
        if let font { self.font = font }
        if let textColor { self.textColor = textColor }
        self.textContainer.lineFragmentPadding = lineFragmentPadding
        self.backgroundColor = backgroundColor
        if let attributedText { self.attributedText = attributedText }
        self.attributedPlaceHolder = attributedPlaceHolder
        self.delegate = self
        self.textContainerInset = textContainerInset
        contentInset = .zero
        textContainer.lineFragmentPadding = .zero
        xkDelegate = delegate
        setupUI()
    }
    
    func setupUI() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.numberOfLines = 0
        placeholderLabel.attributedText = attributedPlaceHolder
        addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainerInset.left),
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// 请确保已经设置了attributedText
    open func addLink(key: String, text: String) {
        guard let tmpAttText = self.attributedText else { return }
        let attributedText = NSMutableAttributedString(attributedString: tmpAttText)
        guard let range = attributedText.string.range(of: text) else { return }
        let tmpRange = NSRange(range, in: attributedText.string)
        guard tmpRange.location != NSNotFound,
              tmpRange.location >= 0,
              tmpRange.length >= 0,
              tmpRange.location + tmpRange.length <= attributedText.length else { return }
        attributedText.addAttribute(.link, value: key, range: tmpRange)
        self.attributedText = attributedText
        linkKeys.append(key)
    }
    
    open func setLinkTextAttributes(attributes: [NSAttributedString.Key : Any]) {
        linkTextAttributes = attributes
    }
    /// if you want to type some, use this to replace .text
    open func text(_ str: String) {
        text = str
        placeholderLabel.isHidden = hasText
        xkDelegate?.textView(didChange: str)
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
    
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.hasText
        xkDelegate?.textView(didChange: textView.text)
    }
}
