//
//  MainHeadView.swift
//  Assistant
//
//  Created by lxy on 2018/12/12.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

protocol HeadViewDelegate {
    func pressSearchBtn()
    func pressCodeBtn()
    func pressStatusBtn(str:String)
    func pressHeadImageView()
    func pressDeleteBtn()
}

class MainHeadView: UIView {

    var mainHeadDelegate : HeadViewDelegate?
    
    var config:MyConfig?
    
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var topLine: NSLayoutConstraint!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userStatusBtn: UIButton!
    @IBOutlet weak var userTypeBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var fileContentView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    private var myContext = 0
   
    override func awakeFromNib() {
        super.awakeFromNib()
        

        self.config = MyConfig.shareConfig()
//        self.config?.addObserver(self, forKeyPath: "entrepotName", options: [.new,.old], context: &myContext)
        
        HexColor.graduaBackColor(beginColor: HexColor.getHex(hexString: "#3CA0F4", alpha: 1), endColor: HexColor.getHex(hexString: "#3CA0F4", alpha: 0.78), view: self.topView)
        ViewSetCorner.setCornerRadius(corner: Int(self.fileContentView.bounds.size.height/2), view: self.fileContentView)
        ViewSetCorner.setCornerRadius(corner: Int(self.headImageView.bounds.size.height/2), view: self.headImageView)
        ViewSetCorner.setCornerRadius(corner: Int(self.userTypeBtn.bounds.size.height/2), view: self.userTypeBtn)
        ViewSetCorner.setBorders(boardWidth: 1, view: self.userStatusBtn, color: HexColor.getHex(hexString: "#3CA0F4", alpha: 1))
        ViewSetCorner.setCornerRadius(corner: Int(self.userStatusBtn.bounds.size.height/2), view: self.userStatusBtn)
        
        let tapGester = UITapGestureRecognizer.init(target: self, action: #selector(TipHeadImageView))
        self.headImageView.isUserInteractionEnabled = true
        self.headImageView.addGestureRecognizer(tapGester)
    }
    
    //MARK: - 刷新头像
    public func refreshConfig() {
        self.addressBtn.setTitle(MyConfig.shareConfig().entrepotName, for: UIControlState.normal)
        guard let url = MyConfig.shareConfig().user?.icon else {
            printLog(message: "没有设置头像")
            return
        }
        let headString = NSString.init(format: "%@%@",BaseImageUrl,url)
        self.headImageView.setImageWith(URL.init(string: headString as String)!, placeholderImage: UIImage.init(named: "tempHead"))
    }
    //MARK: - 刷新上班状态
    public  func refreshUserType(userTypeModel:UserAttendanceModel) -> Void {
        if userTypeModel.userAttendance?.attendance_status == "1" {
            self.userTypeBtn.setTitle("已上班", for: UIControlState.normal)
        }else{
            self.userTypeBtn.setTitle("已下班", for: UIControlState.normal)
        }
    }
    //MARK: - 刷新搜索
    func refreshSearchBtn(key:String) -> Void {
        if key.count == 0 {
            self.searchBtn.setTitle("搜索运单箱号信息", for: UIControlState.normal)
            self.deleteBtn.isHidden = true
        }else{
            self.searchBtn.setTitle(key, for: UIControlState.normal)
            self.deleteBtn.isHidden = false
        }
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        let newValue = change![.newKey] as? String
//        let oldValue = change![.oldKey] as? String
//        print("newValue: \(newValue), oldValue: \(oldValue)")
//        if context == &myContext {
//            guard let key = keyPath,
//                let change = change,
//                let newValue = change[.newKey] as? String,
//                let oldValue = change[.oldKey] as? String
//                else{
//                    return
//            }
//            if key == "entrepotName" {
//
//            }
//
//        }else{
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//        }
//    }
    
    @objc func TipHeadImageView() -> Void {
        if self.mainHeadDelegate != nil  {
            self.mainHeadDelegate?.pressHeadImageView()
        }
    }
    
    func setUserInfo(model:UserInfo) -> Void {
//        let user:User = MyConfig.shareConfig().user!
        
        let addressEntrepotName = MyConfig.shareConfig().entrepotName ?? "未设定网点信息"
        
        self.addressBtn.setTitle(addressEntrepotName, for: UIControlState.normal)
//        self.headImageView.setImageWith(URL.init(string: "")!, placeholderImage: UIImage.init(named: ""))
        self.nameLabel.text = model.userInfo?.login_name

        guard let _ = model.entrepot?.type_code else {
           
            self.userStatusBtn.setTitle("暂无", for: UIControlState.normal)
            return
        }
        let ret:UserTypeCode = UserTypeCode(rawValue: (model.entrepot?.type_code)!)!
        
        switch ret {
        case .公路:
             self.userStatusBtn.setTitle("公路", for: UIControlState.normal)
            break
        case .海运:
             self.userStatusBtn.setTitle("海运", for: UIControlState.normal)
            break
        case .铁路:
             self.userStatusBtn.setTitle("铁路", for: UIControlState.normal)
            break
        case .暂无: break
            
        }
        
    }
    
    
    @IBAction func pressCodeBtn(_ sender: Any) {
        if self.mainHeadDelegate != nil  {
            self.mainHeadDelegate?.pressCodeBtn()
        }
    }
    
    @IBAction func pressStatusBtn(_ sender: Any) {
        if self.mainHeadDelegate != nil  {
            self.mainHeadDelegate?.pressStatusBtn(str: (self.userTypeBtn.titleLabel?.text)!)
        }
    }
    @IBAction func pressSearchBtn(_ sender: Any) {
        if self.mainHeadDelegate != nil  {
            self.mainHeadDelegate?.pressSearchBtn()
        }
    }
    
    @IBAction func pressDeleteBtn(_ sender: Any) {
        
        self.searchBtn.setTitle("搜索运单箱号信息", for: .normal)
        self.deleteBtn.isHidden = true
        if self.mainHeadDelegate != nil  {
            self.mainHeadDelegate?.pressDeleteBtn()
        }
    }
}
