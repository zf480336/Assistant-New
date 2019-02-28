//
//  UserInfoViewController.swift
//  Assistant
//
//  Created by lxy on 2018/12/10.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
class UserInfoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var quitBtn: UIButton!
//    let user:User = MyConfig.shareConfig().user!
    
    var mj_header:MJRefreshNormalHeader = MJRefreshNormalHeader()
    var userViewModel:UserViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setRefresh()
        ViewSetCorner.setCornerRadius(corner: 4, view: self.quitBtn)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getData() -> Void {
        self.userViewModel = UserViewModel.init()
        let token = UserDefaults.standard.value(forKey: TOKEN)
        self.userViewModel?.headerDic.setValue(token, forKey: TOKEN)
        self.userViewModel?.setRequestDic()
        self.userViewModel?.getUserInfo(dic: self.userViewModel!.data)
        self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tableView.mj_header.beginRefreshing()
    }
    
    func setTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        self.tableView.backgroundColor = Color_VcBack
        self.title = "个人资料"
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRefresh() -> Void {
        self.mj_header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = self.mj_header
    }
    
    @objc func headerRefresh() -> Void {
        getData()
    }
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 4
        }
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:UserInfoHeadCell = tableView.dequeueReusableCell(withIdentifier: "UserInfoHeadCell") as! UserInfoHeadCell
            cell.setHeadImageView()
            return cell
        }else{
            let cell:UserInfoCell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell") as! UserInfoCell
            
            if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.titleLabel.text = "姓名"
                    cell.titleDetailLabel.text = self.userViewModel?.userInfoModel?.userInfo?.login_name
                }else if indexPath.row == 1 {
                    cell.titleLabel.text = "部门"
                    cell.titleDetailLabel.text = self.userViewModel?.userInfoModel?.userInfo?.organization_name
                }else if indexPath.row == 2 {
                    cell.titleLabel.text = "工号"
                    cell.titleDetailLabel.text = self.userViewModel?.userInfoModel?.userInfo?.user_code
                }else{
                    cell.titleLabel.text = "电话"
                    cell.titleDetailLabel.text = self.userViewModel?.userInfoModel?.userInfo?.phone
//                    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                }
            }else{
                cell.titleLabel.text = "网点"
                cell.titleDetailLabel.textAlignment = NSTextAlignment.right
                cell.titleDetailLabel.text = self.userViewModel?.userInfoModel?.entrepot?.entrepotName ?? "未设定网点信息"
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            
            return cell
        }
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
    
    @IBAction func pressQuitBtn(_ sender: Any) {
        
        MyConfig.shareConfig().user = nil
        UserDefaults.standard.removeObject(forKey: TOKEN)
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = controller
        appdelegate.window?.makeKeyAndVisible()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 0 {
            
            let controller = PickHeadViewController.init(firtsTitle: "从相册中选择", secondTitle: "拍照", threedTitlt: "取消")
            controller.getImageBlock = {(image:UIImage) in
                
                //MARK: - 上传头像
                self.userViewModel?.params.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
                self.userViewModel?.headerDic.setValue(MyConfig.shareConfig().user?.id, forKey: "userId")
                self.userViewModel?.setRequestDic()
                self.userViewModel?.getChangeUserHeadPt(dic: (self.userViewModel?.data)!, image: image)
                self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
                    if isEnd {
                        self.tableView.mj_header.beginRefreshing()
                    }else{
                        MBProgressHUD.showTipMessage(inWindow: "请求失败", timer: 1)
                    }
                }
            }
            controller.view.backgroundColor = UIColor.white.withAlphaComponent(0)
            self.present(controller, animated: true, completion: nil)
            
        }else if indexPath.section == 2{
            let controller = UserEstablishController.init(style: UITableViewStyle.plain)
            self.navigationController?.pushViewController(controller, animated: true)

        }else if indexPath.section == 1 && indexPath.row == 3 {
            
//            let changePhone = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePhoneController")
//            self.navigationController?.pushViewController(changePhone, animated: true)
            
        }
    }
}
