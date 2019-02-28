//
//  EntrepotsCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/12.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class EntrepotsCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    
    var entreModel:Any?{
        set{
            let entrepotsModel = newValue as? entrepotsModel
            self.titleLabel.text = entrepotsModel?.region_name
            self.detailLabel.text = entrepotsModel?.address

            if (entrepotsModel?.isSelect)! {
                self.backImageView.image = UIImage.init(named: "blueBoard")
                self.statusImage.isHidden = false
            }else{
                self.backImageView.image = UIImage.init(named: "grayBoard")
                self.statusImage.isHidden = true
            }
        }
        get{
            return nil
        }
    }
    
    var handleModel:Any?{
        set{
            let entrepotsModel = newValue as? entrepoModel
            self.titleLabel.text = entrepotsModel?.name
            self.detailLabel.text = entrepotsModel?.address
            self.backImageView.image = UIImage.init(named: "grayBoard")
            self.statusImage.isHidden = true
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
