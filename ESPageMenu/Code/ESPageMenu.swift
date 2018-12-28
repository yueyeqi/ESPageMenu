//
//  ESPageMenu.swift
//
//  Created by payne on 2018/12/21.
//  Copyright © 2018 payne. All rights reserved.
//

import UIKit

extension UIViewController {
    //动态给VC添加一个index属性
    private struct RuntimeKey {
        static let indexKey = UnsafeRawPointer.init(bitPattern: "indexKey".hashValue)
    }
    public var index: Int {
        set {
            objc_setAssociatedObject(self, RuntimeKey.indexKey!,  NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  (objc_getAssociatedObject(self, RuntimeKey.indexKey!) as! NSNumber).intValue
        }
    }
}

class ESPageMenu: UIView {
//MARK: - 公开属性
    //数据源
    open var viewControllers = [UIViewController]() {
        didSet {
           setMenu()
        }
    }
    //当前索引
    open var selectIndex = 0
    //当前主VC
    open var hostController: UIViewController?
    //背景颜色
    open var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
//MARK: - 私有属性
    //回调闭包
    private var clickClusre: ((_ index: Int) -> ())?
    //标题View数据源
    private var titleViewArray = [ESPageTitleView]()
    //下滑线
    private var selectLine = UIView()
    //pageView
    private var pageView: ESPageContentView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.groupTableViewBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMenu() {
        for (idx, vc) in viewControllers.enumerated() {
            vc.index = idx
            let x = idx * (Int(ScreenW) / viewControllers.count)
            let rect = CGRect(x: CGFloat(x), y: 0, width: ScreenW / CGFloat(viewControllers.count), height: 50)
            let pageTitleView = ESPageTitleView(frame: rect, title: vc.title)
            pageTitleView.tag = idx
            let ges = UITapGestureRecognizer(target: self, action: #selector(clickAct(tap:)))
            pageTitleView.addGestureRecognizer(ges)
            titleViewArray.append(pageTitleView)
            addSubview(pageTitleView)
            changeIndex(index: 0)
        }
        let lineRect = CGRect(x: 20, y: 48, width: (ScreenW / CGFloat(viewControllers.count)) - 40, height: 2)
        selectLine.frame = lineRect
        selectLine.backgroundColor = ColorBlue
        addSubview(selectLine)
        
        let pageRect = CGRect(x: 0, y: 50, width: frame.width, height: frame.height - 50)
        pageView = ESPageContentView(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageView!.view.frame = pageRect
        pageView!.delegate = self
        pageView!.dataSource = self
        hostController?.addChild(pageView!)
        addSubview(pageView!.view)
        pageView!.setViewControllers([viewControllers.first!], direction: .reverse, animated: false, completion: nil)
    }
    
    @objc private func clickAct(tap: UIGestureRecognizer) {
        changeIndex(index: (tap.view?.tag)!)
        if let closure = clickClusre {
            closure(selectIndex)
        }
    }
    
    //索引改变
    private func changeIndex(index: Int) {
        
        //判断索引是否越界
        if index >= viewControllers.count {
            //如果下标越界，则替换成数据源最后一个
            selectIndex = viewControllers.count - 1
        }
        
        //判断是否和当前index一样
        if index == selectIndex {
            return
        }else {
            for (idx, subView) in titleViewArray.enumerated() {
                if idx == index {
                    subView.isSelect = true
                }else {
                    subView.isSelect = false
                }
            }
            
            //动画 下横线移动
            weak var weakSelf = self
            UIView.animate(withDuration: 0.2) {
                let newX: CGFloat = (ScreenW / CGFloat(weakSelf!.viewControllers.count)) * CGFloat(index) + 20
                let newRect = CGRect(x: newX, y: weakSelf!.selectLine.frame.origin.y, width: weakSelf!.selectLine.frame.width, height: 2)
                weakSelf!.selectLine.frame = newRect
            }
            
            if index > selectIndex {
                pageView?.setViewControllers([viewControllers[index]], direction: .forward, animated: true, completion: nil)
            }else {
                pageView?.setViewControllers([viewControllers[index]], direction: .reverse, animated: true, completion: nil)
            }
            selectIndex = index
        }
    }
    
    //点击事件回调
    func clickIndexClosure(_ closure: @escaping(_ index: Int) -> Void) {
        clickClusre = closure
    }
    
}

extension ESPageMenu: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewController.index
        changeIndex(index: currentIndex)
        if currentIndex == 0 {
            return nil
        }
        let controller = viewControllers[currentIndex - 1]
        controller.index = currentIndex - 1
        return controller
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewController.index
        changeIndex(index: currentIndex)
        if currentIndex == viewControllers.count - 1 {
            return nil
        }
        let ctl = viewControllers[currentIndex + 1]
        ctl.index = currentIndex + 1
        return ctl
    }

}


