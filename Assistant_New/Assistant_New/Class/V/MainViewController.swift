//
//  MainViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
//我的任务
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HeadViewDelegate {
    
    
   
    
    
    @IBOutlet weak var tableView: UITableView!

    var homeViewModel:HomeViewModel = HomeViewModel.init()
    var userViewModel:UserViewModel?
    
    var mj_head = MJRefreshNormalHeader()
    var mj_footer = MJRefreshAutoStateFooter()
    
    lazy var headView:MainHeadView = {
        let view:MainHeadView = Bundle.main.loadNibNamed("MainHeadView", owner: self, options: nil)?.first as! MainHeadView
        view.backgroundColor = UIColor.white
        view.mainHeadDelegate = self
        if IPHONE_X() || IPHONE_XS_MAX() {
            view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 348)
        }else{
            view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 334)
        }
        
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setTableView()
        setRefresh()
        getData()
    }
    
    func getData() {
   
        //用户信息
        self.userViewModel = UserViewModel.init()
        let token = UserDefaults.standard.value(forKey: TOKEN)
        self.userViewModel?.headerDic.setValue(token, forKey: TOKEN)
        self.userViewModel?.setRequestDic()
        self.userViewModel?.getUserInfo(dic: self.userViewModel!.data)
        self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if isEnd {
                self.headView.setUserInfo(model: (self.userViewModel?.userInfoModel)!)
            }
            //签到信息
            self.homeViewModel.headerDic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
            self.homeViewModel.setRequestDic()
            self.homeViewModel.getSignInfoOperation(dic: self.homeViewModel.data,curtenIndex: 1)
            self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                if self.homeViewModel.userAttendanceModel != nil {
                    self.headView.refreshUserType(userTypeModel: self.homeViewModel.userAttendanceModel!)
                }
                
                if MyConfig.shareConfig().entrepot_id == "" {
                    let controller = UserEstablishController.init(style: UITableViewStyle.plain)
                    controller.isPresent = true
                    controller.enportSelectBlock = {
                        self.getData()
                    }
                    self.present(controller, animated: true, completion: nil)
                    return
                }
                self.homeViewModel.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
    
                self.homeViewModel.params.setValue("1", forKey: "page")
                self.homeViewModel.params.setValue(["3","4","5"], forKey: "status")
                self.homeViewModel.params.setValue("1", forKey: "page")
                self.homeViewModel.params.setValue("6", forKey: "limit")
                self.homeViewModel.setRequestDic()
                self.homeViewModel.getRunningTask(dic: self.homeViewModel.data,curtenIndex: 1)
                self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                    self.tableView.reloadData()
                }
                
            
            }
        }

    }
    
    
    func setRefresh() -> Void {
        
        self.mj_head.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = self.mj_head

        self.mj_footer.setTitle("更多数据请前往我的任务", for: .idle)
        self.mj_footer.setTitle("更多数据请前往我的任务", for: .willRefresh)
        self.mj_footer.setTitle("更多数据请前往我的任务", for: .refreshing)
        self.mj_footer.setTitle("更多数据请前往我的任务", for: .noMoreData)
        self.tableView.mj_footer = self.mj_footer
        
    }
    
    @objc func fooRefresh() -> Void {
        self.tableView.mj_footer.endRefreshing()
        
    }
    @objc func headerRefresh() -> Void {
        self.homeViewModel.getRunningTask(dic: homeViewModel.data,curtenIndex: 1)
        self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
    //MARK: - 视图设置
    
    private func setViews() -> Void {
        self.view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        self.navigationItem.titleView = UIView()
    }
    
    //MARK: - 设置tableView
    func setTableView() -> Void {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.tableHeaderView = self.headView
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        if (MyConfig.shareConfig().entrepotName != nil) {
             self.headView.refreshConfig()
        } 
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableViewDeleate
    func numberOfSections(in tableView: UITableView) -> Int {
        if ((self.homeViewModel.dataArray.count) != 0) {
            return (self.homeViewModel.dataArray.count);
        }
        return 0;
        
        //FIXME: 此处需要添加实现
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainMyCell:MainMyCell = tableView.dequeueReusableCell(withIdentifier: "MainMyCell", for: indexPath) as! MainMyCell
        mainMyCell.model = self.homeViewModel.dataArray[indexPath.section]
        return mainMyCell
    }
    
    //MARK: - Header AND Footer
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK: - Action

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:detailModel = self.homeViewModel.dataArray[indexPath.section] as! detailModel
        if model.statusName == "待发运" {
            let detail_Controller = ConsigneeController.init(style: UITableViewStyle.plain)
            detail_Controller.detailModel = model
            self.navigationController?.pushViewController(detail_Controller, animated: true)
            
        }else if model.statusName == "待收货" {
            let detail_Controller = AcceptDetailController.init(style: UITableViewStyle.plain)
            detail_Controller.detailModel = model
            self.navigationController?.pushViewController(detail_Controller, animated: true)
            
        }else{
            let detail_Controller = PayDetailController.init(style: UITableViewStyle.plain)
            detail_Controller.detailModel = model
            self.navigationController?.pushViewController(detail_Controller, animated: true)
            
        }
//        let myTaslList:MyTaskList = MyTaskList.init(rawValue: model.waybillStatus!)!
//        switch myTaslList {
//        case .MyTask_Ship:
//
//            let detail_Controller = ConsigneeController.init(style: UITableViewStyle.plain)
//            detail_Controller.detailModel = self.homeViewModel.dataArray[indexPath.section]
//            self.navigationController?.pushViewController(detail_Controller, animated: true)
//
//        case .MyTask_Accept:
//
//            let detail_Controller = AcceptDetailController.init(style: UITableViewStyle.plain)
//            detail_Controller.detailModel = self.homeViewModel.dataArray[indexPath.section]
//            self.navigationController?.pushViewController(detail_Controller, animated: true)
//
//            break
//        case .MyTask_Pay:
//
//            let detail_Controller = PayDetailController.init(style: UITableViewStyle.plain)
//            detail_Controller.detailModel = self.homeViewModel.dataArray[indexPath.section]
//            self.navigationController?.pushViewController(detail_Controller, animated: true)
//
//            break
//        case .MyTask_All:
//            break
//
//        }
    }

    //MARK: - 搜索
    func pressSearchBtn() {
        let searchController:SearchController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchController") as! SearchController
        searchController.searchBlock = { (key:String) in
           
            
            
            self.homeViewModel.params.removeObject(forKey: "waybillCode")
            self.homeViewModel.params.removeObject(forKey: "carNo")
            self.homeViewModel.params.removeObject(forKey: "containerCode")
            self.homeViewModel.params.removeObject(forKey: "licensePlateNumber")
            self.homeViewModel.params.removeObject(forKey: "orderCode")
            if key.hasPrefix("WB") {
                if YMKJVerificationTools.isWayBillCode(key) {
                    self.homeViewModel.params.setValue(key, forKey: "waybillCode")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "运单号不正确", timer: 1)
                    return
                }
            }
             
            //批次号
            if key.count == 20 && key.hasPrefix("D") {
                if YMKJVerificationTools.isOrderBillCode(key) {
                    self.homeViewModel.params.setValue(key, forKey: "orderCode")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "批次号输入不正确", timer: 1)
                    return
                }
            }
            
            if key.count == 7  {
                if YMKJVerificationTools.isCarNo(key) {
                    self.homeViewModel.params.setValue(key, forKey: "carNo")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "车底号、挂车号不正确", timer: 1)
                    return
                }
            }
 
            if key.count == 11 {
                if YMKJVerificationTools.isContainerCode(key) {
                    self.homeViewModel.params.setValue(key, forKey: "containerCode")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "集装箱号不正确", timer: 1)
                    return
                }
            }
            
            
            //MARK: - 车牌号暂不校验
