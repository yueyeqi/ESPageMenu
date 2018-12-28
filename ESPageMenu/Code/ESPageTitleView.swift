//
//  ESPageTitleView.swift
//
//  Created by payne on 2018/12/21.
//  Copyright © 2018 payne. All rights reserved.
//

import UIKit

class ESPageTitleView: UIView {

    var titleLabel = UILabel()
    open var isSelect = false {
        didSet {
            setSelect(flag: isSelect)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, title: String?) {
        super.init(frame: frame)
        let rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        titleLabel.frame = rect
        titleLabel.text = title
        titleLabel.setLabelColorAndFont(color: UIColor.darkGray, size: 16)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelect(flag: Bool) {
        if flag {
            titleLabel.textColor = ColorBlue
        }else {
            titleLabel.textColor = UIColor.darkGray
        }
    }
    
}
