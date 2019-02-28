//
//  AlreadyDetailController.swift
//  Assistant
//
//  Created by lxy on 2018/12/3.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class AlreadyDetailController: BaseAlreadyChildController {

    
    var alreadyModel:Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "任务详情"
        self.tableView.mj_header = nil
        self.tableView.mj_footer = nil
        self.tableView.register(UINib.init(nibName: "Order_Address_Cell", bundle: nil), forCellReuseIdentifier: "Order_Address_Cell")
        self.tableView.register(UINib.init(nibName: "BatchCell", bundle: nil), forCellReuseIdentifier: "BatchCell")
        self.tableView.register(UINib.init(nibName: "AddressInfoCell", bundle: nil), forCellReuseIdentifier: "AddressInfoCell")
        self.tableView.register(UINib.init(nibName: "AlredyDetailbetchCell", bundle: nil), forCellReuseIdentifier: "AlredyDetailbetchCell")
        
        setViewModel()
        
    }
    
//    override func setViewModel() -> Void {
//        self.alreadyViewModel = AlreadyViewModel.init()
//        self.alreadyViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
//        let model:alreadyModel = self.alreadyModel as! alreadyModel
//        self.alreadyViewModel?.params.setValue(model.waybill_id
//            , forKey: "waybillId")
//        self.alreadyViewModel?.setRequestDic()
//        self.alreadyViewModel?.getRunningDetailTask(dic: (self.alreadyViewModel?.data)!)
//        self.alreadyViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
//            self.tableView.reloadData()
//        }
//    }
    
    override func setViewModel() -> Void {
        self.alreadyViewModel = AlreadyViewModel.init()
        self.alreadyViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        let model:alreadyModel = self.alreadyModel as! alreadyModel
        self.alreadyViewModel?.params.setValue(model.waybill_id, forKey: "waybillId")
        self.alreadyViewModel?.setRequestDic()
        self.alreadyViewModel?.getRunningDetailTask(dic: (self.alreadyViewModel?.data)!,wayBillStatus: "3")
        self.alreadyViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if ((self.alreadyViewModel?.orderdetailListModel?.containerList?.count) != nil) {
            return 3+(self.alreadyViewModel?.orderdetailListModel?.containerList?.count)!
        }else{
            return 3
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell:Order_Address_Cell = tableView.dequeueReusableCell(withIdentifier: "Order_Address_Cell") as! Order_Address_Cell
            cell = Bundle.main.loadNibNamed("Order_Address_Cell", owner: self, options: nil)?.first as! Order_Address_Cell
            cell.model = self.alreadyViewModel?.taskDetailModel?.taskDetailsask
            return cell
        }else if indexPath.section == 1{
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as! BatchCell
            if indexPath.section == 1{
                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
                cell.model = self.alreadyViewModel?.taskDetailModel?.taskDetailsask
            }else{
                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_CarInfo)
                cell.lineNameModel = self.alreadyViewModel?.linaNameModel?.containerOperation
            }
            return cell
        }else{
            
            if ((self.alreadyViewModel?.orderdetailListModel?.containerList?.count) != nil) {
                
                if indexPath.section == 2 {
                    var cell:AddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell") as! AddressInfoCell
                    cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first  as! AddressInfoCell
                    cell.model = self.alreadyViewModel?.taskDetailModel?.taskDetailsask
                    return cell
                }else{
                    var cell:AlredyDetailbetchCell = tableView.dequeueReusableCell(withIdentifier: "AlredyDetailbetchCell") as! AlredyDetailbetchCell
                    cell = Bundle.main.loadNibNamed("AlredyDetailbetchCell", owner: self, options: nil)?.first as! AlredyDetailbetchCell
                    cell.orderContainer_listModel = self.alreadyViewModel?.orderdetailListModel?.containerList![indexPath.section - 3]
                    cell.selectBtn.isHidden = true
                    cell.backView.backgroundColor = UIColor.white
                    return cell
                }
                
            }else{
                var cell:AddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell") as! AddressInfoCell
                cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first  as! AddressInfoCell
                cell.model = self.alreadyViewModel?.taskDetailModel?.taskDetailsask
                return cell
            }
        }
    }
    
    
    //MARK: - Action
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 2  {
            let box = BoxGoodsController.init(style: UITableViewStyle.plain)
            let containModel:OrderContainer_listModel = self.alreadyViewModel?.dataArray[indexPath.section - 3] as! OrderContainer_listModel
            box.boxModel = containModel
            box.isNaviHiden = true
            
            self.navigationController?.pushViewController(box, animated: true)
        }
    }
    

}
