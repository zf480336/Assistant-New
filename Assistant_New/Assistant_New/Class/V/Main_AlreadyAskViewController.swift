//
//  Main_AlreadyAskViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
//已办查询
class Main_AlreadyAskViewController: Main_TaskViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//        let rightItem = UIBarButtonItem.init(customView: UIView.init())
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.titleView = nil
        self.NaviLeft?.isHidden = true
        self.title = "已办查询"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setView() -> Void {
        let titleArray:NSArray = ["全部","在途","已抵达","已交付"]
        let controllerArray:NSArray = ["M_AlreadAllController","M_AlreadOnLoadController","M_AlreadArriveController","M_AlreadPayController"]
        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight - TabFooterHeight)
        let scrollerView = ScrolleTableGroups.init(frame: rect, titleArray: titleArray,controllerArray:controllerArray,superController:self)
        self.scrollerView = scrollerView
        self.view.addSubview(scrollerView)
    }
}
