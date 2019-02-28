//
//  BaseGoodsChildController.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BaseGoodsChildController: BaseChildTableViewController {

    var goodViewModel:GoodsViewModel?
    var curttenPage:Int = 1
    var Good_List:MyGoodList?
    
//    var mj_footer = MJRefreshAutoStateFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.isRefresh = false
//    }
//
    
    func setViewModel() -> Void {
        self.goodViewModel = GoodsViewModel.init()
        self.goodViewModel?.params.setValue(self.Good_List?.rawValue, forKey: "status")
        
        if self.goodViewModel?.dataArray.count == 0 {
            self.mj_footer.setTitle("请输入要查询的订单号", for: .idle)
            self.mj_footer.setTitle("请输入要查询的订单号", for: .willRefresh)
            self.mj_footer.setTitle("请输入要查询的订单号", for: .refreshing)
            self.mj_footer.setTitle("请输入要查询的订单号", for: .noMoreData)
            self.tableView.mj_footer = self.mj_footer
        }else{
            self.tableView.mj_footer = self.mj_foot
        }
    }
    
    
    override func headerRefresh() {
        
        self.curttenPage = 1
        self.isRefresh = true
//        if self.code == nil {
//            self.tableView.mj_header.endRefreshing()
//            MBProgressHUD.showTipMessage(inWindow: "请输入查询信息", timer: 1)
//        }else{
//            asyncWithParams(curIndex: self.curttenPage)
//        }
         asyncWithParams(curIndex: self.curttenPage)
        
    }
    
//    override func footerRefresh() {
//
//        self.curttenPage += 1
//        asyncWithParams(curIndex: self.curttenPage)
//    }
    
    func asyncWithParams(curIndex:Int) -> Void {
//        if self.code == nil {
//            self.goodViewModel?.params.setValue(self.code, forKey: "orderCode")
//            self.goodViewModel?.params.removeObject(forKey: "orderCode")
//        }
        self.goodViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        self.goodViewModel?.params.setValue(self.code, forKey: "orderCode")
        self.goodViewModel?.params.setValue(String(curIndex), forKey: "page")
        self.goodViewModel?.params.setValue(pageNum, forKey: "limit")
        self.goodViewModel?.setRequestDic()
        self.goodViewModel?.getRunningOrderContainer(dic: self.goodViewModel!.data,curtenIndex: curIndex)
        self.goodViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if array.count == 0 {
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
             self.tableView.reloadData()
             self.tableView.mj_header.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.goodViewModel?.dataArray.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell") as! BaseTableViewCell
        cell = (Bundle.main.loadNibNamed("BaseTableViewCell", owner: self, options: nil)?.first as? BaseTableViewCell)!
        if  ((self.goodViewModel?.dataArray.count) != nil){
            cell.runOrderModel = self.goodViewModel?.dataArray[indexPath.section]
        }
        return cell
    }

   
}
