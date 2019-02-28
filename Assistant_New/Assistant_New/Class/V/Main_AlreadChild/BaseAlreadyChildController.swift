//
//  BaseAlreadyController.swift
//  Assistant
//
//  Created by lxy on 2018/12/3.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BaseAlreadyChildController: BaseChildTableViewController {

    var alreadyViewModel:AlreadyViewModel?
    var curttenPage:Int = 1
    var AlreadyEnum:AlreadyHandleList?
    
//    var mj_footer = MJRefreshAutoStateFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.mj_footer = nil
        
        self.tableView.register(UINib.init(nibName: "AlreadyCell", bundle: nil), forCellReuseIdentifier: "AlreadyCell")
        setRefresh()
    }

    func setViewModel() -> Void {
        self.alreadyViewModel = AlreadyViewModel.init()
        self.alreadyViewModel?.params.setValue(self.AlreadyEnum?.rawValue, forKey: "status")

    }
    
    override func headerRefresh() {
        
        self.curttenPage = 1
        self.isRefresh = true
        asyncWithParams(curIndex: self.curttenPage)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func asyncWithParams(curIndex:Int) -> Void {
        
        
//        self.alreadyViewModel?.params.removeObject(forKey: "waybillCode")
//        self.alreadyViewModel?.params.removeObject(forKey: "carNo")
//        self.alreadyViewModel?.params.removeObject(forKey: "containerCode")
//        self.alreadyViewModel?.params.removeObject(forKey: "licensePlateNumber")
        
//        let key = self.code ?? ""
//
//        if key.hasPrefix("WB") {
//            if YMKJVerificationTools.isWayBillCode(key) {
//                self.alreadyViewModel?.params.setValue(key, forKey: "waybillCode")
//
//            }else{
//                MBProgressHUD.showTipMessage(inWindow: "运单号不正确", timer: 1)
//                self.tableView.mj_header.endRefreshing()
//                return
//            }
//        }
//
//        if key.count == 7 {
//            if YMKJVerificationTools.isCarNo(key) {
//                self.alreadyViewModel?.params.setValue(key, forKey: "carNo")
//
//            }else{
//                MBProgressHUD.showTipMessage(inWindow: "运车底号、挂车号不正确", timer: 1)
//                self.tableView.mj_header.endRefreshing()
//                return
//            }
//        }
//
//        if key.count == 11 {
//            if YMKJVerificationTools.isContainerCode(key) {
//                self.alreadyViewModel?.params.setValue(key, forKey: "containerCode")
//            }else{
//                MBProgressHUD.showTipMessage(inWindow: "集装箱号不正确", timer: 1)
//                self.tableView.mj_header.endRefreshing()
//                return
//            }
//        }
        
        self.alreadyViewModel?.params.setValue(String(curIndex), forKey: "page")
        self.alreadyViewModel?.params.setValue(pageNum, forKey: "limit")
        self.alreadyViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        self.alreadyViewModel?.setRequestDic()
        self.alreadyViewModel?.getRunningOrderContainer(dic: self.alreadyViewModel!.data,curtenIndex: curIndex)
        self.alreadyViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
           
            if array.count == 0 {
                self.mj_footer.setTitle("暂无数据", for: .idle)
                self.mj_footer.setTitle("暂无数据", for: .willRefresh)
                self.mj_footer.setTitle("暂无数据", for: .refreshing)
                self.mj_footer.setTitle("暂无数据", for: .noMoreData)
                self.tableView.mj_footer = self.mj_footer
            }else{
                self.mj_footer.setTitle("数据全部加载完成", for: .idle)
                self.mj_footer.setTitle("数据全部加载完成", for: .willRefresh)
                self.mj_footer.setTitle("数据全部加载完成", for: .refreshing)
                self.mj_footer.setTitle("数据全部加载完成", for: .noMoreData)
                self.tableView.mj_footer = self.mj_footer
            }
            
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.alreadyViewModel?.dataArray.count)!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:AlreadyCell = tableView.dequeueReusableCell(withIdentifier: "AlreadyCell") as! AlreadyCell
        cell = (Bundle.main.loadNibNamed("AlreadyCell", owner: self, options: nil)?.first) as! AlreadyCell
        cell.alredyModel = self.alreadyViewModel?.dataArray[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controler = AlreadyDetailController.init(style: UITableViewStyle.plain)
        controler.alreadyModel = self.alreadyViewModel?.dataArray[indexPath.section]
    
        self.navigationController?.pushViewController(controler, animated: true)
        
    }


}
