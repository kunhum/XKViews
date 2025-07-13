//
//  XKBaseTableViewCell.swift
//  TcbProfileModule
//
//  Created by Kenneth Tse on 2025/7/6.
//

import UIKit

open class XKBaseTableViewCell: UITableViewCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    open func setupUI() {}
    
    open func bindData() {}
}
