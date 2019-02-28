//
//  BaseViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
class BaseViewController: UIViewController {
    
    var leftButton:UIButton?
    var NaviRight:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        
        self.leftButton = UIButton()
        self.leftButton?.frame = CGRect.init(x: 0, y: 0, width: 80, height: 40)
        self.leftButton?.setImage(UIImage.init(named: "naviBack"), for: UIControlState.normal)
        self.leftButton?.isSelected = true
        self.leftButton?.imageEdgeInsets.left = -55
        self.leftButton?.addTarget(self, action: #selector(pressNaviLeft), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem.init(customView:  self.leftButton!)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightButton = UIButton(frame:CGRect.init(x: 0, y: 0, width: 40, height: 40))
        rightButton.setTitle("", for: UIControlState.normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        rightButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightButton.addTarget(self, action: #selector(pressNaviRight), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightItem
        self.NaviRight = rightButton
        self.NaviRight?.isHidden = true

    }

    
//    override func viewDidLayoutSubviews() {
//        if #available(iOS 11.0.0, *) {
//            let item = self.navigationItem
//            let array = item.leftBarButtonItems
//            if ((array != nil) && ((array?.count)! > 0)) {
//                let bbbitem = array![0]
//                let view = bbbitem.customView?.superview?.superview?.superview
//                let arrCOnstraint = view?.constraints
//                for  content in arrCOnstraint!{
//                    if(content.constant == 16){
//                        content.constant = 0
//                    }
//                }
//            }
//        }else{
//            print("iOS 9.3.5 is available")
//        }
//    }
    
    @objc func pressNaviLeft(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressNaviRight(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
