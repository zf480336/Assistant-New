//
//  BoxGoodsController.swift
//  Assistant
//
//  Created by lxy on 2018/12/3.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BoxGoodsController: BatchDetailController {

    var goodViewModel:GoodsViewModel?
    var model:WayBilldetailModel?
    var boxModel:OrderContainer_listModel?
    var box_Model:Good_OrderContainerModel?
    var isNaviHiden:Bool?  //已办详情隐藏编辑按钮
    var isShowWayInfo:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "箱货详情"
        self.tableView.mj_footer = nil
        self.tableView.mj_header = nil
        self.tableView.separatorColor = HexColor.getHex(hexString: "#E8E8E8", alpha: 1)
        
        if self.isNaviHiden == nil {
            self.NaviRight?.isHidden = false
            self.NaviRight?.setTitle("编辑", for: UIControlState.normal)
            self.NaviRight?.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        }
        setModelImage()
        setViewModel()
    }
    
    override func setViewModel() {
        
    }

    func setModelImage() -> Void {
        if self.isShowWayInfo == true {
            if self.box_Model?.goods1_url != nil && self.box_Model?.goods1_url != ""{
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(self.box_Model?.goods1_url)!)
                let url : NSURL = NSURL(string: ImageString as String)!
                let data : NSData = NSData.init(contentsOf: url as URL)!
                let image = UIImage(data:data as Data, scale: 1.0)
                self.box_Model?.image1 = image
            }
            if self.box_Model?.goods2_url != nil && self.box_Model?.goods2_url != ""{
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(self.box_Model?.goods2_url)!)
                let url : NSURL = NSURL(string: ImageString as String)!
                let data : NSData = NSData.init(contentsOf: url as URL)!
                let image = UIImage(data:data as Data, scale: 1.0)
                self.box_Model?.image2 = image
            }
            if self.box_Model?.goods3_url != nil && self.box_Model?.goods3_url != ""{
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(self.box_Model?.goods3_url)!)
                let url : NSURL = NSURL(string: ImageString as String)!
                let data : NSData = NSData.init(contentsOf: url as URL)!
                let image = UIImage(data:data as Data, scale: 1.0)
                self.box_Model?.image3 = image
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            var cell:BatchImageCell = tableView.dequeueReusableCell(withIdentifier: "BatchImageCell") as! BatchImageCell
            cell = Bundle.main.loadNibNamed("BatchImageCell", owner: self, options: nil)?.first as! BatchImageCell
            if self.isShowWayInfo == true {
                cell.box_Model = self.box_Model
            }else{
                cell.boxModel = self.boxModel
            }
           
            return cell
        }else{
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as? UITableViewCell as! BatchCell
           
            if(indexPath.row == 0){
                cell.isShowBill = self.isShowWayInfo
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_BillInfo)
                if self.isShowWayInfo == true {
                    cell.isShowBill = true
                    cell.box_Model = self.box_Model
                }else{
                    cell.boxModel = self.boxModel
                }
            }else if(indexPath.row == 1){
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_containerInfo)
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: 600, bottom: 0, right: 0)
                if self.isShowWayInfo == true {
                    cell.box_Model = self.box_Model
                }else{
                    cell.boxModel = self.boxModel
                }
                
            }else if(indexPath.row == 3){
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_goodInfo)
                if self.isShowWayInfo == true {
                    cell.box_Model = self.box_Model
                }else{
                    cell.boxModel = self.boxModel
                }
            }else if(indexPath.row == 4){
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: 600, bottom: 0, right: 0)
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_conferInfo)
                if self.isShowWayInfo == true {
                    cell.box_Model = self.box_Model
                }else{
                    cell.boxModel = self.boxModel
                }
            }
            return cell
        }
    }
    
   
    override func pressNaviRight() {
        let keyInController = GoodsKeyInViewController.init(style: UITableViewStyle.plain)
        if self.boxModel != nil {
            keyInController.boxModel = self.boxModel
            keyInController.keyInModel.containerCode = self.boxModel?.container_code
            keyInController.keyInModel.unitNumber = self.boxModel?.unit_num
            keyInController.keyInModel.seal_code = self.boxModel?.seal_code
            keyInController.keyInModel.tarpaulin_number = self.boxModel?.tarpaulin_number
            keyInController.keyInModel.net_weight = self.boxModel?.suttle
            keyInController.keyInModel.gross_weight = self.boxModel?.gross_weight
            keyInController.keyInModel.image1 = self.boxModel?.image1
            keyInController.keyInModel.image2 = self.boxModel?.image2
            keyInController.keyInModel.image3 = self.boxModel?.image3
            keyInController.keyInModel.netWork = self.boxModel?.entrepotName
            keyInController.keyInModel.netWorkid = self.boxModel?.receive_entrepot_id
            
        }else{
            keyInController.box_Model = self.box_Model
            keyInController.keyInModel.containerCode = self.box_Model?.container_code
            keyInController.keyInModel.unitNumber = self.box_Model?.unit_num
            keyInController.keyInModel.seal_code = self.box_Model?.seal_code
            keyInController.keyInModel.tarpaulin_number = self.box_Model?.tarpaulin_number
            keyInController.keyInModel.net_weight = self.box_Model?.suttle
            keyInController.keyInModel.gross_weight = self.box_Model?.gross_weight
            keyInController.keyInModel.image1 = self.box_Model?.image1
            keyInController.keyInModel.image2 = self.box_Model?.image2
            keyInController.keyInModel.image3 = self.box_Model?.image3
            keyInController.keyInModel.netWork = self.box_Model?.entrepotName
            keyInController.keyInModel.netWorkid = self.box_Model?.receive_entrepot_id
        }
        self.navigationController?.pushViewController(keyInController, animated: true)
        
    }
    

}
