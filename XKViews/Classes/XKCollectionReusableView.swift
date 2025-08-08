//
//  XKCollectionReusableView.swift
//  XKViews
//
//  Created by Kenneth Tse on 2025/7/22.
//

import UIKit

open class XKCollectionReusableView: UICollectionReusableView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
        
    }
    
    open func bindData() {
        
    }
}
