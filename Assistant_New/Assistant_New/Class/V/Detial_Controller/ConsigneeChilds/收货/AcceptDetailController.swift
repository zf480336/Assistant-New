//
//  AcceptDetailController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class AcceptDetailController: ConsigneeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "收货详情"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
//            var cell:Order_Address_Cell = tableView.dequeueReusableCell(withIdentifier: "Order_Address_Cell") as! Order_Address_Cell
//            cell = Bundle.main.loadNibNamed("Order_Address_Cell", owner: self, options: nil)?.first as! Order_Address_Cell
//            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
//            return cell
//        }else if indexPath.section == 1 || indexPath.section == 3{
//            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
//            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as! BatchCell
//            if indexPath.section == 1{
//                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
//                cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
//            }else{
//                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_CarInfo)
//                cell.lineNameModel = self.homeViewModel?.linaNameModel?.containerOperation
//            }
//            return cell
//        }else if indexPath.section == 2{
//            var cell:AddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell") as! AddressInfoCell
//            cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first  as! AddressInfoCell
//            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
//            return cell
//        }else{
//            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
//            cell.clickDelegate = self
//            if self.homeViewModel?.taskDetailModel?.taskDetailsask?.statusName == "待交付" {
//                cell.button.setTitle("办理交付", for: UIControlState.normal)
//            }else{
//                cell.button.setTitle("办理收货", for: UIControlState.normal)
//            }
//            return cell
//        }
        if indexPath.section == 0 {
            var cell:Order_Address_Cell = tableView.dequeueReusableCell(withIdentifier: "Order_Address_Cell") as! Order_Address_Cell
            cell = Bundle.main.loadNibNamed("Order_Address_Cell", owner: self, options: nil)?.first as! Order_Address_Cell
            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
            return cell
        }else if indexPath.section == 1{
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as! BatchCell
            if indexPath.section == 1{
                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
                cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
            }else{
                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_CarInfo)
                cell.lineNameModel = self.homeViewModel?.linaNameModel?.containerOperation
            }
            return cell
        }else if indexPath.section == 2{
            var cell:AddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell") as! AddressInfoCell
            cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first  as! AddressInfoCell
            cell.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
            return cell
        }else{
            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
            cell.clickDelegate = self
            if self.homeViewModel?.taskDetailModel?.taskDetailsask?.statusName == "待交付" {
                cell.button.setTitle("办理交付", for: UIControlState.normal)
            }else{
                cell.button.setTitle("办理收货", for: UIControlState.normal)
            }
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    override func buttoClickedAction() {
        let controller:ConfirmAcceptController = ConfirmAcceptController.init(style: UITableViewStyle.plain)
        controller.model = self.homeViewModel?.taskDetailModel?.taskDetailsask
        
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
