//
//  Good_Detail_WaitAcceptController.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class Good_Detail_WaitAcceptController: BaseAlreadyChildController {

    var goodViewModel:GoodsViewModel?
    var orderModel:runOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "网点收货"
        self.tableView.mj_header = nil
        self.tableView.mj_footer = nil
        
        self.tableView.register(UINib.init(nibName: "Order_Address_Cell", bundle: nil), forCellReuseIdentifier: "Order_Address_Cell")
        self.tableView.register(UINib.init(nibName: "BatchCell", bundle: nil), forCellReuseIdentifier: "BatchCell")
        self.tableView.register(UINib.init(nibName: "AddGoodCell", bundle: nil), forCellReuseIdentifier: "AddGoodCell")
        self.tableView.register(UINib.init(nibName: "BoxCell", bundle: nil), forCellReuseIdentifier: "BoxCell")
        setViewModel()
    }

    
    
    override func setViewModel() -> Void {
        self.goodViewModel = GoodsViewModel.init()
        asyncWithParams()
    }
    
    func asyncWithParams() -> Void {
        self.goodViewModel?.params.setValue(self.orderModel?.code, forKey: "orderCode")
        self.goodViewModel?.setRequestDic()
        self.goodViewModel?.getOrderContainerDetailTask(dic: goodViewModel!.data)
        self.goodViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            
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
        }else if (indexPath.section == 1){
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as? UITableViewCell as! BatchCell
            cell.setBatchLabelAndstatusLabel(betchBehavious: .Already_info)
            cell.orderContainerModel = self.goodViewModel?.orderdetailModel
            return cell
        }else {
            
            if ((self.goodViewModel?.good_orderdetailListModel?.containerList?.count) != nil) {
                if (indexPath.section == 2+(self.goodViewModel?.good_orderdetailListModel?.containerList?.count)!){
                    var cell:AddGoodCell = tableView.dequeueReusableCell(withIdentifier: "AddGoodCell") as! AddGoodCell
                    cell = Bundle.main.loadNibNamed("AddGoodCell", owner: self, options: nil)?.first as? UITableViewCell as! AddGoodCell
                    return cell
                }else{
//                    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
//                    cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//                    cell?.textLabel?.textColor = HexColor.getHex(hexString: "#666666", alpha: 1)
//                    cell?.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
//                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
//                    let containModel = self.goodViewModel?.good_orderdetailListModel?.containerList![indexPath.section-2]
//                    cell?.textLabel?.text = NSString.init(format: "箱号  %@",(containModel?.container_code)!) as String
//                    return cell!
                    let containModel = self.goodViewModel?.good_orderdetailListModel?.containerList![indexPath.section-2]
                    var cell:BoxCell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! BoxCell
                    cell = Bundle.main.loadNibNamed("BoxCell", owner: self, options: nil)?.first as? UITableViewCell as! BoxCell
                    cell.good_model = containModel
                    return cell
                }
                
            }else{
                var cell:AddGoodCell = tableView.dequeueReusableCell(withIdentifier: "AddGoodCell") as! AddGoodCell
                cell = Bundle.main.loadNibNamed("AddGoodCell", owner: self, options: nil)?.first as? UITableViewCell as! AddGoodCell
                return cell
            }
        }
    }
    
    //MARK: - Action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ((self.goodViewModel?.good_orderdetailListModel?.containerList?.count) != nil) && ((self.goodViewModel?.good_orderdetailListModel?.containerList?.count) != 0) {
            if indexPath.section == 2+(self.goodViewModel?.good_orderdetailListModel?.containerList?.count)! {
                
                let num = self.goodViewModel?.orderdetailModel?.order?.container_number
                let numInt = (num! as NSString).intValue
                
                if (self.goodViewModel?.good_orderdetailListModel?.containerList?.count)! == numInt {
                    MBProgressHUD.showTipMessage(inWindow: "箱子已全部装载完毕", timer: 1)
                    return
                }
                
                let detailController = GoodsKeyInViewController.init(style: UITableViewStyle.grouped)
                detailController.orderModel = self.orderModel
                detailController.enportSelectBlock = {(name:String) in
                    self.asyncWithParams()
                }
                self.navigationController?.pushViewController(detailController, animated: true)
                
            }else{
                let box:BoxGoodsController = BoxGoodsController.init(style: UITableViewStyle.plain)
                box.isShowWayInfo = true
                let model = self.goodViewModel?.good_orderdetailListModel?.containerList![indexPath.section - 2]
                box.box_Model = model
                self.navigationController?.pushViewController(box, animated: true)
            }
        }else{
            if indexPath.section == 2{
                
                let detailController:GoodsKeyInViewController = GoodsKeyInViewController.init(style: UITableViewStyle.grouped)
                detailController.orderModel = self.orderModel
                detailController.enportSelectBlock = {(name:String) in
                    self.asyncWithParams()
                }
                self.navigationController?.pushViewController(detailController, animated: true)
            }
        }
    }
}
