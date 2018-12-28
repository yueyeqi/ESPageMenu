//
//  ViewController.swift
//  ESPageMenuDemo
//
//  Created by payne on 2018/12/28.
//  Copyright © 2018 payne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIViewController()
        vc1.title = "1"
        vc1.view.backgroundColor = UIColor.red
        
        let vc2 = UIViewController()
        vc2.title = "2"
        vc2.view.backgroundColor = UIColor.blue
        
        let vc3 = UIViewController()
        vc3.title = "3"
        vc3.view.backgroundColor = UIColor.green
        
        let vcArray = [vc1, vc2, vc3]
        
        let page = ESPageMenu(frame: view.frame)
        page.selectColor = UIColor.red
        page.viewControllers = vcArray
        page.hostController = self
        
        view.addSubview(page)
        
    }


}

