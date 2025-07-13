//
//  XKBaseCollectionViewCell.swift
//  TcbProfileModule
//
//  Created by Kenneth Tse on 2025/7/6.
//

import UIKit
import Combine

open class XKBaseCollectionViewCell: UICollectionViewCell {
    
    public var reuseCancellable = Set<AnyCancellable>()
    public var cancellable = Set<AnyCancellable>()
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        initMethod()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initMethod()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reuseCancellable = Set<AnyCancellable>()
    }
    private func initMethod() {
        setupUI()
        bindData()
    }
    open func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    open func bindData() {
        
    }
}
