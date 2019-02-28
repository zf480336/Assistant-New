//
//  M_AlreadPayController.swift
//  Assistant
//
//  Created by lxy on 2018/11/30.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class M_AlreadPayController: BaseAlreadyChildController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.AlreadyEnum = AlreadyHandleList.PAID
        setViewModel()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 5
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
    
}
