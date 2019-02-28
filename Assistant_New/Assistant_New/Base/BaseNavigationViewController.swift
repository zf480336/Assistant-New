//
//  BaseNavigationViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //更改导航栏字体
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)]
        self.interactivePopGestureRecognizer?.delegate = (self as! UIGestureRecognizerDelegate)
        self.navigationBar.barTintColor = HexColor.getHex(hexString: "#4EAEF6", alpha: 1)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //去掉导航栏下边线
        self.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage.init()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //去掉导航栏下边线
        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationBar.shadowImage = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
