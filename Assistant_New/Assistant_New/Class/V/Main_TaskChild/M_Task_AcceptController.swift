//
//  M_Task_AcceptController.swift
//  Assistant
//
//  Created by lxy on 2018/11/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class M_Task_AcceptController: My_Task_BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.My_Task_enum = MyTaskList.MyTask_Accept
        setViewModel()

    }
    
    override func setViewModel() -> Void {
        self.homeViewModel = HomeViewModel.init()
        self.homeViewModel?.params.setValue(MyConfig.shareConfig().entrepot_id, forKey: "entrepotId")
        self.homeViewModel?.params.setValue("待收货", forKey: "waybillStatusName")
        self.homeViewModel?.params.setValue(["3","4"], forKey: "status")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail_Controller = AcceptDetailController.init(style: UITableViewStyle.plain)
        detail_Controller.detailModel = self.dataArray[indexPath.section]
        self.navigationController?.pushViewController(detail_Controller, animated: true)
    }
 

}
