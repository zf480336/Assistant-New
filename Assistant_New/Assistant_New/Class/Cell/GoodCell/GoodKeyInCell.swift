//
//  GoodKeyInCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class GoodKeyInCell: BaseTableViewCell,UITextFieldDelegate {

    var keyInModel:KeyInModel?
    var section:Int?
    var row:Int?
    
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldValueChanged(noti:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func settitleLabelAndTextField(keyinModel:KeyInModel,section:Int,row:Int) {
       
        self.keyInModel = keyinModel
        self.section = section
        self.row = row
        
        if self.section == 1 && self.row == 0 {
           self.textField.text = self.keyInModel?.containerCode
        }
        if self.section == 1 && self.row == 1 {
            self.textField.text = self.keyInModel?.rentCompany
        }
        if self.section == 1 && self.row == 2 {
            self.textField.text = self.keyInModel?.tel
        }
        if self.section == 1 && self.row == 3 {
            self.textField.text = self.keyInModel?.useDate
        }
        if self.section == 1 && self.row == 4 {
            self.textField.text = self.keyInModel?.backDate
        }
        if self.section == 1 && self.row == 5 {
            self.textField.text = self.keyInModel?.loadDate
        }
        if self.section == 2 && self.row == 0 {
            self.textField.text = self.keyInModel?.goodName
        }
        if self.section == 2 && self.row == 1 {
            self.textField.text = self.keyInModel?.goodInName
        }
        if self.section == 2 && self.row == 2 {
            self.textField.text = self.keyInModel?.net_weight
        }
        if self.section == 2 && self.row == 3 {
            self.textField.text = self.keyInModel?.gross_weight
        }
        
        if self.section == 2 && self.row == 4 {
            self.textField.text = self.keyInModel?.tj
        }
        if self.section == 2 && self.row == 5 {
            self.textField.text = self.keyInModel?.unitNumber
        }
        
        if self.section == 3 && self.row == 0 {
            self.textField.text = self.keyInModel?.sfsj
        }
        
        if self.section == 3 && self.row == 1 {
            self.textField.text = self.keyInModel?.seal_code
        }
        if self.section == 3 && self.row == 2 {
            self.textField.text = self.keyInModel?.tarpaulin_number
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if self.section == 1 && self.row == 1 {
            self.keyInModel?.rentCompany = textField.text
        }
        if self.section == 1 && self.row == 2 {
            self.keyInModel?.tel = textField.text
        }
        
        if self.section == 2 && self.row == 1 {
            self.keyInModel?.goodInName = textField.text
        }
        if self.section == 2 && self.row == 2 {
            self.keyInModel?.net_weight = textField.text
        }
        if self.section == 2 && self.row == 3 {
            self.keyInModel?.gross_weight = textField.text
        }
        if self.section == 2 && self.row == 4 {
            self.keyInModel?.tj = textField.text
        }
        if self.section == 2 && self.row == 5 {
            self.keyInModel?.unitNumber = textField.text
        }
        if self.section == 3 && self.row == 1 {
            self.keyInModel?.seal_code = textField.text
        }
        if self.section == 3 && self.row == 2 {
            self.keyInModel?.tarpaulin_number = textField.text
        }
        
    }
    
    @objc fileprivate func textFieldValueChanged(noti:NSNotification) -> Void {
        let field = noti.object as! UITextField;
        if (field.markedTextRange != nil) {
            return;
        }
        if (field.text?.contains(" "))! {
            field.text = field.text?.replacingOccurrences(of: " ", with: "")
        }
        
        if self.section == 1 && self.row == 0 {
            var code:String = field.text ?? ""
            
            if code.count > 11 {
                code = (code as NSString).substring(to: 11)
                field.text = code
            }
            self.keyInModel?.containerCode = code
        }
    }
    
    deinit {
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
}
//    var netWork:String? //网点
//    var containerCode:String? //集装箱号
//    var rentCompany:String? //租用公司
//    var tel:String? //联系电话
//    var useDate:String? //网还箱时间
//    var backDate:String? //还箱日期
//    var loadDate:String? //装载时间
//    var image1:UIImage? //
//    var image2:UIImage? //网点
//    var image3:UIImage? //网点
//    var goodName:String? //网点
//    var goodInName:String? //网点
//    var net_weight:String? //净重
//    var gross_weight:String? //毛重
//    var tj:String? //体积
//    var unitNumber:String? //件数
//    var sfsj:String? //石峰时间
//    var seal_code:String? //是封号
//    var tarpaulin_number:String? //彭不好
