//
//  SelectView.swift
//  Assistant
//
//  Created by lxy on 2019/1/3.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit
protocol selectDelegate {
    func pressSelect(ret:Bool)
}
class SelectView: UIView {

    var selectDelegate:selectDelegate?
    
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func pressSelectBtn(_ sender: Any) {
        
        if self.selectBtn.titleLabel?.text == "全选" {
            self.selectBtn.setTitle("取消全选", for: UIControlState.normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "finish"), for: UIControlState.normal)
        }else{
            self.selectBtn.setTitle("全选", for: UIControlState.normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "Shape"), for: UIControlState.normal)
        }
        
        if self.selectDelegate != nil {
            if self.selectBtn.titleLabel?.text == "全选" {
                self.selectDelegate?.pressSelect(ret: true)
            }else{
                self.selectDelegate?.pressSelect(ret: false)
            }
            
        }
    }
    
    func setOriginStatus() -> Void {
        self.selectBtn.setTitle("全选", for: UIControlState.normal)
        self.statusBtn.setBackgroundImage(UIImage.init(named: "Shape"), for: UIControlState.normal)
    }
}
