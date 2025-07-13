//
//  XKBaseView.swift
//  TcbProfileModule
//
//  Created by Kenneth Tse on 2025/7/7.
//

import UIKit

open class XKBaseView: UIView {
    
    public init() {
        super.init(frame: .zero)
        initMethod()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initMethod()
    }
    
    func initMethod() {
        setupUI()
        bindData()
    }
    
    open func setupUI() {
        backgroundColor = .clear
    }
    
    open func bindData() {
        
    }
}
