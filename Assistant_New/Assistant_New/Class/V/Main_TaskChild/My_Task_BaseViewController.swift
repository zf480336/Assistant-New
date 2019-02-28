//
//  My_Task_BaseViewController.swift
//  Assistant
//
//  Created by lxy on 2018/12/11.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class My_Task_BaseViewController: BaseTableViewController {

    var homeViewModel:HomeViewModel?
    var curttenPage:Int = 1
    
    
    var My_Task_enum:MyTaskList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setRefresh()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setViewModel() -> Void {
        self.homeViewModel = HomeViewModel.init()
        self.homeViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        
        self.homeViewModel?.params.setValue("", forKey: "waybillStatusName")
        self.homeViewModel?.params.setValue(self.My_Task_enum?.rawValue, forKey: "status")
    }
    
    override func headerRefresh() {
        self.curttenPage = 1
        self.isRefresh = true
        asyncWithParams(curIndex: self.curttenPage)
    }
    
    override func footerRefresh() {
        
        self.curttenPage += 1
        asyncWithParams(curIndex: self.curttenPage)
    }
    
    func asyncWithParams(curIndex:Int) -> Void {
        self.homeViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        self.homeViewModel?.params.removeObject(forKey: "waybillCode")
        self.homeViewModel?.params.removeObject(forKey: "carNo")
        self.homeViewModel?.params.removeObject(forKey: "containerCode")
        self.homeViewModel?.params.removeObject(forKey: "licensePlateNumber")
        self.homeViewModel?.params.removeObject(forKey: "orderCode")
        let key = self.code ?? ""
        
        if key.hasPrefix("WB") {
            if YMKJVerificationTools.isWayBillCode(key) {
                self.homeViewModel?.params.setValue(key, forKey: "waybillCode")
                
            }else{
                MBProgressHUD.showTipMessage(inWindow: "运单号不正确", timer: 1)
                self.tableView.mj_header.endRefreshing()
                return
            }
        }
       
        //批次号
        if key.count == 20 && key.hasPrefix("D") {
            if YMKJVerificationTools.isOrderBillCode(key) {
                self.homeViewModel?.params.setValue(key, forKey: "orderCode")
           
            }else{
                MBProgressHUD.showTipMessage(inWindow: "批次号输入不正确", timer: 1)
                return
            }
        }
        if key.count == 7 {
            if YMKJVerificationTools.isCarNo(key) {
                self.homeViewModel?.params.setValue(key, forKey: "carNo")
 
            }else{
                MBProgressHUD.showTipMessage(inWindow: "运车底号、挂车号不正确", timer: 1)
                self.tableView.mj_header.endRefreshing()
                return
            }
        }
        
        if key.count == 11 {
            if YMKJVerificationTools.isContainerCode(key) {
                self.homeViewModel?.params.setValue(key, forKey: "containerCode")
            }else{
                MBProgressHUD.showTipMessage(inWindow: "集装箱号不正确", timer: 1)
                self.tableView.mj_header.endRefreshing()
                return
            }
        }
        
        self.homeViewModel?.params.setValue(String(curIndex), forKey: "page")
        self.homeViewModel?.params.setValue(pageNum, forKey: "limit")
        self.homeViewModel?.setRequestDic()
        self.homeViewModel?.getRunningTask(dic: homeViewModel!.data,curtenIndex: curIndex)
        self.homeViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            
            if curIndex == 1 {
                self.dataArray  = (array as NSArray).mutableCopy() as! NSMutableArray
                self.tableView.mj_header.endRefreshing()
                
            }else{
                self.dataArray.addObjects(from: array)
                self.tableView.mj_footer.endRefreshing()
            }
            self.tableView.reloadData()
            if isEnd {
                
                if self.dataArray.count == 0 {
                    self.mj_footer.setTitle("暂无数据", for: .idle)
                    self.mj_footer.setTitle("暂无数据", for: .willRefresh)
                    self.mj_footer.setTitle("暂无数据", for: .refreshing)
                    self.mj_footer.setTitle("暂无数据", for: .noMoreData)
                }else{
                    self.mj_footer.setTitle("数据全部加载完成", for: .idle)
                    self.mj_footer.setTitle("数据全部加载完成", for: .willRefresh)
                    self.mj_footer.setTitle("数据全部加载完成", for: .refreshing)
                    self.mj_footer.setTitle("数据全部加载完成", for: .noMoreData)
                }
                self.tableView.mj_footer = self.mj_footer
            }else{
                if self.dataArray.count == 0 {
                    self.mj_footer.setTitle("暂无数据", for: .idle)
                    self.mj_footer.setTitle("暂无数据", for: .willRefresh)
                    self.mj_footer.setTitle("暂无数据", for: .refreshing)
                    self.mj_footer.setTitle("暂无数据", for: .noMoreData)
                    self.tableView.mj_footer = self.mj_footer
                }
                
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell") as! BaseTableViewCell
        cell = (Bundle.main.loadNibNamed("BaseTableViewCell", owner: self, options: nil)?.first as? BaseTableViewCell)!
        cell.model = self.dataArray[indexPath.section]
        return cell
        
    }
}
