//
//  WayBillCell.swift
//  Assistant
//
//  Created by lxy on 2019/1/2.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

class WayBillCell: UITableViewCell {

    @IBOutlet weak var billLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    var model:Any?{
        set{
            let wayBillModel = newValue as? billModel
            if wayBillModel == nil {
                return;
            }
            self.billLabel.text = String.init(format: "运单号： %@", (wayBillModel?.waybill_code)!)
        }
        get{
            return nil
        }
    }

}
