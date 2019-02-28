//
//  ButtonCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/3.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

protocol ButtonClickedDelegate {
    func buttoClickedAction()
}

class ButtonCell: UITableViewCell {

    var clickDelegate:ButtonClickedDelegate?
    
    @IBOutlet public weak var button: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewSetCorner.setCornerRadius(corner: 3, view: self.button)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressButton(_ sender: Any) {
        if (self.clickDelegate != nil) {
            self.clickDelegate?.buttoClickedAction()
        }
    }
}
