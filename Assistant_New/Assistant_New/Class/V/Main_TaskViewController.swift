//
//  Main_TaskViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/27.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class Main_TaskViewController: UIViewController {

    var NaviRight:UIButton?
    var NaviLeft:UIButton?
    var scrollerView:ScrolleTableGroups?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        setView()
    }
    
    func setView() -> Void {
        let titleArray:NSArray = ["全部","发运","收货","交付"]
        let controllerArray:NSArray = ["M_Task_All_Controller","M_Task_ShipController","M_Task_AcceptController","M_Task_PayController"]
        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight - TabFooterHeight)
        let scrollerView = ScrolleTableGroups.init(frame: rect, titleArray: titleArray,controllerArray:controllerArray,superController:self)
        self.scrollerView = scrollerView
        self.view.addSubview(self.scrollerView!)
    }

    
    //MARK: - 设置导航栏
    
    private func setNavi() {
        self.view.backgroundColor = UIColor.white
//        self.title = ""
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = HexColor.getHex(hexString: "#4EAEF6", alpha: 1)
        
        let leftButton = UIButton(frame:CGRect.init(x: 0, y: 0, width: 40, height: 40))
        leftButton.setImage(UIImage.init(named: "Scan QR"), for: UIControlState.normal)
        leftButton.isSelected = true
        leftButton.addTarget(self, action: #selector(pressNaviLeft), for: UIControlEvents.touchUpInside)
        self.NaviLeft = leftButton
        let leftItem = UIBarButtonItem.init(customView: leftButton)
       
        
        let negativeSpace:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = -10
       
        self.navigationItem.leftBarButtonItems = [negativeSpace, leftItem];
        
        
        //MARK: - 这段代码，不起任何作用，但是在有左右导航栏的时候，会将其中间的距离给干掉
        //        let barbritem  = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        //        barbritem.width = -20.0
        //        self.navigationItem.leftBarButtonItems = [rightItem1,barbritem]
        
        let rightBackView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W-80 , height: 28))
        ViewSetCorner.setCornerRadius(corner: (Int(rightBackView.bounds.size.height/2)), view: rightBackView)
        rightBackView.backgroundColor = HexColor.getHex(hexString: "#224D7F", alpha: 0.32)
        let rightButton = UIButton(frame:CGRect.init(x: 20, y: 0, width: rightBackView.bounds.size.width-40, height: 28))
        rightButton.setTitle("搜索运单、订单、箱号、车牌号", for: UIControlState.normal)
        rightButton.setImage(UIImage.init(named: "home_search"), for: UIControlState.normal)
        rightButton.titleLabel?.textColor = HexColor.getHex(hexString: "#FFFFFF", alpha: 0.88)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightButton.isSelected = true
        rightButton.addTarget(self, action: #selector(pressSearch), for: UIControlEvents.touchUpInside)
        rightButton.imageEdgeInsets.right = 10
        rightBackView.addSubview(rightButton)
        let rightItem = UIBarButtonItem.init(customView: rightBackView)
        
        let button = UIButton.init(frame: CGRect.init(x: Int(rightBackView.bounds.size.width - 25), y: 2, width: 24, height: 24))
        button.setImage(UIImage.init(named: "searchBar_delete"), for: .normal)
        button.addTarget(self, action: #selector(pressDelete), for: .touchUpInside)
        rightBackView.addSubview(button)
        
        let negativeSpace_right:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace_right.width = 10
        self.navigationItem.rightBarButtonItems = [negativeSpace_right,rightItem]
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.titleView = UIView()
        self.NaviRight = rightButton
    }
    
   @objc func pressSearch() -> Void {
    let searchController:SearchController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchController") as! SearchController
        searchController.searchBlock = {(code:String) in
            if code.count == 0 {
                self.scrollerView?.SetCodeStr(str: code)
                self.NaviRight?.setTitle("搜索运单、订单、箱号、车牌号", for: UIControlState.normal)
            }else{
                
                if code.hasPrefix("WB") {
                    if YMKJVerificationTools.isWayBillCode(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "运单号不正确", timer: 1)
                        return
                    }
                }else if code.hasPrefix("D") {
                    if YMKJVerificationTools.isOrderBillCode(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "批次号输入不正确", timer: 1)
                        return
                    }
        
                }else if code.count == 7 {
                    if YMKJVerificationTools.isCarNo(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "运车底号、挂车号不正确", timer: 1)
                        return
                    }
                }else if code.count == 11 {
                    if YMKJVerificationTools.isContainerCode(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "集装箱号不正确", timer: 1)
                        return
                    }
                }else{
                    self.NaviRight?.setTitle(code, for: UIControlState.normal)
                    self.scrollerView?.SetCodeStr(str: code)
                }
                
                
            }
        }
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    
    //MARK: - Action
    
    @objc func pressNaviLeft() -> Void {
        let codeController:ScanViewController = ScanViewController()
        codeController.sacnBlock = {(code:String) in
            if code.count == 0 {
                self.scrollerView?.SetCodeStr(str: code)
                self.NaviRight?.setTitle("搜索运单、订单、箱号、车牌号", for: UIControlState.normal)
            }else{
                
                if code.hasPrefix("WB") {
                    if YMKJVerificationTools.isWayBillCode(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "运单号不正确", timer: 1)
                        return
                    }
                }else if code.count == 7 {
                    if YMKJVerificationTools.isCarNo(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "运车底号、挂车号不正确", timer: 1)
                        return
                    }
                }else if code.count == 11 {
                    if YMKJVerificationTools.isContainerCode(code) {
                        self.NaviRight?.setTitle(code, for: UIControlState.normal)
                        self.scrollerView?.SetCodeStr(str: code)
                        return
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "集装箱号不正确", timer: 1)
                        return
                    }
                }else{
                    self.NaviRight?.setTitle(code, for: UIControlState.normal)
                    self.scrollerView?.SetCodeStr(str: code)
                }
                
                
            }
        }
        self.navigationController?.pushViewController(codeController, animated: true)
    }
    
    @objc func pressDelete() -> Void {
        self.scrollerView?.SetCodeStr(str: "")
        self.NaviRight?.setTitle("搜索运单、订单、箱号、车牌号", for: UIControlState.normal)
    }
}
