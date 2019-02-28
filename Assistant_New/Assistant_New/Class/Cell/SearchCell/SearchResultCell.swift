//
//  SearchResultCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/20.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var model:Any?{
        set{
            let entrepotsModel = newValue as? GoodsModel
            self.label.text = entrepotsModel?.name
        }
        get{
            return nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
