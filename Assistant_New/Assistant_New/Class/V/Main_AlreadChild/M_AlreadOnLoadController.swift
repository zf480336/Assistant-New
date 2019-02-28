//
//  M_AlreadOnLoadController.swift
//  Assistant
//
//  Created by lxy on 2018/11/30.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class M_AlreadOnLoadController: BaseAlreadyChildController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.AlreadyEnum = AlreadyHandleList.DELIVERED
        setViewModel()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
