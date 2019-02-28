//
//  Good_Detail_HadAcceptController.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class Good_Detail_HadAcceptController: ConsigneeController {

    var goodViewModel:GoodsViewModel?
    var orderModel:runOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "任务详情"
        
        setViewModel()
    }

    override func setViewModel() -> Void {
        self.goodViewModel = GoodsViewModel.init()
        asyncWithParams()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func asyncWithParams() -> Void {
        self.goodViewModel?.params.setValue(self.orderModel?.code, forKey: "orderCode")
        self.goodViewModel?.setRequestDic()
        self.goodViewModel?.getOrderContainerDetailTask(dic: goodViewModel!.data)
        self.goodViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if ((self.goodViewModel?.good_orderdetailListModel?.containerList?.count) != nil) {
            return 3+(self.goodViewModel?.good_orderdetailListModel?.containerList?.count)!
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
            cell.orderContainerModel = self.goodViewModel?.orderdetailModel
            return cell
            
        }else if indexPath.section == 1{
            
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as! BatchCell
            cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
            cell.orderContainerModel = self.goodViewModel?.orderdetailModel
            return cell
            
        }else if indexPath.section == 2{
            
            var cell:AddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressInfoCell") as! AddressInfoCell
            cell = Bundle.main.loadNibNamed("AddressInfoCell", owner: self, options: nil)?.first  as! AddressInfoCell
            cell.orderContainerModel = self.goodViewModel?.orderdetailModel
            return cell
            
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell?.textLabel?.textColor = HexColor.getHex(hexString: "#666666", alpha: 1)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            let containModel = self.goodViewModel?.good_orderdetailListModel?.containerList![indexPath.section-3]
            cell?.textLabel?.text = NSString.init(format: "箱号  %@",(containModel?.container_code)!) as String
            return cell!
//            if ((self.goodViewModel?.orderdetailListModel?.containerList?.count) != nil) {
//                if (indexPath.section == 3+(self.goodViewModel?.orderdetailListModel?.containerList?.count)!){
//                    var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
//                    cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
//                    cell.clickDelegate = self
//                    return cell
//
//                }else{
//                    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
//                    cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//                    cell?.textLabel?.textColor = HexColor.getHex(hexString: "#666666", alpha: 1)
//                    cell?.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
//                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
//                    let containModel = self.goodViewModel?.orderdetailListModel?.containerList![indexPath.section-3]
//                    cell?.textLabel?.text = NSString.init(format: "箱号  %@",(containModel?.container_code)!) as String
//                    return cell!
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
       
        if indexPath.section > 2{
            
            let box:BoxGoodsController = BoxGoodsController.init(style: UITableViewStyle.plain)
            box.isShowWayInfo = true
            let model = self.goodViewModel?.good_orderdetailListModel?.containerList![indexPath.section - 3]
            box.box_Model = model
            self.navigationController?.pushViewController(box, animated: true)
        }
    }
    
//    override func buttoClickedAction() {
//        print("iOS-Swift开发")
//        let controller:HandleShipController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HandleShipController") as! HandleShipController
//        self.navigationController?.pushViewController(controller, animated: true)
//    }

}
