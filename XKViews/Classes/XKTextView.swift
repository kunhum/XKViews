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
        self.textContainerInset = textContainerInset
        self.textContainer.lineFragmentPadding = lineFragmentPadding
        self.backgroundColor = backgroundColor
        if let attributedText { self.attributedText = attributedText }
        self.attributedPlaceHolder = attributedPlaceHolder
        self.delegate = self
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
    
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.hasText
    }
}
