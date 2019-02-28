//
//  ScrolleTableGroups.swift
//  Assistant
//
//  Created by lxy on 2018/11/28.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class ScrolleTableGroups: UIView,UIScrollViewDelegate {

    let topScrollHeight = 50 //顶部视图高度
    let font:Int = 16  //默认顶部视图按钮字体
    let count:Int  //顶部按钮总个数
    var curttenIndex:Int //当前索引
    var controllerArrays:NSMutableArray = NSMutableArray.init()
    var codeString:String?
    
    
    var curButton:UIButton = UIButton()  //记录当前位置按钮
    
    //初始化需要的东西
    let titleArray:NSArray?
    var curttenFrame:CGRect?
    let controllerArray:NSArray?
    
    //当前UI
    var scrollerTitleView:UIScrollView = UIScrollView()
    var scrollerTableView:UIScrollView = UIScrollView()
    var topScrollLabel:UILabel?  //下划线
    
    var superController:UIViewController? //添加当前对象的控制器对象
    
    //MARK: - 初始化
    init(frame: CGRect,titleArray:NSArray,controllerArray:NSArray,superController:UIViewController) {
        self.titleArray = titleArray
        self.curttenFrame = frame
        self.count = titleArray.count
        self.curttenIndex = 0
        self.controllerArray = controllerArray
        self.superController = superController
        super.init(frame: frame)
        
        setTitleView()
        setTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action事件
    
    //ScrollerVIew代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.topScrollLabel?.frame.origin.x = scrollView.contentOffset.x/(CGFloat)(count)+(CGFloat)(SCREEN_W/count/2-30)
        
//        let button:UIButton = self.viewWithTag(self.curttenIndex+1) as! UIButton

    }
    //ScrollView停止滚动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.curttenIndex = (Int)(scrollView.contentOffset.x)/SCREEN_W
        let button:UIButton = self.viewWithTag(self.curttenIndex+1) as! UIButton
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        self.curButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(self.font))
        self.curButton = button
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        let controller = self.superController?.childViewControllers[self.curttenIndex] as! BaseTableViewController
        controller.code = self.codeString
        if controller.isRefresh {
            
        }else{
            controller.tableView.mj_header.beginRefreshing()
        }
    }
    
    //MARK: - 顶部视图按钮点击事件
    @objc func onTopButtonClick(button:UIButton) -> Void {
        printLog(message: button.tag)
        if button.tag == self.curttenIndex+1 {
            return;
        }
        self.curttenIndex = button.tag - 1
        self.curButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(self.font))
        self.curButton = button
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        UIView.animate(withDuration: 0.5) {
            self.scrollerTableView.contentOffset.x = CGFloat((self.curttenIndex)*SCREEN_W)
        }
        let controller = self.superController?.childViewControllers[self.curttenIndex] as! BaseTableViewController
        controller.code = self.codeString
        if controller.isRefresh {
            
        }else{
             controller.tableView.mj_header.beginRefreshing()
        }
       
    }
    
    
    //MARK: - 设置UI
    private func setTitleView() -> Void {
        
        self.scrollerTitleView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: topScrollHeight)
        self.scrollerTitleView.backgroundColor = HexColor.getHex(hexString: "#4EAEF6", alpha: 1)
        self.scrollerTitleView.bounces = false
        self.scrollerTitleView.contentSize = CGSize.init(width: SCREEN_W, height: topScrollHeight)
        
        self.topScrollLabel = UILabel.init(frame: CGRect.init(x: SCREEN_W/count/2-30, y: topScrollHeight-12, width: 60, height: 4))
        self.topScrollLabel?.backgroundColor = UIColor.white
        self.topScrollLabel?.textAlignment = NSTextAlignment.center
        ViewSetCorner.setCornerRadius(corner: 2, view: self.topScrollLabel!)
//        self.topScrollLabel?.text = self.titleArray?[self.curttenIndex] as? String
        
        for i in stride(from: 0, to: count, by: 1){
            if (i < count){
                let button = UIButton.init(frame: CGRect.init(x: i*SCREEN_W/count, y: 0, width: SCREEN_W/count, height: topScrollHeight-12))
                button.setTitle(titleArray?[i] as? String, for: UIControlState.normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(self.font))
                button.addTarget(self, action: #selector(onTopButtonClick(button:)), for: UIControlEvents.touchUpInside)
                button.tag = i+1
                if(i == 0){
                    self.curButton = button
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
                }
                button.setTitleColor(HexColor.getHex(hexString: "#FFFFFF", alpha: 1), for: UIControlState.normal)
                self.scrollerTitleView.addSubview(button)
                
            }
        }
        self.scrollerTitleView.addSubview(self.topScrollLabel!)
        self.addSubview(self.scrollerTitleView)
    }
    
    private func setTableView() -> Void {
        
        self.scrollerTableView.frame = CGRect.init(x: 0, y: topScrollHeight, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight - TabFooterHeight - topScrollHeight)
        self.scrollerTableView.backgroundColor = UIColor.white
        self.scrollerTableView.showsHorizontalScrollIndicator = false
        self.scrollerTableView.delegate = self
        self.scrollerTableView.bounces = false
        self.scrollerTableView.isPagingEnabled = true
        
        self.scrollerTableView.contentSize = CGSize.init(width: SCREEN_W * self.count, height: SCREEN_H - NavHeaderHeight - TabFooterHeight - topScrollHeight)
        for i in stride(from: 0, to: self.count, by: 1){
            if (i < self.count){
                
                //反射，swift的话是带命名空间的
//$(PRODUCT_NAME)
                let controllerName:String = self.controllerArray?[i] as! String
                let controller = NSClassFromString("Assistant_New" + "." + controllerName) as? UITableViewController.Type
                let vc = controller!.init()
                self.superController?.addChildViewController(vc)
                print(vc)
                vc.tableView.frame = CGRect.init(x: i*SCREEN_W, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight - TabFooterHeight - topScrollHeight)
                self.scrollerTableView.addSubview(vc.tableView)
                self.controllerArrays.add(vc)
            }
        }
        self.addSubview(self.scrollerTableView)
    }
    
    func SetCodeStr(str:String) -> Void {
        self.codeString = str
        
//        let controllerName:String = self.controllerArray?[self.curttenIndex] as! String
//        let controllerClass = NSClassFromString(controllerName)
       
        let controller = self.superController?.childViewControllers[self.curttenIndex] as! BaseTableViewController
        controller.code = str
        controller.isRefresh = false
        if controller.isRefresh {
        }else{
            controller.tableView.mj_header.beginRefreshing()
        }
    }
    
}
