//
//  BaseTabbarViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BaseTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white
        
        self.setController()
    }
    
   fileprivate func setController() -> Void {
        let main_my = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        setNavigationPrefrence(vc: main_my, title: "首页", image:"home_all", selImage: "home_all_select")
        let main_task = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "Main_TaskViewController")
        setNavigationPrefrence(vc: main_task, title: "我的任务", image: "home_mine", selImage: "home_mine_select")
        let main_good = Main_GoodManagerViewController()
        setNavigationPrefrence(vc: main_good, title: "货品管理", image:"hadPay_home", selImage: "hadPay_home_select")
        let main_ask = Main_AlreadyAskViewController()
        setNavigationPrefrence(vc: main_ask, title: "已办查询", image:"main_good", selImage: "main_good_select")
    }
    
    fileprivate func setNavigationPrefrence(vc:UIViewController,title:String,image:String,selImage:String) -> Void {
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selImage)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:HexColor.getHex(hexString: "#329AF0", alpha: 1)], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:HexColor.getHex(hexString: "#999999", alpha: 1)], for: .normal)
        self.addChildViewController(BaseNavigationViewController(rootViewController: vc))
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
