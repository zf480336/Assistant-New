//
//  BatchCell.swift
//  Assistant
//
//  Created by lxy on 2018/11/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BatchCell: UITableViewCell {
    
    //发运，详情
    
    var model:Any?{
        set{
            let wayBilldetailModel = newValue as? WayBilldetailModel
            if wayBilldetailModel == nil {
                return;
            }
            self.batchLabel.text = NSString.init(format: "批次编号  %@", (wayBilldetailModel?.orderCode)!) as String
            self.statusLabel.text = wayBilldetailModel?.statusName
            if self.betchBehavious == .Already_info  {
                let timeorder = wayBilldetailModel?.estimate_departure_time
                let strrr = String.timeStampToString(timeStamp: (timeorder! as NSString).doubleValue)
                var detailString:String =  strrr
                detailString.append("\n")
                let bussiness_code:Business_type_code = Business_type_code.init(rawValue: (wayBilldetailModel?.ParentBusinessTypeCode)!)!
                switch bussiness_code{
                case .集装箱:
                    detailString.append("集装箱")
                default:
                    break
                }
                detailString.append("\n")
                detailString.append((wayBilldetailModel?.container_number)!)
                detailString.append("\n")
                detailString.append((wayBilldetailModel?.containerTypeName)!)
                setContentDetailLabelText(str: detailString)
            }
        }
        get{
            return nil
        }
    }
    
    var lineNameModel:Any?{
        set{
            let linaModel = newValue as? alreadyModel
            if linaModel == nil {
                var detailString:String = "暂无"
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                setContentDetailLabelText(str: detailString)
                return
            }
            self.batchLabel.text = NSString.init(format: "运输编号  %@", (linaModel?.line_name)!) as String
            if self.betchBehavious == .Already_CarInfo  {
                var detailString:String =  (linaModel?.create_time)!
                detailString.append("\n")
                detailString.append((linaModel?.create_time)!)
                detailString.append("\n")
                detailString.append((linaModel?.startEntrepotName)!)
                detailString.append("\n")
                detailString.append((linaModel?.create_time)!)
                detailString.append("\n")
                detailString.append((linaModel?.endEntrepotName)!)
                detailString.append("\n")
                if linaModel?.update_time == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((linaModel?.update_time)!)
                }
                
                setContentDetailLabelText(str: detailString)
            }
        }
        get{
            return nil
        }
    }
    
    var orderContainerModel:Any?{
        set{
            let model = newValue as? OrderContainerModel
            if model == nil {
                return;
            }
            self.batchLabel.text = NSString.init(format: "批次编号  %@", (model?.order?.code)!) as String

            self.statusLabel.text = ""
            if self.betchBehavious == .Already_info  {
                let timeorder = model?.order?.estimate_departure_time
                let strrr = String.timeStampToString(timeStamp: (timeorder! as NSString).doubleValue)
                var detailString:String =  strrr
                detailString.append("\n")
                let bussiness_code:Business_type_code = Business_type_code.init(rawValue: (model?.order?.business_type_code)!)!
                switch bussiness_code{
                case .集装箱:
                    detailString.append("集装箱")
                default:
                    break
                }
                detailString.append("\n")
                detailString.append((model?.order?.container_number)!)
                detailString.append("\n")
                detailString.append(model?.order?.containerName ?? "暂无")
                setContentDetailLabelText(str: detailString)
            }
        }
        get{
            return nil
        }
    }
    
    
    var boxModel:Any?{
        set{
            let model = newValue as? OrderContainer_listModel
            if model == nil {
                return;
            }
            
            
            if self.betchBehavious == .BatchDetail_BillInfo  {
                
                if self.isShowBill == true {
                    let detailString:String =  model!.entrepotName ?? "暂无"
                    self.conDetailLabel?.text = detailString
//                    setContentDetailLabelText(str: detailString)
                }else{
                    if model?.waybillCode == nil {
                        self.batchLabel.text = "运单号  暂无"
                    }else{
                        self.batchLabel.text = NSString.init(format: "运单号  %@", (model?.waybillCode)!) as String
                    }
                    var detailString:String = model?.car_no ?? "暂无"
                    detailString.append("\n")
                    detailString.append(model!.entrepotName ?? "暂无")
                    setContentDetailLabelText(str: detailString)
                }
            }
            
            //集装箱信息
            if self.betchBehavious == .BatchDetail_containerInfo {
                var detailString:String =  model?.container_code ?? "暂无"
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                
                setContentDetailLabelText(str: detailString)
            }
            
            //货品信息
            if self.betchBehavious == .BatchDetail_goodInfo {
                var detailString:String =  "暂无"
                detailString.append("\n")
                if model?.suttle == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.suttle)!)
                }
                detailString.append("\n")
                
                //毛重
                if model?.gross_weight == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.gross_weight)!)
                }
                detailString.append("\n")
                
                //体积
                detailString.append("暂无")
                detailString.append("\n")
                
                if model?.unit_num == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.unit_num)!)
                }
                
                setContentDetailLabelText(str: detailString)
            }
            //施封信息
            if self.betchBehavious == .BatchDetail_conferInfo {
                var detailString:String =  "暂无"
                detailString.append("\n")
                if model?.seal_code == nil || model?.seal_code == "" {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.seal_code)!)
                }
                detailString.append("\n")
                
                if model?.tarpaulin_number == nil || model?.tarpaulin_number == "" {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.tarpaulin_number)!)
                }
               
                setContentDetailLabelText(str: detailString)
            }
        }
        get{
            return nil
        }
    }
    var box_Model:Any?{
        set{
            let model = newValue as? Good_OrderContainerModel
            if model == nil {
                return;
            }
            
            
            if self.betchBehavious == .BatchDetail_BillInfo  {
                
                if self.isShowBill == true {
                    let detailString:String =  model!.entrepotName ?? "暂无"
                    self.conDetailLabel?.text = detailString
                    //                    setContentDetailLabelText(str: detailString)
                }else{
                    if model?.waybillCode == nil {
                        self.batchLabel.text = "暂无"
                    }else{
                        self.batchLabel.text = NSString.init(format: "运单号  %@", (model?.waybillCode)!) as String
                    }
                    var detailString:String =  "暂无"
                    detailString.append("\n")
                    detailString.append(model!.entrepotName ?? "暂无")
                    setContentDetailLabelText(str: detailString)
                }
            }
            
            //集装箱信息
            if self.betchBehavious == .BatchDetail_containerInfo {
                var detailString:String =  model?.container_code ?? "暂无"
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                detailString.append("\n")
                detailString.append("暂无")
                
                setContentDetailLabelText(str: detailString)
            }
            
            //货品信息
            if self.betchBehavious == .BatchDetail_goodInfo {
                var detailString:String =  "暂无"
                detailString.append("\n")
                if model?.suttle == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.suttle)!)
                }
                detailString.append("\n")
                
                //毛重
                if model?.gross_weight == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.gross_weight)!)
                }
                detailString.append("\n")
                
                //体积
                detailString.append("暂无")
                detailString.append("\n")
                
                if model?.unit_num == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.unit_num)!)
                }
                
                setContentDetailLabelText(str: detailString)
            }
            //施封信息
            if self.betchBehavious == .BatchDetail_conferInfo {
                var detailString:String =  "暂无"
                detailString.append("\n")
                if model?.seal_code == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.seal_code)!)
                }
                detailString.append("\n")
                
                if model?.tarpaulin_number == nil {
                    detailString.append("暂无")
                }else{
                    detailString.append((model?.tarpaulin_number)!)
                }
                
                setContentDetailLabelText(str: detailString)
            }
        }
        get{
            return nil
        }
    }
    
    
    @IBOutlet weak var batchLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var conDetailLabel: UILabel!
    var betchBehavious:BetchCellSubViews?
    var isShowBill:Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func setBatchLabelAndstatusLabel(betchBehavious:BetchCellSubViews) {
        self.betchBehavious = betchBehavious
        switch betchBehavious {
        case .Already_info:
            self.statusLabel.isHidden = true
            self.batchLabel?.text = "运单号  。。。。"
            self.statusLabel?.isHidden  = false
            let contentStr = "计划起运时间\n运力类型\n数量\n集装箱类型"
            self .setContentLabelText(str: contentStr)
            break
            
        case .Already_CarInfo:
            self.batchLabel?.text = "运输编号  。。。。"
            self.statusLabel?.isHidden  = true
            let contentStr = "始发车次\n始发车次\n始发车站\n始发时间\n抵达车站\n抵达时间"
            self .setContentLabelText(str: contentStr)
            break
            
        case .BatchDetail_BillInfo:
            
            if self.isShowBill == true {
                self.batchLabel?.text = "网点信息"
                self.statusLabel?.isHidden  = true
                let contentStr = "网点"
//                self .setContentLabelText(str: contentStr)
                self.contentLabel?.text = contentStr
            }else{
                self.batchLabel?.text = "运单号  。。。。"
                self.statusLabel?.isHidden  = true
                let contentStr = "车底号\n网点"
                self .setContentLabelText(str: contentStr)
            }
           
            break
            
        case .BatchDetail_containerInfo:
            self.batchLabel?.text = "集装箱信息"
            self.batchLabel?.textColor = HexColor.getHex(hexString: "#999999", alpha: 1)
            self.statusLabel?.isHidden  = true
            let contentStr = "集装箱号\n租用公司\n联系电话\n用箱时间\n还箱时间\n装载时间"
            self .setContentLabelText(str: contentStr)
            break
            
        case .BatchDetail_goodInfo:
            self.batchLabel?.text = "货品信息"
            self.batchLabel?.textColor = HexColor.getHex(hexString: "#999999", alpha: 1)
            self.statusLabel?.isHidden  = true
            let contentStr = "货品名称\n净重(吨)\n毛重(吨)\n体积(立方米)\n件数"
            self .setContentLabelText(str: contentStr)
            break
            
        case .BatchDetail_conferInfo:
            self.batchLabel?.text = "施封信息"
            self.batchLabel?.textColor = HexColor.getHex(hexString: "#999999", alpha: 1)
            self.statusLabel?.isHidden  = true
            let contentStr = "施封时间\n施封号\n篷布号"
            self .setContentLabelText(str: contentStr)
            break
        }
    }
    
    private func setContentLabelText(str:String) -> Void {
        self.contentLabel?.attributedText = UILabel.setParagraphWithLineHeight(lineHeight: 12, str: str as NSString,aligement: NSTextAlignment.left)
    }
    
    private func setContentDetailLabelText(str:String) -> Void {
        self.conDetailLabel?.attributedText = UILabel.setParagraphWithLineHeight(lineHeight: 12, str: str as NSString,aligement: NSTextAlignment.right)
    }
    
}
