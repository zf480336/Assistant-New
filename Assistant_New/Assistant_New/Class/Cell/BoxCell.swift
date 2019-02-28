//
//  BoxCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

protocol BoxCellDelegate {
    func selectBoxCell(section:Int)
}

class BoxCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var boxLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    
    var boxDelegate:BoxCellDelegate?
    var section:Int?
    
    var model:Any?{
        set{
            let boxModel = newValue as? OrderContainer_listModel
            self.boxLabel.text =  NSString.init(format: "箱号  %@", (boxModel?.container_code)!) as String
            if (boxModel?.isSelect)! {
                self.backView.backgroundColor = HexColor.getHex(hexString: "#FFFC79", alpha: 1)
            }else{
                self.backView.backgroundColor = HexColor.getHex(hexString: "#ffffff", alpha: 1)
            }
            if boxModel?.waybilId != nil {
                self.statusLabel.isHidden = false
            }else{
                self.statusLabel.isHidden = true
            }
        }
        get{
            return nil
        }
    }
    
    var good_model:Any?{
        set{
            let boxModel = newValue as? Good_OrderContainerModel
            self.boxLabel.text =  NSString.init(format: "箱号  %@", (boxModel?.container_code)!) as String
//            if (boxModel?.isSelect)! {
//                self.backView.backgroundColor = HexColor.getHex(hexString: "#FFFC79", alpha: 1)
//            }else{
//                self.backView.backgroundColor = HexColor.getHex(hexString: "#ffffff", alpha: 1)
//            }
//            if boxModel?.waybilId != nil {
//                self.statusLabel.isHidden = false
//            }else{
                self.statusLabel.isHidden = true
                self.detailBtn.isHidden = true
//            }
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

        
    }
    
    func setModelAndSection(section:Int) -> Void {
        self.section = section
    }
    
    @IBAction func pressDetailBtn(_ sender: Any) {
        if (self.boxDelegate != nil) {
            self.boxDelegate?.selectBoxCell(section: self.section!)
        }
    }
}
