//
//  GoodsKeyInViewController.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class GoodsKeyInViewController: Good_Detail_WaitAcceptController,ButtonClickedDelegate,ImageBtnClicked {
    
    var keyInModel:KeyInModel = KeyInModel()
    var keyInViewModel:GoodKeyInViewModel?
    var boxModel:OrderContainer_listModel?
    var box_Model:Good_OrderContainerModel?
    var refreshBlock:(()->())? 
    var enportSelectBlock:((_ name:String) -> Void)?
    
    let titleLabelArray = [["网点"],
                            ["集装箱号 *","租用公司","联系电话","用箱时间","还箱日期","装载时间",""],
                            ["货品名称 *","","净重(吨)","毛重(吨)","体积(立方米)","件数"],
                            ["施封时间","施封号","篷布号"],
                            [""]]
    let placeHoldArray = [[""],
                            ["输入11位集装箱号(必填*)","输入租用公司","输入联系电话","","","",""],
                            ["","输入货品名称","输入净重","输入毛重","输入体积","输入件数"],
                            ["","输入施封号","输入篷布号"],
                            [""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "货箱详情"

        self.NaviRight?.isHidden = false
        self.NaviRight?.setTitle("保存", for: UIControlState.normal)
        
        self.tableView.register(UINib.init(nibName: "GoodKeyInCell", bundle: nil), forCellReuseIdentifier: "GoodKeyInCell")
        self.tableView.register(UINib.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(UINib.init(nibName: "BatchDetailImageCell", bundle: nil), forCellReuseIdentifier: "BatchDetailImageCell")
        
        if self.keyInModel.netWork == nil && self.keyInModel.netWorkid == nil {
            self.keyInModel.netWork = MyConfig.shareConfig().entrepotName
            self.keyInModel.netWorkid = MyConfig.shareConfig().entrepot_id
        }
    }
    override func setViewModel() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.box_Model == nil && self.boxModel == nil {
            return 4
        }
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titleLabelArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell:GoodKeyInCell = tableView.dequeueReusableCell(withIdentifier: "GoodKeyInCell") as! GoodKeyInCell
            cell = Bundle.main.loadNibNamed("GoodKeyInCell", owner: self, options: nil)?.first as! GoodKeyInCell
            cell.settitleLabelAndTextField(keyinModel: self.keyInModel, section: indexPath.section, row: indexPath.row)
            cell.titleLabel.text = self.titleLabelArray[indexPath.section][indexPath.row]
            cell.textField.isEnabled = false
            cell.textField.text = self.keyInModel.netWork
//            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            return cell
            
        }else if (indexPath.section == 1){
            
            var cell:GoodKeyInCell = tableView.dequeueReusableCell(withIdentifier: "GoodKeyInCell") as! GoodKeyInCell
            cell = Bundle.main.loadNibNamed("GoodKeyInCell", owner: self, options: nil)?.first as! GoodKeyInCell
            cell.settitleLabelAndTextField(keyinModel: self.keyInModel, section: indexPath.section, row: indexPath.row)
            cell.titleLabel.text = self.titleLabelArray[indexPath.section][indexPath.row]
            cell.textField.placeholder = self.placeHoldArray[indexPath.section][indexPath.row]
            
            if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textField.isEnabled = false
            }
            if indexPath.row == 2{
                cell.textField.keyboardType = UIKeyboardType.numberPad
            }
            if indexPath.row == 6 {
                var cell:BatchDetailImageCell = tableView.dequeueReusableCell(withIdentifier: "BatchDetailImageCell") as! BatchDetailImageCell
                cell = Bundle.main.loadNibNamed("BatchDetailImageCell", owner: self, options: nil)?.first as? UITableViewCell as! BatchDetailImageCell
                cell.imageViewDelegate = self
                cell.KeyinModel = self.keyInModel
                return cell
            }
            
            return cell
            
        }else if (indexPath.section == 2){
            
            var cell:GoodKeyInCell = tableView.dequeueReusableCell(withIdentifier: "GoodKeyInCell") as! GoodKeyInCell
            cell = Bundle.main.loadNibNamed("GoodKeyInCell", owner: self, options: nil)?.first as! GoodKeyInCell
            cell.settitleLabelAndTextField(keyinModel: self.keyInModel, section: indexPath.section, row: indexPath.row)
            cell.titleLabel.text = self.titleLabelArray[indexPath.section][indexPath.row]
            cell.textField.placeholder = self.placeHoldArray[indexPath.section][indexPath.row]
            
            if (indexPath.row == 0){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textField.isEnabled = false
            }
            if indexPath.row != 1{
                cell.textField.keyboardType = UIKeyboardType.decimalPad
            }
            return cell
            
        }else if (indexPath.section == 3){
            
            var cell:GoodKeyInCell = tableView.dequeueReusableCell(withIdentifier: "GoodKeyInCell") as! GoodKeyInCell
            cell = Bundle.main.loadNibNamed("GoodKeyInCell", owner: self, options: nil)?.first as! GoodKeyInCell
            cell.settitleLabelAndTextField(keyinModel: self.keyInModel, section: indexPath.section, row: indexPath.row)
            cell.titleLabel.text = self.titleLabelArray[indexPath.section][indexPath.row]
            cell.textField.placeholder = self.placeHoldArray[indexPath.section][indexPath.row]
            
            if (indexPath.row == 0){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textField.isEnabled = false
            }
            
            return cell
            
        }else{
            
            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as! ButtonCell
            cell.button.backgroundColor = HexColor.getHex(hexString: "#D0021B", alpha: 1)
            cell.button.setTitle("删除该货品", for: UIControlState.normal)
            cell.clickDelegate = self
            return cell
        }
    }
    
    
    //MARK: - Header AND Footer
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return CGFloat.leastNormalMagnitude
        }else if section == 4{
             return 20.0
        }else{
            return 50.0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 0 || section == 4 {
            return UIView()
        }
        let headView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 50))
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 15))
        topView.backgroundColor = Color_VcBack
        let line = UIView.init(frame: CGRect.init(x: 0, y: 49, width: SCREEN_W, height: 1))
        line.backgroundColor = Color_VcBack
        let label:UILabel = UILabel.init(frame: CGRect.init(x: 18, y: 15, width: SCREEN_W-36, height: 34))
        headView.backgroundColor = UIColor.white
        if section == 1 {
            label.text = "集装箱信息"
        }else if section == 2{
            label.text = "货品信息"
        }else{
            label.text = "施封信息"
        }
        
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = HexColor.getHex(hexString: "#3BA0F3", alpha: 1)
        headView.addSubview(topView)
        headView.addSubview(line)
        headView.addSubview(label)
        return headView
    }


    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        return footView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    //MARK: - Action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.section == 1 && (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 )) || (indexPath.section == 3 && indexPath.row == 0){
            let controller = DatePickerViewController.init(nibName: "DatePickerViewController", bundle: nil)
            controller.timeBlock = {(time:String) in
                if indexPath.row == 0 {
                    self.keyInModel.sfsj = time
                }else if indexPath.row == 3 {
                    self.keyInModel.useDate = time
                }else if indexPath.row == 4 {
                    self.keyInModel.backDate = time
                }else{
                    self.keyInModel.loadDate = time
                }
                self.tableView.reloadData()
            }
            controller.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
            self.present(controller, animated: false, completion: nil)
        }else if (indexPath.section == 2 && indexPath.row == 0){
            //FIXME: 跳转货品选择列表(回调拿到货品名称)
            let goodsearch = GoodSearchController()
            goodsearch.goodNameBlock = {(name:String) ->() in
                self.keyInModel.goodName = name
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(goodsearch, animated: true)
        }else if(indexPath.section == 0){
            
//            let controller:UserEstablishController = UserEstablishController.init(style: UITableViewStyle.plain)
//            controller.isKeyInStatus = true
//            controller.changeKeyInBlock = {(model:entrepotsModel) in
//                self.keyInModel.netWork = model.entrepotName
//                self.keyInModel.netWorkid = model.entrepot_id
//                self.tableView.reloadData()
//            }
//            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    
    override func pressNaviRight() {
        
        self.view.endEditing(true)
        
        guard let _ = self.keyInModel.containerCode else {
            MBProgressHUD.showTipMessage(inWindow: "集装箱号不可为空", timer: 1)
            return
        }
        
        var edit:Bool = false
        self.keyInModel.orderID = self.orderModel?.id
        self.keyInViewModel = GoodKeyInViewModel()
        if self.box_Model != nil {
            self.keyInModel.orderContainerId = self.box_Model?.id
            edit = true
        }
        if self.boxModel != nil {
            self.keyInModel.orderContainerId = self.boxModel?.id
            edit = true
        }
       
        self.keyInViewModel?.getGoodKeyInTask(dic: ["":""], model: self.keyInModel,isEdit: edit)
        self.keyInViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if isEnd {
                self.enportSelectBlock?("name")
//                self.navigationController?.popViewController(animated: true)
                for controller in (self.navigationController?.viewControllers)! {
                    if controller.isMember(of: Good_Detail_WaitAcceptController.self) == true
                    {
                        (controller as! Good_Detail_WaitAcceptController).setViewModel()
                        self.navigationController?.popToViewController(controller, animated: true)
                    }
                    if controller.isMember(of: Good_Detail_HadAcceptController.self) == true
                    {
                        (controller as! Good_Detail_HadAcceptController).setViewModel()
                        self.navigationController?.popToViewController(controller, animated: true)
                    }
                    if controller.isMember(of: ConsigneeController.self) == true
                    {
                        (controller as! ConsigneeController).setViewModel()
                        (controller as! ConsigneeController).selectArray?.removeAllObjects()
                        self.navigationController?.popToViewController(controller, animated: true)
                    }
                    if controller.isMember(of: ConfirmAcceptController.self) == true
                    {
                        (controller as! ConfirmAcceptController).setViewModel()
                        self.navigationController?.popToViewController(controller, animated: true)

                    }
                   
                }

            }
        }
    }
    
    func buttoClickedAction() {
        print("ssss")
    }

    
    //MARK: - ImageDelegate
    func imageClicked(num: Int) {
        if num == 0 {
            self.tableView.reloadData()
        }else{
            let controller = PickHeadViewController.init(firtsTitle: "从相册中选择", secondTitle: "拍照", threedTitlt: "取消")
            controller.view.backgroundColor = UIColor.white.withAlphaComponent(0)
            controller.getImageBlock = { (image:UIImage) in
                if num == 1 {
                    self.keyInModel.image1 = image
                }else if num == 2 {
                    self.keyInModel.image2 = image
                }else{
                    self.keyInModel.image3 = image
                }
                self.tableView.reloadData()
            }
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func deleteClicked() {
        self.tableView.reloadData()
    }

}
