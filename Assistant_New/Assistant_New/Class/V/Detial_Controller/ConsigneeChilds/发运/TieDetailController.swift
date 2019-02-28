//
//  TieDetailController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
class TieDetailController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var model:WayBilldetailModel?
    var handleModel:HandleModel?
    var order_conModel:OrderContainer_listModel?
    var handleViewModel:HandleViewModel?
    var billBlock:((_ billModel:billModel) -> ())?
    var mj_footer:MJRefreshAutoStateFooter = MJRefreshAutoStateFooter()
    var hideArr:NSMutableArray?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "绑定运单号"
        self.NaviRight?.isHidden = true

       self.tableView.delegate  = self
       self.tableView.dataSource = self
        setViewModel()
    }

    func setViewModel() -> Void {
        self.handleViewModel = HandleViewModel()
        self.handleViewModel?.hideArr = self.hideArr
        self.handleViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        self.handleViewModel?.params.setValue(self.model?.orderCode, forKey: "orderCode")
        self.handleViewModel?.setRequestDic()
        self.handleViewModel?.getBindContainerWayBill(dic: (self.handleViewModel?.data)!)
        self.handleViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if array.count == 0 {
                self.mj_footer.setTitle("暂无可绑定的运单号", for: MJRefreshState.idle)
                self.mj_footer.setTitle("暂无可绑定的运单号", for: MJRefreshState.willRefresh)
                self.mj_footer.setTitle("暂无可绑定的运单号", for: MJRefreshState.refreshing)
                self.mj_footer.setTitle("暂无可绑定的运单号", for: MJRefreshState.noMoreData)
                self.tableView.mj_footer = self.mj_footer
            }else{
                
                
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.idle)
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.willRefresh)
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.refreshing)
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.noMoreData)
                self.tableView.mj_footer = self.mj_footer
            }
            self.tableView.reloadData()
        }
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.handleViewModel?.dataArray.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WayBillCell = tableView.dequeueReusableCell(withIdentifier: "WayBillCell", for: indexPath) as! WayBillCell
        cell.model = self.handleViewModel?.dataArray[indexPath.section]
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:billModel = self.handleViewModel?.dataArray[indexPath.section] as! billModel
        self.navigationController?.popViewController(animated: true)
        if (self.billBlock != nil) {
            self.billBlock!(model)
        }
    }
}


