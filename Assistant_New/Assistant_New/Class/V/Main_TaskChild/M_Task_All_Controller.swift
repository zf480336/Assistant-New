//
//  M_Task_All_Controller.swift
//  Assistant
//
//  Created by lxy on 2018/11/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class M_Task_All_Controller: My_Task_BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewModel()
        self.tableView.mj_header.beginRefreshing()
    }

    
    override func setViewModel() -> Void {
        self.homeViewModel = HomeViewModel.init()
        self.homeViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        self.homeViewModel?.params.setValue(["3","4","5"], forKey: "status")
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:detailModel = self.dataArray[indexPath.section] as! detailModel
//        let myTaslList:MyTaskList = MyTaskList.init(rawValue: model.waybillStatus!)!
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
//        switch myTaslList {
//        case .MyTask_Ship:
//
//
//            let detail_Controller = ConsigneeController.init(style: UITableViewStyle.plain)
//            detail_Controller.detailModel = model
//            self.navigationController?.pushViewController(detail_Controller, animated: true)
//
//        case .MyTask_Accept:
//
//            let detail_Controller = AcceptDetailController.init(style: UITableViewStyle.plain)
//            detail_Controller.detailModel = model
//            self.navigationController?.pushViewController(detail_Controller, animated: true)
//
//            break
//        case .MyTask_Pay:
//
//            let detail_Controller = PayDetailController.init(style: UITableViewStyle.plain)
//            detail_Controller.detailModel = model
//            self.navigationController?.pushViewController(detail_Controller, animated: true)
//
//            break
//        case .MyTask_All:
//            break
//        }
//
    }
    
}
