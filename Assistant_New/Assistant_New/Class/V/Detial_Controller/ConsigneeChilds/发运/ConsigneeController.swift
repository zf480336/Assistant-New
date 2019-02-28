//
//  ConsigneeController.swift
//  Assistant
//
//  Created by lxy on 2018/11/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class ConsigneeController: BaseChildTableViewController,ButtonClickedDelegate,BoxCellDelegate {

    var homeViewModel:HomeViewModel?
    var detailModel:Any?
    var selectArray:NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发运详情"

        self.tableView.estimatedRowHeight = 200.0  //MAX
        self.tableView.register(UINib.init(nibName: "Order_Address_Cell", bundle: nil), forCellReuseIdentifier: "Order_Address_Cell")
        self.tableView.register(UINib.init(nibName: "BatchCell", bundle: nil), forCellReuseIdentifier: "BatchCell")
        self.tableView.register(UINib.init(nibName: "AddressInfoCell", bundle: nil), forCellReuseIdentifier: "AddressInfoCell")
        self.tableView.register(UINib.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(UINib.init(nibName: "BoxCell", bundle: nil), forCellReuseIdentifier: "BoxCell")
        self.selectArray = NSMutableArray.init()
        setViewModel()
    
    }

    func setViewModel() -> Void {
        self.homeViewModel = HomeViewModel.init()
        self.homeViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        let model:detailModel = self.detailModel as! detailModel
        self.homeViewModel?.params.setValue(model.waybillId, forKey: "waybillId")
        self.homeViewModel?.setRequestDic()
        self.homeViewModel?.getRunningDetailTask(dic: (self.homeViewModel?.data)!,wayBillStatus: model.waybillStatus!)
        self.homeViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
//        for (_ ,value) in (self.selectArray?.enumerated())! {
//            let model = value as! OrderContainer_listModel
//            model.isSelect = false
//        }
        //FIXME: 发一个通知
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        if ((self.homeViewModel?.orderdetailListModel?.orderContainerList?.count) != nil) {
//            return 4+(self.homeViewModel?.orderdetailListModel?.orderContainerList?.count)!
//        }else{
//            return 4
//        }
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if ((self.homeViewModel?.orderdetailListModel?.containerList?.count) != nil) {
            return 4+(self.homeViewModel?.orderdetailListModel?.containerList?.count)!
        }else{
            return 4
        }
//        if ((self.data?.count) != nil) {
//            return 4+(self.data?.count)!
//        }else{
//            return 4
//        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            
            var cell:Order_Address_Cell = tableView.dequeueReusableCell(withIdentifier: "Order_Address_Cell") as! Order_Address_Cell
            cell = Bundle.main.loadNibNamed("Order_Address_Cell", owner: self, options: nil)?.first as! Order_Address_Cell
            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
            return cell
            
        }else if indexPath.section == 1{
            
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as! BatchCell
            cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
            return cell
            
        }else if indexPath.section == 2{
            
            var cell:AddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell") as! AddressInfoCell
            cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first  as! AddressInfoCell
            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
            return cell
            
        }else{
            if ((self.homeViewModel?.orderdetailListModel?.containerList?.count) != nil) {
                if (indexPath.section == 3+(self.homeViewModel?.orderdetailListModel?.containerList?.count)!){
                    var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
                    cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
                    cell.clickDelegate = self
                    return cell
                }else{
                    let containModel = self.homeViewModel?.orderdetailListModel?.containerList![indexPath.section-3]
                    var cell:BoxCell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! BoxCell
                    cell = Bundle.main.loadNibNamed("BoxCell", owner: self, options: nil)?.first as? UITableViewCell as! BoxCell
                    cell.model = containModel
                    cell.setModelAndSection(section: indexPath.section)
                    cell.boxDelegate = self
                    return cell
                }

            }else{
                var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
                cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
                cell.clickDelegate = self
                return cell
            }
//            if ((self.data?.count) != nil) {
//                if (indexPath.section == 3+(self.data?.count)!){
//                    var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//                    cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
//                    cell.clickDelegate = self
//                    return cell
//                }else{
//                    let containModel = self.data![indexPath.section-3]
//                    var cell:BoxCell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! BoxCell
//                    cell = Bundle.main.loadNibNamed("BoxCell", owner: self, options: nil)?.first as? UITableViewCell as! BoxCell
//                    cell.model = containModel
//                    cell.setModelAndSection(section: indexPath.section)
//                    cell.boxDelegate = self
//                    return cell
//                }
//
//            }else{
//                var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//                cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
//                cell.clickDelegate = self
//                return cell
//            }
        }
    }

    
    //MARK: - Action
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 2 && indexPath.section < 3+(self.homeViewModel?.orderdetailListModel?.containerList?.count)!{
//            let box = BoxGoodsController.init(style: UITableViewStyle.plain)
//            box.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
//            self.navigationController?.pushViewController(box, animated: true)
            let containModel = self.homeViewModel?.orderdetailListModel?.containerList![indexPath.section-3]
            
            if containModel?.waybilId != nil {
                return
            }
            
            containModel?.isSelect = !(containModel?.isSelect)!
            if (containModel?.isSelect)! {
                self.selectArray?.add(containModel as Any)
            }else{
                self.selectArray?.remove(containModel as Any)
            }
            self.tableView.reloadData()
        }
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section > 2 && indexPath.section < 3+(self.data?.count)!{
//            //            let box = BoxGoodsController.init(style: UITableViewStyle.plain)
//            //            box.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
//            //            self.navigationController?.pushViewController(box, animated: true)
//            let containModel:OrderContainer_listModel = self.data![indexPath.section-3] as! OrderContainer_listModel
//            containModel.isSelect = !(containModel.isSelect)
//            if (containModel.isSelect) {
//                self.selectArray?.add(containModel as Any)
//            }else{
//                self.selectArray?.remove(containModel as Any)
//            }
//            self.tableView.reloadData()
//        }
//    }

    
    //发运Action
    func buttoClickedAction() {
        print("iOS-Swift开发")
        
        if self.selectArray?.count == 0 {
            MBProgressHUD.showTipMessage(inWindow: "请选择要发运的箱子", timer: 1)
            return
        }
        
        let controller:HandleShipController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HandleShipController") as! HandleShipController
        controller.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
        let resultArray:NSMutableArray = NSMutableArray.init()
        for (_ ,value) in (self.selectArray?.enumerated())! {
            let containModel = value as! OrderContainer_listModel
            resultArray.add(containModel.copy())
        }
        controller.containModelArray = resultArray
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //BoxCellDelegate
    func selectBoxCell(section: Int) {
        let box = BoxGoodsController.init(style: UITableViewStyle.plain)
        let containModel = self.homeViewModel?.orderdetailListModel?.containerList![section-3]
        box.boxModel = containModel
        if containModel?.waybilId != nil {
            box.isNaviHiden = true
        }
        self.navigationController?.pushViewController(box, animated: true)
    }

}
