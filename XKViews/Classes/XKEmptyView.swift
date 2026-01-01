//
//  XKEmptyView.swift
//  XKViews
//
//  Created by Kenneth Tse on 2025/10/2.
//

import Foundation

public class XKEmptyView {
    public static let shared = XKEmptyView()
    public var image: UIImage? = nil
    public var text: String = "暂无数据"
    
}

private struct UIViewControllerAssociatedKeys {
    static var emptyView = "XKEmptyView"
}

public extension UIViewController {
    
    var emptyView: UIView? {
        set {
            objc_setAssociatedObject(self, &UIViewControllerAssociatedKeys.emptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            objc_getAssociatedObject(self, &UIViewControllerAssociatedKeys.emptyView) as? UIView
        }
    }
    
    func getEmptyView() -> UIView {
        if emptyView == nil {
            emptyView = UIView.emptyView(image: XKEmptyView.shared.image, text: XKEmptyView.shared.text)
        }
        return emptyView ?? UIView()
    }
    
    func hideEmptyView() {
        let emptyView = getEmptyView()
        emptyView.isHidden = true
    }
    
    func showEmptyView() {
        
        let emptyView = getEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        if view.subviews.contains(where: { $0 == emptyView }) == false {
            view.addSubview(emptyView)
            NSLayoutConstraint.activate([
                emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        view.bringSubviewToFront(emptyView)
        emptyView.isHidden = false
    }
    
    func autoShowEmptyView(condiction: (() -> Bool)) {
        let shouldShow = condiction()
        if shouldShow {
            showEmptyView()
        } else {
            hideEmptyView()
        }
    }
}

public extension UIView {
    /// 空示意图
    class func emptyView(image: UIImage? = nil,
                         text: String? = "暂无数据",
                         font: UIFont = UIFont(name: "PingFangSC-Regular", size: 14) ?? .systemFont(ofSize: 14),
                         textColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)) -> UIView {
        let imageView = UIImageView(image: image)
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        imageView.isHidden = image == nil
        label.isHidden = text?.isEmpty ?? true
        return stackView
    }
}
