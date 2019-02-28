//
//  ConfirmAcceptController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class ConfirmAcceptController: ConfirmPayController,selectDelegate {

    var model:WayBilldetailModel?
    var homeViewModel:HomeViewModel?
    var handleViewModel:HandleViewModel?
    
    lazy var headView:SelectView = {
        let view:SelectView = Bundle.main.loadNibNamed("SelectView", owner: self, options: nil)?.first as! SelectView
        view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 60)
        view.selectDelegate = self
        view.backgroundColor = HexColor.getHex(hexString: "#f8f8f8", alpha: 1)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.model?.statusName == "待交付" {
            
            self.NaviRight?.setTitle("批量交付", for: UIControlState.normal)
        }else{
            self.NaviRight?.setTitle("批量收货", for: UIControlState.normal)
        }
        self.tableView.backgroundColor = UIColor.white
        setViewModel()
        self.handleViewModel = HandleViewModel()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    func setViewModel() -> Void {
        self.homeViewModel = HomeViewModel.init()
        self.homeViewModel?.params.setValue("1", forKey: "status")
        self.homeViewModel?.params.setValue(self.model?.orderId, forKey: "orderId")
        self.homeViewModel?.setRequestDic()
        self.homeViewModel?.getOrderContainerList(dic: (self.homeViewModel?.data)!,curtenIndex: 0)
        self.homeViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if array.count == 0 {
                self.mj_footer.setTitle("暂无数据", for: .idle)
                self.mj_footer.setTitle("暂无数据", for: .willRefresh)
                self.mj_footer.setTitle("暂无数据", for: .refreshing)
                self.mj_footer.setTitle("暂无数据", for: .noMoreData)
                self.tableView.mj_footer = self.mj_footer
            }else{
                self.tableView.mj_footer = nil
            }
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.homeViewModel?.orderdetailListModel?.containerList == nil {
            return 0
        }
        
        return (self.homeViewModel?.orderdetailListModel?.containerList?.count)!+1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == self.homeViewModel?.orderdetailListModel?.containerList?.count {
            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
            cell.clickDelegate = self
            if self.model?.statusName == "待交付" {
                cell.button.setTitle("确认交付", for: UIControlState.normal)
            }else{
                cell.button.setTitle("确认收货", for: UIControlState.normal)
            }
            
            return cell
        }else{
            var cell:AlredyDetailbetchCell = tableView.dequeueReusableCell(withIdentifier: "AlredyDetailbetchCell") as! AlredyDetailbetchCell
            cell = Bundle.main.loadNibNamed("AlredyDetailbetchCell", owner: self, options: nil)?.first as! AlredyDetailbetchCell
            cell.orderContainer_listModel = self.homeViewModel?.orderdetailListModel?.containerList![indexPath.section]
            if self.isChoose! {
                cell.selectBtn.isHidden  = false
            }else{
                cell.selectBtn.isHidden  = true
            }
            return cell
        }
    }
    
    
    
    //MARK: - Action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == self.homeViewModel?.orderdetailListModel?.containerList?.count {
            return
        }
        let model:OrderContainer_listModel = (self.homeViewModel?.orderdetailListModel?.containerList?[indexPath.section])!
        
        if self.isChoose == true {
            model.isSelect = !model.isSelect
            if model.isSelect == true {
                self.selectArray.add(model)
            }else{
                self.selectArray.remove(model)
            }
            self.tableView.reloadData()
        }else{
            let box = BoxGoodsController.init(style: UITableViewStyle.plain)
            let containModel:OrderContainer_listModel = self.homeViewModel?.dataArray[indexPath.section] as! OrderContainer_listModel
            box.boxModel = containModel
            
            self.navigationController?.pushViewController(box, animated: true)
        }
    }
    
    
    
    override func pressNaviRight() {
        self.isChoose = !self.isChoose!
        self.tableView.reloadData()
        if self.isChoose! {
            self.NaviRight?.setTitle("取消选择", for: UIControlState.normal)
            self.tableView.tableHeaderView = self.headView
        }else{
            self.NaviRight?.setTitle("批量收货", for: UIControlState.normal)
            self.headView.setOriginStatus()
            self.tableView.tableHeaderView = nil
            for (_,value) in self.selectArray.enumerated() {
                let model = value as! OrderContainer_listModel
                model.isSelect = false
            }
            self.selectArray.removeAllObjects()
        }
    }
    
    
    
    //MARK: - headVIewDelegate方法
    func pressSelect(ret: Bool) {
        if ret {  //取消选中
            for (_, value) in self.selectArray.enumerated() {
                let model = value as! OrderContainer_listModel
                model.isSelect = false
            }
            self.selectArray.removeAllObjects()
        }else{ //全选
            for (_, value) in (self.self.homeViewModel?.dataArray.enumerated())! {
                let model = value as! OrderContainer_listModel
                model.isSelect = true
                self.selectArray.add(model)
            }
        }
        self.tableView.reloadData()
    }
    
    
    override func buttoClickedAction() {
        
        if self.selectArray.count == 0 {
            MBProgressHUD.showTipMessage(inWindow: "请选取要操作的箱子", timer: 1)
            return
        }
        let wayBillIdArray:NSMutableArray = NSMutableArray.init()
        
        for (_,value) in self.selectArray.enumerated() {
            let model = value as! OrderContainer_listModel
            wayBillIdArray.add(model.waybilId as Any)
        }
        
        if self.model?.statusName == "待交付" {
            //FIXME: 请求交付接口
            self.handleViewModel?.params.setValue(wayBillIdArray, forKey: "waybillIdList")
            self.handleViewModel?.params.setValue(self.model?.orderId, forKey: "orderId")
            self.handleViewModel?.params.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
            self.handleViewModel?.setRequestDic()
            self.handleViewModel?.getFinishWaybill(dic: (self.handleViewModel?.data)!)
            self.handleViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                if isEnd {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
        }else{
            //FIXME: 请求收货接口
            self.handleViewModel?.params.setValue(wayBillIdArray, forKey: "waybillIdList")
//            self.handleViewModel?.params.setValue(self.model?.orderId, forKey: "orderid,")
//            self.handleViewModel?.params.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
            self.handleViewModel?.setRequestDic()
            self.handleViewModel?.getReceiveWaybill(dic: (self.handleViewModel?.data)!)
            self.handleViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                if isEnd {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
//        self.navigationController?.popToRootViewController(animated: true)
    }
}

