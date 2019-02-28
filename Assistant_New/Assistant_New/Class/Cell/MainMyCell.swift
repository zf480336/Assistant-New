//
//  MainMyCell.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class MainMyCell: UITableViewCell {

    public var model:Any!{
        didSet{
            self.wayBillLabel.text = String.init(format: "运单号  %@",(model as! detailModel).waybillCode!)
            self.cityLabel.text = String.init(format: "%@  —  %@",(model as! detailModel).startRegionName!,(model as! detailModel).endRegionName! )
            self.goodLabel.text = (model as! detailModel).goodsName
            if (model as! detailModel).statusName == "已发运" {
                 self.statusLabel.text = "待收货"
            }else{
                self.statusLabel.text = (model as! detailModel).statusName
            }
            if self.statusLabel.text == "待收货" {
                self.statusLabel.textColor = HexColor.getHex(hexString: "#3CA0F4", alpha: 1)
            }else if self.statusLabel.text == "待发运" {
                self.statusLabel.textColor = HexColor.getHex(hexString: "#7ED321", alpha: 1)
            }else{
                self.statusLabel.textColor = HexColor.getHex(hexString: "#FF2600", alpha: 1)
            }
            self.nameLabel.text = (model as! detailModel).name
//            let timeStr = (model as! detailModel).estimate_departure_time
//            self.timeLabel.text = String.timeStampToString(timeStamp: (timeStr! as NSString).doubleValue)
            if (model as! detailModel).statusName == "待发运" {
                let timeStr = (model as! detailModel).estimate_departure_time
                self.timeLabel.text = String.timeStampToString(timeStamp: (timeStr! as NSString).doubleValue)
                self.jhqyLabel.text = "计划起运"
            }else{
                let timeStr = (model as! detailModel).estimate_arrival_time
                self.timeLabel.text = String.timeStampToString(timeStamp: (timeStr! as NSString).doubleValue)
                self.jhqyLabel.text = "预计抵达"
            }
            if  (model as! detailModel).transCode != nil {
                self.carLabel.isHidden = false
                self.carDetailLabel.isHidden = false
                self.carDetailLabel.text = (model as! detailModel).transCode
            }else{
                self.carLabel.isHidden = true
                self.carDetailLabel.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var wayBillLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!  //始发车次
    @IBOutlet weak var carDetailLabel: UILabel! //始发车次
    @IBOutlet weak var jhqyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
   
    
}
