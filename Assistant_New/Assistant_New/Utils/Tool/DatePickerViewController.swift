//
//  DatePickerViewController.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class DatePickerViewController: BackViewController {

    var timeBlock:((_ time:String) -> Void)?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        self.dateLabel.text = formatter.string(from:Date.init())
        self.datePicker.addTarget(self, action: #selector(ChangeDate(datePicker:)), for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func ChangeDate(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        self.dateLabel.text = formatter.string(from: datePicker.date)
        
    }

    
    @IBAction func pressCancleBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressFinishBtn(_ sender: Any) {
        if (self.dateLabel.text?.count)! > 0 {
            if (self.timeBlock != nil){
                self.timeBlock!(self.dateLabel.text!)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
