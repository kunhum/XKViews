//
//  XKButton.swift
//  XKViews
//
//  Created by Kenneth Tse on 2025/9/1.
//

import UIKit

/// 支持可配置内容边距与可扩展点击区域的按钮
public class XKButton: UIButton {

    /// 文本/图片与按钮边界的内边距
    public var contentPadding: UIEdgeInsets = .zero {
        didSet { updateInsets() }
    }

    /// 扩大点击区域（正值 = 往外扩，负值 = 缩小）
    var hitTestOutsets: UIEdgeInsets = .zero

    /// 文本与图片的水平间距（仅当 image+title 同时存在时生效）
    var spacing: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    // IB 支持
    @IBInspectable var paddingTop: CGFloat {
        get { contentPadding.top }
        set { contentPadding.top = newValue }
    }
    @IBInspectable var paddingLeft: CGFloat {
        get { contentPadding.left }
        set { contentPadding.left = newValue }
    }
    @IBInspectable var paddingBottom: CGFloat {
        get { contentPadding.bottom }
        set { contentPadding.bottom = newValue }
    }
    @IBInspectable var paddingRight: CGFloat {
        get { contentPadding.right }
        set { contentPadding.right = newValue }
    }

    public init(type: ButtonType = .custom,
                title: String = "",
                titleColor: UIColor? = nil,
                selectedTitle: String? = nil,
                selectedTitleColor: UIColor? = nil,
                font: UIFont? = nil,
                lines: Int? = nil,
                image: UIImage? = nil,
                selectedImage: UIImage? = nil,
                backgroundColor: UIColor? = nil,
                cornerRadius: Double? = nil,
                borderWidth: Double? = nil,
                borderColor: UIColor? = nil,
                            contentPadding: UIEdgeInsets = .zero,
                translatesAutoresizingMaskIntoConstraints: Bool = false) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        if let title = selectedTitle {
            setTitle(title, for: .selected)
        }
        setImage(image, for: .normal)
        if let image = selectedImage {
            setImage(image, for: .selected)
        }
        if let color = titleColor {
            setTitleColor(color, for: .normal)
        }
        if let color = selectedTitleColor {
            setTitleColor(color, for: .selected)
        }
        if let font = font {
            titleLabel?.font = font
        }
        if let lines = lines {
            titleLabel?.numberOfLines = lines
        }
        if let radius = cornerRadius {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(radius * 100)) / 100)
        }
        if let color = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let width = borderWidth {
            layer.borderWidth = width
        }
        if let color = borderColor {
            layer.borderColor = color.cgColor
        }
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        self.contentPadding = contentPadding
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        adjustsImageWhenHighlighted = true
        updateInsets()
    }

    private func updateInsets() {
        contentEdgeInsets = contentPadding
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    // 让 intrinsic size 把内边距也考虑进去（方便 Auto Layout）
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width  += contentPadding.left + contentPadding.right
        size.height += contentPadding.top  + contentPadding.bottom
        return size
    }

    // 调整 image 和 title 之间的间距
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard spacing != 0, let titleLabel, let imageView else { return }

        // 只处理水平布局（系统默认），纵向布局可按需扩展
        let half = spacing / 2
        titleEdgeInsets = UIEdgeInsets(top: 0, left: half, bottom: 0, right: -half)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -half, bottom: 0, right: half)
    }

    // 扩大点击区域
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if isHidden || alpha < 0.01 || !isUserInteractionEnabled { return false }
        let largerBounds = bounds.inset(by: UIEdgeInsets(
            top: -hitTestOutsets.top,
            left: -hitTestOutsets.left,
            bottom: -hitTestOutsets.bottom,
            right: -hitTestOutsets.right
        ))
        return largerBounds.contains(point)
    }
}
