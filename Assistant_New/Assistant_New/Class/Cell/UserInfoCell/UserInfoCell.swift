//
//  UserInfoCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/10.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class UserInfoCell: BaseTableViewCell {

     @IBOutlet public weak var titleLabel: UILabel!
     @IBOutlet public weak var titleDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
