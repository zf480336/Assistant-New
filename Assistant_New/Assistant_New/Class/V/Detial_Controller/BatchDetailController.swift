//
//  BatchDetailController.swift
//  Assistant
//
//  Created by lxy on 2018/12/4.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BatchDetailController: AlreadyDetailController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "运单详情"
        self.tableView.register(UINib.init(nibName: "BatchImageCell", bundle: nil), forCellReuseIdentifier: "BatchImageCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        self.tableView.separatorColor = HexColor.getHex(hexString: "#999999", alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            var cell:BatchImageCell = tableView.dequeueReusableCell(withIdentifier: "BatchImageCell") as! BatchImageCell
            cell = Bundle.main.loadNibNamed("BatchImageCell", owner: self, options: nil)?.first as? UITableViewCell as! BatchImageCell

            return cell
        }else{
            var cell:BatchCell = tableView.dequeueReusableCell(withIdentifier: "BatchCell") as! BatchCell
            cell = Bundle.main.loadNibNamed("BatchCell", owner: self, options: nil)?.first as? UITableViewCell as! BatchCell
            
            if(indexPath.row == 0){
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_BillInfo)
                
            }else if(indexPath.row == 1){
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_containerInfo)
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: 600, bottom: 0, right: 0)
                
            }else if(indexPath.row == 3){
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_goodInfo)
                
            }else if(indexPath.row == 4){
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: 600, bottom: 0, right: 0)
                cell.setBatchLabelAndstatusLabel(betchBehavious: .BatchDetail_conferInfo)
            }
            return cell
        }
    }

}
