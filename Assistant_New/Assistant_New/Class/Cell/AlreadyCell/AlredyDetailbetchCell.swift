//
//  AlredyDetailbetchCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class AlredyDetailbetchCell: BaseTableViewCell {

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var wayBillCode: UILabel!
    @IBOutlet weak var containerCOde: UILabel!
    @IBOutlet weak var cdNumber: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectBtn.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    var orderContainer_listModel:Any?{
        set{
            let orderContainer_listModel = newValue as? OrderContainer_listModel
            if orderContainer_listModel == nil {
                return;
            }
            self.wayBillCode.text = orderContainer_listModel?.waybillCode
            self.containerCOde.text = orderContainer_listModel?.container_code
            
            self.cdNumber.text = orderContainer_listModel?.car_no ?? "暂无"
            if orderContainer_listModel?.isSelect == true {
                self.selectBtn.setBackgroundImage(UIImage.init(named: "finish"), for: UIControlState.normal)
            }else{
                self.selectBtn.setBackgroundImage(UIImage.init(named: "Shape"), for: UIControlState.normal)
            }
        }
        get{
            return nil
        }
    }
}
