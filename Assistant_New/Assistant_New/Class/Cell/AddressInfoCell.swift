//
//  AddressInfoCell.swift
//  Assistant
//
//  Created by lxy on 2018/11/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class AddressInfoCell: UITableViewCell {

    var model:Any?{
        set{
            let wayBilldetailModel = newValue as? WayBilldetailModel
            
            self.startCity.text = wayBilldetailModel?.startEntrePortName ?? "暂无"
            self.startName.text = wayBilldetailModel?.orderStartContacts ?? "暂无"
            self.startPhone.text = wayBilldetailModel?.orderStartPone ?? "暂无"
            self.startAddress.text = wayBilldetailModel?.start_address ?? "暂无"
            
            self.endCity.text = wayBilldetailModel?.endEntrePortName ?? "暂无"
            self.endName.text = wayBilldetailModel?.orderEndContacts ?? "暂无"
            self.endPhone.text = wayBilldetailModel?.orderEndPhone ?? "暂无"
            self.endAddress.text = wayBilldetailModel?.end_address ?? "暂无"
            
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
            self.startCity.text = model?.order?.startRegionName ?? "暂无"
            self.startName.text = model?.order?.start_contacts ?? "暂无"
            self.startPhone.text = model?.order?.start_phone ?? "暂无"
            self.startAddress.text = model?.order?.start_address ?? "暂无"
            self.endCity.text = model?.order?.endRegionName ?? "暂无"
            self.endName.text = model?.order?.end_contacts ?? "暂无"
            self.endPhone.text = model?.order?.end_phone ?? "暂无"
            self.endAddress.text = model?.order?.end_address ?? "暂无"
        }
        get{
            return nil
        }
    }
    
    @IBOutlet weak var startCity: UILabel!
    @IBOutlet weak var startName: UILabel!
    @IBOutlet weak var startPhone: UILabel!
    @IBOutlet weak var startAddress: UILabel!
    @IBOutlet weak var endCity: UILabel!
    @IBOutlet weak var endName: UILabel!
    @IBOutlet weak var endPhone: UILabel!
    @IBOutlet weak var endAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
