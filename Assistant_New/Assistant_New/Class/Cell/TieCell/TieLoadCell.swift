//
//  TieLoadCell.swift
//  Assistant
//
//  Created by lxy on 2019/1/2.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

protocol TieloadDelegate {
    func refreshTableView()
}

class TieLoadCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var tieLoadField: UITextField!
    
    var model:OrderContainer_listModel?
    var load:Bool?
    var tieloadDelegate:TieloadDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tieLoadField.delegate = self
    }
    var OrderContainer_model:Any?{
        set{
            let model = newValue as? OrderContainer_listModel
            self.model = model
            self.tieLoadField.text = model?.car_no
        }
        get{
            return nil
        }
    }
    
    var isLoad:Bool?{
        set{
            let load = newValue
            self.load  = load
        }
        
        get{
            return nil
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.count)! > 0 {
            self.load = true
            
        }else{
            self.load = false
        }
        self.model?.car_no = textField.text
        if (self.tieloadDelegate != nil) {
            self.tieloadDelegate?.refreshTableView()
        }
    }
    
}
