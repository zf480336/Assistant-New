//
//  TieSelectCell.swift
//  Assistant
//
//  Created by lxy on 2019/1/2.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

class TieSelectCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var OrderContainer_model:Any?{
        set{

            let model = newValue as? OrderContainer_listModel
            if model == nil {
                return
            }
            if model?.billCode == nil {
                self.label.text = "请选择运单号"
            }else{
                self.label.text = String.init(format: "运单号： %@", (model?.billCode)!)
            }
        }
        get{
            return nil
        }
    }
}
