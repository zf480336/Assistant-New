//
//  ChangePhoneController.swift
//  Assistant
//
//  Created by lxy on 2018/12/13.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class ChangePhoneController: BaseViewController {

    @IBOutlet weak var phoneField: UITextField!
    var userViewModel:UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "更换手机号"
        self.NaviRight?.isHidden = false
        self.NaviRight?.setTitle("保存", for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldValueChanged(noti:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    
    @objc fileprivate func textFieldValueChanged(noti:NSNotification) -> Void {
        let field = noti.object as! UITextField;
        if (field.markedTextRange != nil) {
            return;
        }
        if (field.text?.contains(" "))! {
            field.text = field.text?.replacingOccurrences(of: " ", with: "")
        }
        if !YMKJVerificationTools.isAvailableNumber(field.text) {
            if (field.text?.count)! > 1 {
                field.text = (field.text! as NSString).substring(to: (field.text?.count)! - 1)
            }
        }
    }
    override func pressNaviRight() {
        //FIXME: 校验
        let ret = YMKJVerificationTools.isAvailablePhoneNumber(self.phoneField.text)
        if ret {
            self.userViewModel = UserViewModel.init()
//            let userid = MyConfig.shareConfig().user?.id
//            self.userViewModel?.headerDic.setValue(userid, forKey: "userId")
            //FIXME: 设置参数
            self.userViewModel?.setRequestDic()
            self.userViewModel?.getChangeUserPhone(dic: self.userViewModel!.data)
            self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                if isEnd {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            //FIXME: 弹框，手机号格式不正确
        }
    }
    

}
