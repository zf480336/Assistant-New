//
//  M_GoodWaitController.swift
//  Assistant
//
//  Created by lxy on 2018/11/30.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class M_GoodWaitController: BaseGoodsChildController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Good_List = MyGoodList.Goods_Wait
        self.tableView.estimatedRowHeight = 200
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        setViewModel()
//        self.tableView.mj_header.beginRefreshing()
    }
    override func setViewModel() -> Void {
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:runOrder = self.goodViewModel?.dataArray[indexPath.section] as! runOrder
        let detail_Controller = Good_Detail_WaitAcceptController.init(style: UITableViewStyle.grouped)
        detail_Controller.orderModel = model
        self.navigationController?.pushViewController(detail_Controller, animated: true)
    }
   
}
