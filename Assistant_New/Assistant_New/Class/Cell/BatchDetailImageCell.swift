//
//  BatchDetailImageCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

protocol ImageBtnClicked {
    func imageClicked(num:Int)
    func deleteClicked()
}

class BatchDetailImageCell: BaseTableViewCell {

    var imageViewDelegate:ImageBtnClicked?
    var ketInmodel:KeyInModel?
    
    var KeyinModel:Any?{
        set{
            let keyModel = newValue as? KeyInModel
            if ((keyModel?.image1) != nil) {
                self.buttonOne.setBackgroundImage(keyModel?.image1, for: UIControlState.normal)
            }else{
                self.buttonOne.setBackgroundImage(UIImage.init(named: "icon_load"), for: UIControlState.normal)
            }
            if ((keyModel?.image2) != nil) {
                self.buttonTwo.setBackgroundImage(keyModel?.image2, for: UIControlState.normal)
            }else{
                self.buttonTwo.setBackgroundImage(UIImage.init(named: "icon_load"), for: UIControlState.normal)
            }
            if ((keyModel?.image3) != nil) {
                self.buttonThree.setBackgroundImage(keyModel?.image3, for: UIControlState.normal)
            }else{
                self.buttonThree.setBackgroundImage(UIImage.init(named: "icon_load"), for: UIControlState.normal)
                
            }
            self.ketInmodel = keyModel
        }
        get{
            return nil
        }
    }
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var deleteBtn1: UIButton!
    @IBOutlet weak var deleteBtn2: UIButton!
    @IBOutlet weak var deleteBtn3: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longGester1 = UILongPressGestureRecognizer.init(target: self, action: #selector(longpressBtn1))
        longGester1.minimumPressDuration = 1.5
        self.buttonOne.addGestureRecognizer(longGester1)
        let longGester2 = UILongPressGestureRecognizer.init(target: self, action: #selector(longpressBtn2))
        longGester2.minimumPressDuration = 1.5
        self.buttonTwo.addGestureRecognizer(longGester2)
        let longGester3 = UILongPressGestureRecognizer.init(target: self, action: #selector(longpressBtn3))
        longGester3.minimumPressDuration = 1.5
        self.buttonThree.addGestureRecognizer(longGester3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func pressFirstBrn(_ sender: Any) {
         self.deleteBtn1.isHidden = true
        if (self.imageViewDelegate != nil) {
            self.imageViewDelegate?.imageClicked(num: 1)
        }
    }
    
    @IBAction func pressSecondBrn(_ sender: Any) {
        self.deleteBtn2.isHidden = true
        if (self.imageViewDelegate != nil) {
            self.imageViewDelegate?.imageClicked(num: 2)
        }
    }
    
    @IBAction func pressThreeBrn(_ sender: Any) {
        self.deleteBtn3.isHidden = true
        if (self.imageViewDelegate != nil) {
            self.imageViewDelegate?.imageClicked(num: 3)
        }
    }
    @objc func longpressBtn1() -> Void {
        if ((self.ketInmodel?.image1) != nil) {
            self.deleteBtn1.isHidden = false
        }

    }
    @objc func longpressBtn2() -> Void {
        if ((self.ketInmodel?.image2) != nil) {
            self.deleteBtn2.isHidden = false
        }
        
    }
    @objc func longpressBtn3() -> Void {
        if ((self.ketInmodel?.image3) != nil) {
            self.deleteBtn3.isHidden = false
        }
    }
    
    @IBAction func pressDeleteBtn1(_ sender: Any) {
        self.ketInmodel?.image1 = nil
        if (self.imageViewDelegate != nil) {
            self.imageViewDelegate?.imageClicked(num: 0)
        }
    }
    
    @IBAction func pressDeleteBtn2(_ sender: Any) {
        self.ketInmodel?.image2 = nil
        if (self.imageViewDelegate != nil) {
            self.imageViewDelegate?.imageClicked(num: 0)
        }
    }
    
    @IBAction func pressDeleteBtn3(_ sender: Any) {
        self.ketInmodel?.image3 = nil
        if (self.imageViewDelegate != nil) {
            self.imageViewDelegate?.imageClicked(num: 0)
        }
    }
    
}
