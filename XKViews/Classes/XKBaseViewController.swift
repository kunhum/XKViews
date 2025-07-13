//
//  XKBaseViewController.swift
//  TcbProfileModule
//
//  Created by Kenneth Tse on 2025/7/7.
//

import UIKit

open class XKBaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindData()
    }
    
    open func setupUI() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    open func bindData() {
        
    }

}
