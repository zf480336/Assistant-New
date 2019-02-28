//
//  HandleShipController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class HandleShipController: BaseViewController,UITextFieldDelegate {

    var model:WayBilldetailModel?
    var homeViewModel:HomeViewModel?
    var handleModel:HandleModel = HandleModel()
    var containModelArray:NSMutableArray?
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var carField: UITextField!
    @IBOutlet weak var startCity: UIButton!
    @IBOutlet weak var endCity: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var endDateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新建发运信息"
        self.nameField.delegate = self
        self.carField.delegate = self
        self.view.backgroundColor = Color_VcBack
        ViewSetCorner.setCornerRadius(corner: 5, view: self.nextBtn)
    
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameField {
            self.handleModel.name = textField.text
        }else{
            self.handleModel.carNum = carField.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func pressStartCity(_ sender: Any) {
        let controller = HandleEstablishController.init(style: UITableViewStyle.plain)
        controller.selectBlock = {(model:entrepoModel) in

            self.handleModel.startHandModel = model
            self.setName()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func pressEndCity(_ sender: Any) {
        let controller = HandleEstablishController.init(style: UITableViewStyle.plain)
        controller.selectBlock = {(model:entrepoModel) in
            self.handleModel.endHandModel = model
            self.setName()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func setName() -> Void {
        if ((self.handleModel.startHandModel?.name) != nil) {
            self.startCity.setTitle(self.handleModel.startHandModel?.name, for: UIControlState.normal)
        }else{
            self.startCity.setTitle("请选择", for: UIControlState.normal)
        }
        if ((self.handleModel.endHandModel?.name) != nil) {
            self.endCity.setTitle(self.handleModel.endHandModel?.name, for: UIControlState.normal)
        }else{
            self.endCity.setTitle("请选择", for: UIControlState.normal)
        }
        if ((self.handleModel.startTime) != nil) {
            self.dateBtn.setTitle(self.handleModel.startTime, for: UIControlState.normal)
        }else{
            self.dateBtn.setTitle("请选择", for: UIControlState.normal)
        }
        
        if ((self.handleModel.endTime) != nil) {
            self.endDateBtn.setTitle(self.handleModel.endTime, for: UIControlState.normal)
        }else{
            self.endDateBtn.setTitle("请选择", for: UIControlState.normal)
        }
    }
    
    @IBAction func pressDateBtn(_ sender: Any) {
        let controller = DatePickerViewController.init(nibName: "DatePickerViewController", bundle: nil)
        controller.timeBlock = {(time:String) in
            self.handleModel.startTime = (time as NSString).substring(to: 10)
            self.setName()
        }
        controller.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        self.present(controller, animated: false, completion: nil)
    }
    
    @IBAction func pressEndDateBtn(_ sender: Any) {
        
        let controller = DatePickerViewController.init(nibName: "DatePickerViewController", bundle: nil)
        controller.timeBlock = {(time:String) in
            self.handleModel.endTime = (time as NSString).substring(to: 10)
            self.setName()
        }
        controller.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        self.present(controller, animated: false, completion: nil)
        
    }
    
    
    
    @IBAction func pressChangeBtn(_ sender: Any) {
        
        if (self.handleModel.startHandModel != nil) && (self.handleModel.endHandModel != nil) && (self.handleModel.startTime != nil) && (self.handleModel.endTime != nil) {
            let tempModel:entrepoModel = self.handleModel.startHandModel!
            self.handleModel.startHandModel = self.handleModel.endHandModel
            self.handleModel.startHandModel = tempModel
            
            let tempTime:String = self.handleModel.startTime!
            self.handleModel.startTime = self.handleModel.endTime
            self.handleModel.endTime = tempTime
            
            self.setName()
        }else{
            MBProgressHUD.showTipMessage(inWindow: "请选择起始网点", timer: 1)
        }
    }
    
    @IBAction func pressNextBtn(_ sender: Any) {
        
        if self.handleModel.name == nil || self.handleModel.carNum == nil || self.handleModel.startHandModel == nil || self.handleModel.endHandModel == nil || self.handleModel.startTime == nil || self.handleModel.endTime == nil {
            MBProgressHUD.showTipMessage(inWindow: "请完善全部信息", timer: 1)
            return
        }
        
        
        let controller = TieViewController.init(style: UITableViewStyle.plain)
        controller.model = self.model
        controller.handleModel = self.handleModel
        controller.containModelArray  = self.containModelArray
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
