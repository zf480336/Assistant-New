//
//  ConfirmPayController.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class ConfirmPayController: BaseTableViewController,ButtonClickedDelegate {

    var isChoose:Bool?
    var selectArray:NSMutableArray = NSMutableArray.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "运单列表"
        self.NaviRight?.isHidden = false
        self.NaviRight?.setTitle("批量收货", for: UIControlState.normal)
        self.NaviRight?.frame = CGRect.init(x: 0, y: 0, width: 80, height: 60)
        self.tableView.register(UINib.init(nibName: "AlredyDetailbetchCell", bundle: nil), forCellReuseIdentifier: "AlredyDetailbetchCell")
        self.tableView.register(UINib.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        
        self.isChoose = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 4 {
            var cell:ButtonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cell = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as? UITableViewCell as! ButtonCell
            cell.clickDelegate = self
            cell.button.setTitle("确认交付", for: UIControlState.normal)
            return cell
        }else{
            var cell:AlredyDetailbetchCell = tableView.dequeueReusableCell(withIdentifier: "AlredyDetailbetchCell") as! AlredyDetailbetchCell
            cell = Bundle.main.loadNibNamed("AlredyDetailbetchCell", owner: self, options: nil)?.first as! AlredyDetailbetchCell
            if self.isChoose! {
                cell.selectBtn.isHidden  = false
            }else{
                cell.selectBtn.isHidden  = true
            }
            return cell
        }
    }
    
    //MARK: - Action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isChoose! {
            
        }else{
            let batchDetail = BatchDetailController.init(style: UITableViewStyle.plain)
            self.navigationController?.pushViewController(batchDetail, animated: true)
        }
    }
    
    func buttoClickedAction() {
        
    }
    
    override func pressNaviRight() {
        self.isChoose = !self.isChoose!
        self.tableView.reloadData()
        if self.isChoose! {
            self.NaviRight?.setTitle("取消选择", for: UIControlState.normal)
        }else{
            self.NaviRight?.setTitle("批量收货", for: UIControlState.normal)
        }
    }

}
