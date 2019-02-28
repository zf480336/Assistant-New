//
//  AlreadyCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class AlreadyCell: BaseTableViewCell {

    
    
    @IBOutlet weak var lineName: UILabel!
    @IBOutlet weak var cityqsLabel: UILabel!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var carNum: UILabel!
    @IBOutlet weak var statusLael: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    var alredyModel:Any?{
        set{
            let alredyModel = newValue as? alreadyModel
            if alredyModel == nil {
                return;
            }
            self.lineName.text = alredyModel?.line_name
            self.cityqsLabel.text = NSString.init(format: "%@  —  %@", (alredyModel?.startEntrepotName)!,(alredyModel?.endEntrepotName)!) as String
            self.goodName.text = alredyModel?.goods_name
            self.carNum.text = alredyModel?.trans_number ?? "暂无"
            
            if alredyModel?.status == "1" {
                self.statusLael.text = "在途"
                self.statusLael.textColor = HexColor.getHex(hexString: "#3CA0F4", alpha: 1)
            }else if alredyModel?.status == "2" {
                self.statusLael.text = "已抵达"
                self.statusLael.textColor = HexColor.getHex(hexString: "#7ED321", alpha: 1)
            }else{
                self.statusLael.text = "已交付"
                self.statusLael.textColor = HexColor.getHex(hexString: "#FF2600", alpha: 1)
            }
        }
        get{
            return nil
        }
    }
}
