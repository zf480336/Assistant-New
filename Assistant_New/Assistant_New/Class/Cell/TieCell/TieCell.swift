//
//  TieCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class TieCell: BaseTableViewCell {

    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var statusNameBtn: UIButton!
    
   

    
    var OrderContainer_model:Any?{
        set{
            let model = newValue as? OrderContainer_listModel
            self.numberLabel.text = model?.container_code
            if (model?.car_no != nil && model?.car_no != "") && (model?.billCode != nil && model?.billCode != ""){
                self.statusNameBtn.setTitle("已装载", for: UIControlState.normal)
                self.statusBtn.setBackgroundImage(UIImage.init(named: "finish"), for: UIControlState.normal)
                ViewSetCorner.setBorders(boardWidth: 1, view: self.statusNameBtn, color: HexColor.getHex(hexString: "#9AC543", alpha: 1))
                self.statusNameBtn.setTitleColor(HexColor.getHex(hexString: "#9AC543", alpha: 1), for: UIControlState.normal)
            }else{
                self.statusNameBtn.setTitle("待装载", for: UIControlState.normal)
                self.statusBtn.setBackgroundImage(UIImage.init(named: "about"), for: UIControlState.normal)
                ViewSetCorner.setBorders(boardWidth: 1, view: self.statusNameBtn, color: HexColor.getHex(hexString: "#3BA0F3", alpha: 1))
                self.statusNameBtn.setTitleColor(HexColor.getHex(hexString: "#3BA0F3", alpha: 1), for: UIControlState.normal)
            }
        }
        get{
            return nil
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewSetCorner.setCornerRadius(corner: 3, view: self.statusNameBtn)
        ViewSetCorner.setBorders(boardWidth: 1, view: self.statusNameBtn, color: HexColor.getHex(hexString: "#3BA0F3", alpha: 1))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
}