//            if YMKJVerificationTools.isLicensePlateNumber(key) {
//                self.homeViewModel.params.setValue(key, forKey: "licensePlateNumber")
//                self.headView.refreshSearchBtn(key: key)
//            }else{
//                MBProgressHUD.showTipMessage(inWindow: "车牌号不正确", timer: 1)
//                return
//            }
            
            self.headView.refreshSearchBtn(key: key)
            self.getKeyData()
           
        }
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    //MARK: - 搜索接口刷新
    func getKeyData() -> Void {
        self.homeViewModel.params.setValue("1", forKey: "page")
        self.homeViewModel.setRequestDic()
        self.homeViewModel.getRunningTask(dic: self.homeViewModel.data,curtenIndex: 1)
        self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            MBProgressHUD.showTipMessage(inWindow: "数据加载完成", timer: 1)
            self.tableView.reloadData()
        }
    }
    
    //MARK: - 二维码
    func pressCodeBtn() {
        let codeController:ScanViewController = ScanViewController()
        codeController.sacnBlock = { (key:String) in
            self.homeViewModel.params.removeObject(forKey: "waybillCode")
            self.homeViewModel.params.removeObject(forKey: "carNo")
            self.homeViewModel.params.removeObject(forKey: "containerCode")
            self.homeViewModel.params.removeObject(forKey: "licensePlateNumber")
            self.homeViewModel.params.removeObject(forKey: "orderCode")
            
            if key.hasPrefix("WB") {
                if YMKJVerificationTools.isWayBillCode(key) {
                    self.homeViewModel.params.setValue(key, forKey: "waybillCode")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "运单号不正确", timer: 1)
                    return
                }
            }
            
            if key.count == 7 {
                if YMKJVerificationTools.isCarNo(key) {
                    self.homeViewModel.params.setValue(key, forKey: "carNo")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "运车底号、挂车号不正确", timer: 1)
                    return
                }
            }
            
            //批次号
            if key.count == 20 &&  key.hasPrefix("D") {
                if YMKJVerificationTools.isOrderBillCode(key) {
                    self.homeViewModel.params.setValue(key, forKey: "orderCode")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "批次号不正确", timer: 1)
                    return
                }
            }
            
            if key.count == 11 {
                if YMKJVerificationTools.isContainerCode(key) {
                    self.homeViewModel.params.setValue(key, forKey: "containerCode")
                    self.headView.refreshSearchBtn(key: key)
                    self.getKeyData()
                    return
                }else{
                    MBProgressHUD.showTipMessage(inWindow: "集装箱号不正确", timer: 1)
                    return
                }
            }
            
            
            //MARK: - 车牌号暂不校验
            //            if YMKJVerificationTools.isLicensePlateNumber(key) {
            //                self.homeViewModel.params.setValue(key, forKey: "licensePlateNumber")
            //                self.headView.refreshSearchBtn(key: key)
            //            }else{
            //                MBProgressHUD.showTipMessage(inWindow: "车牌号不正确", timer: 1)
            //                return
            //            }
            
            self.headView.refreshSearchBtn(key: key)
            self.getKeyData()
        }
        self.navigationController?.pushViewController(codeController, animated: true)
    }
