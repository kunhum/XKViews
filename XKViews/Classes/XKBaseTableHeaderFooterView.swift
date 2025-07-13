//
//  XKBaseTableHeaderFooterView.swift
//  TcbProfileModule
//
//  Created by Kenneth Tse on 2025/7/11.
//

import UIKit

open class XKBaseTableHeaderFooterView: UITableViewHeaderFooterView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initMethod()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initMethod()
    }
    
    private func initMethod() {
        setupUI()
        bindData()
    }
    
    open func setupUI() {
        contentView.backgroundColor = .clear
    }
    
    open func bindData() {}
}
