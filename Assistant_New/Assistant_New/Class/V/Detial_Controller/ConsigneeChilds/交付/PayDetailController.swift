//
//  AlreadyDetailController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class PayDetailController: AcceptDetailController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "交付详情"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == 0 {
//            var cell = tableView.dequeueReusableCell(withIdentifier: "Order_Address_Cell")
//            cell = Bundle.main.loadNibNamed("Order_Address_Cell", owner: self, options: nil)?.first as? UITableViewCell
//            return cell!
//        }else if indexPath.section == 1 || indexPath.section == 3{
//            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
//            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as! BatchCell
//            if indexPath.section == 1{
//                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
//            }else{
//                cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_CarInfo)
//            }
//            return cell
//        }else if indexPath.section == 2{
//            var cell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell")
//            cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first as? UITableViewCell
//            return cell!
//        }else{
//            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
//            cell.clickDelegate = self
//            cell.button.setTitle("办理交付", for: UIControlState.normal)
//            return cell
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
//
//    override func buttoClickedAction() {
//        let controller = ConfirmPayController.init(style: UITableViewStyle.plain)
//        self.navigationController?.pushViewController(controller, animated: true)
//    }

}
