//
//  Main_GoodManagerViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
//货品管理
class Main_GoodManagerViewController: Main_TaskViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
    }

    override func setView() -> Void {
        let titleArray:NSArray = ["全部","待收","已收"]
        let controllerArray:NSArray = ["M_GoodsALlController","M_GoodWaitController","M_GoodHadController"]
        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight - TabFooterHeight)
        let scrollerView = ScrolleTableGroups.init(frame: rect, titleArray: titleArray,controllerArray:controllerArray,superController:self)
        self.scrollerView = scrollerView
        self.view.addSubview(scrollerView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
