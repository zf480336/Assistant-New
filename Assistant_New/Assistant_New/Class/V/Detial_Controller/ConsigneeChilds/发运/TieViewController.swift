//
//  TieViewController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
class TieViewController: BaseChildTableViewController,ButtonClickedDelegate,TieloadDelegate {

    var homeViewModel:HomeViewModel?
    var model:WayBilldetailModel?
    var handleModel:HandleModel?
    var containModelArray:NSMutableArray?
    var stateArray:NSMutableArray?
    
    var hideArray:NSMutableArray?
    
    
    var handleViewModel:HandleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "绑定运单车底号"
        self.NaviRight?.isHidden = true
        self.NaviRight?.setTitle("暂存", for: UIControlState.normal)
        self.tableView.register(UINib.init(nibName: "TieCell", bundle: nil), forCellReuseIdentifier: "TieCell")
        self.tableView.register(UINib.init(nibName: "TieLoadCell", bundle: nil), forCellReuseIdentifier: "TieLoadCell")
        self.tableView.register(UINib.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(UINib.init(nibName: "TieSelectCell", bundle: nil), forCellReuseIdentifier: "TieSelectCell")
//         setViewModel()
        if self.containModelArray?.count == 0 {
            self.autoFooter.setTitle("未有选中的箱子", for: MJRefreshState.idle)
            self.autoFooter.setTitle("未有选中的箱子", for: MJRefreshState.willRefresh)
            self.autoFooter.setTitle("未有选中的箱子", for: MJRefreshState.refreshing)
            self.autoFooter.setTitle("未有选中的箱子", for: MJRefreshState.noMoreData)
            self.tableView.mj_footer = self.autoFooter
        }
        
        self.hideArray = NSMutableArray.init()
        self.stateArray = NSMutableArray.init()
        for (_ , _) in (self.containModelArray?.enumerated())! {
            self.stateArray?.add(false)
        }
        
        
        
        let headView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 32))
        headView.backgroundColor = HexColor.getHex(hexString: "#f8f8f8", alpha: 1)
        headView.textColor = HexColor.getHex(hexString: "#333333", alpha: 1)
        headView.font = UIFont.systemFont(ofSize: 13);
        headView.textAlignment = .center
        headView.text = "批次编号 \(self.model?.parentCode ?? "暂无")"
        self.tableView.tableHeaderView = headView
        
    }

    
    func setViewModel() -> Void {
//        self.navigationController?.popToRootViewController(animated: true)
//        MBProgressHUD.showTipMessage(inWindow: "发运成功", timer: 1)
        let requestArray:NSMutableArray = NSMutableArray.init()

        for (_,value) in (self.containModelArray?.enumerated())! {
            let model:OrderContainer_listModel = value as! OrderContainer_listModel

            let dic:NSMutableDictionary = NSMutableDictionary.init()
            dic.setValue(self.model?.orderId, forKey: "orderId")
            dic.setValue(model.waybillCarrierId, forKey: "waybillCarrierId") //承运id
            dic.setValue(model.car_no, forKey: "transNumber")    //运输工具编号
            dic.setValue(model.container_code, forKey: "containerCode")
            dic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
            dic.setValue(model.billID, forKey: "waybillId")
            dic.setValue(self.model?.goodsName, forKey: "goodsName")
            dic.setValue(self.handleModel?.carNum, forKey: "trainNumber")//始发站车次号
            dic.setValue(self.handleModel?.name, forKey: "deliveryName")  ////运输名称
            dic.setValue(self.handleModel?.startHandModel?.id, forKey: "startEntrepotId")  //起始网点id
            dic.setValue(self.handleModel?.endHandModel?.id, forKey: "endEntrepotId")    //终止网点id
            dic.setValue(self.handleModel?.startTime, forKey: "createTime") //创建时间（可以做开始时间）
            dic.setValue(self.handleModel?.endTime, forKey: "update_time")//结束时间
            requestArray.add(dic)
        }
        self.handleViewModel = HandleViewModel()
        self.handleViewModel?.params.setValue(requestArray, forKey: "bindContainerList")
        self.handleViewModel?.setRequestDic()
        self.handleViewModel?.getBindContainer(dic: (self.handleViewModel?.data)!)
        self.handleViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if isEnd {
                self.navigationController?.popToRootViewController(animated: true)
                MBProgressHUD.showTipMessage(inWindow: "发运成功", timer: 1)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tableView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        if ((self.homeViewModel?.orderdetailListModel?.orderContainerList?.count) != nil) {
//            return (self.homeViewModel?.orderdetailListModel?.orderContainerList?.count)! + 1
//        }else{
//            return 1
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if ((self.homeViewModel?.orderdetailListModel?.orderContainerList?.count) != nil) {
//            if indexPath.section == (self.homeViewModel?.orderdetailListModel?.orderContainerList?.count)! {
//
//                var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//                cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first  as! ButtonCell
//                cell.button.setTitle("确认发货", for: UIControlState.normal)
//                return cell
//            }
//            var cell:TieCell = tableView.dequeueReusableCell(withIdentifier: "TieCell") as! TieCell
//            cell = Bundle.main.loadNibNamed("TieCell", owner: self, options: nil)?.first  as! TieCell
//            cell.OrderContainer_model = self.homeViewModel?.orderdetailListModel?.orderContainerList?[indexPath.section]
//            return cell
//        }else{
//            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first  as! ButtonCell
//            cell.button.setTitle("确认发货", for: UIControlState.normal)
//            return cell
//        }
//    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if ((self.containModelArray?.count) != nil) {
            return (self.containModelArray?.count)!+1
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let model:OrderContainer_listModel = self.containModelArray?[section] as! OrderContainer_listModel
        if section == (self.containModelArray?.count)! {
            return 1
        }else{
             return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == (self.containModelArray?.count)! {
            
            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first  as! ButtonCell
            cell.button.setTitle("确认发货", for: UIControlState.normal)
            cell.clickDelegate = self
            return cell
        }
        if indexPath.row == 0 {
            var cell:TieCell = tableView.dequeueReusableCell(withIdentifier: "TieCell") as! TieCell
            cell = Bundle.main.loadNibNamed("TieCell", owner: self, options: nil)?.first  as! TieCell
            cell.OrderContainer_model = self.containModelArray?[indexPath.section]
            
            return cell
        }else if indexPath.row == 2{
            var cell:TieLoadCell = tableView.dequeueReusableCell(withIdentifier: "TieLoadCell") as! TieLoadCell
            cell = Bundle.main.loadNibNamed("TieLoadCell", owner: self, options: nil)?.first  as! TieLoadCell
            cell.tieloadDelegate = self
            cell.OrderContainer_model = self.containModelArray?[indexPath.section]
            cell.isLoad = (self.stateArray?[indexPath.section] as! Bool)
            return cell
        }else{
            var cell:TieSelectCell = tableView.dequeueReusableCell(withIdentifier: "TieSelectCell") as! TieSelectCell
            cell = Bundle.main.loadNibNamed("TieSelectCell", owner: self, options: nil)?.first  as! TieSelectCell
//            cell.OrderContainer_model = self.containModelArray?[indexPath.section]
//            cell.isLoad = (self.stateArray?[indexPath.section] as! Bool)
            cell.OrderContainer_model = self.containModelArray?[indexPath.section]
            return cell
        }
        
    }
    
    
    
    //MARK: - ACtion
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row != 1 {
            return
        }
        
        for (_ ,value) in (self.containModelArray?.enumerated())!{
            
            let model:OrderContainer_listModel = value as! OrderContainer_listModel
            if model.billID != nil && model.billID != "" {
                self.hideArray?.add(model)
            }
        }
        
        let model:OrderContainer_listModel = self.containModelArray?[indexPath.section] as! OrderContainer_listModel
        let controller:TieDetailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TieDetailController") as! TieDetailController
        controller.model = self.model
        if (self.hideArray?.count)! > 0 {
             controller.hideArr = self.hideArray
        }
        controller.billBlock = {(billmodel:billModel) in
            model.billID = billmodel.waybill_id
            model.billCode = billmodel.waybill_code
            model.waybillCarrierId = billmodel.waybillCarrierId
            self.tableView.reloadData()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
   
    func buttoClickedAction() { 
        
        for (_ ,value) in (self.containModelArray?.enumerated())!{
            let model:OrderContainer_listModel = value as! OrderContainer_listModel
            if model.car_no == nil || model.car_no == ""{
                MBProgressHUD.showTipMessage(inWindow: "有未绑定的车底号", timer: 1)
                return
            }
            if model.billID == nil || model.billID == ""{
                MBProgressHUD.showTipMessage(inWindow: "有未绑定的运单号", timer: 1)
                return
            }
        }
        
        //FIXME: 传数据请求发运接口
        
        setViewModel()
        
    }
    //MARK: - TieLoadDelegate
    func refreshTableView() {
        self.tableView.reloadData()
    }

}