//    WB2018 1101 1659 4900010
    //MARK: - 签到
    func pressStatusBtn(str: String) {
       
        if self.headView.userTypeBtn.titleLabel?.text == "签到" || self.headView.userTypeBtn.titleLabel?.text == "已下班" {
            self.homeViewModel.params.setValue("1", forKey: "signType")
            self.homeViewModel.headerDic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
            self.homeViewModel.setRequestDic()
            self.homeViewModel.getDoSignOperation(dic: homeViewModel.data,curtenIndex: 1)
            self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                if isEnd {
                    self.homeViewModel.headerDic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
                    self.homeViewModel.setRequestDic()
                    self.homeViewModel.getSignInfoOperation(dic: self.homeViewModel.data,curtenIndex: 1)
                    self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                        self.headView.refreshUserType(userTypeModel: self.homeViewModel.userAttendanceModel!)
                    }
                }
            }
        }else{
            self.homeViewModel.params.setValue("0", forKey: "signType")
            self.homeViewModel.headerDic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
            self.homeViewModel.setRequestDic()
            self.homeViewModel.getDoSignOperation(dic: homeViewModel.data,curtenIndex: 1)
            self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                if isEnd {
                    self.homeViewModel.headerDic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
                    self.homeViewModel.setRequestDic()
                    self.homeViewModel.getSignInfoOperation(dic: self.homeViewModel.data,curtenIndex: 1)
                    self.homeViewModel.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                        self.headView.refreshUserType(userTypeModel: self.homeViewModel.userAttendanceModel!)
                    }
                }
            }
        }
    }
    
    //MARK: - 个人中心
    func pressHeadImageView() {
        let userInfoVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController")
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    //点击删除按钮
    func pressDeleteBtn() {
        self.homeViewModel.params.removeObject(forKey: "waybillCode")
        self.homeViewModel.params.removeObject(forKey: "carNo")
        self.homeViewModel.params.removeObject(forKey: "containerCode")
        self.homeViewModel.params.removeObject(forKey: "licensePlateNumber")
        self.homeViewModel.params.removeObject(forKey: "orderCode")
        self.getKeyData()
    }
    
}
