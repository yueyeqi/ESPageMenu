//
//  ESPageTitleView.swift
//
//  Created by payne on 2018/12/21.
//  Copyright © 2018 payne. All rights reserved.
//

import UIKit

class ESPageTitleView: UIView {

    var titleLabel = UILabel()
    var selectColor = UIColor.blue
    var unSelectColor = UIColor.darkGray
    
    open var isSelect = false {
        didSet {
            setSelect(flag: isSelect)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, title: String?, selectColor: UIColor, unSelectColor: UIColor) {
        super.init(frame: frame)
        self.selectColor = selectColor
        self.unSelectColor = unSelectColor
        let rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        titleLabel.frame = rect
        titleLabel.text = title
        titleLabel.textColor = unSelectColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelect(flag: Bool) {
        if flag {
            titleLabel.textColor = selectColor
        }else {
            titleLabel.textColor = unSelectColor
        }
    }
    
}
