//
//  BaseTableViewController.swift
//  Assistant
//
//  Created by lxy on 2018/11/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
extension BaseTableViewController{
    
}

class BaseTableViewController: UITableViewController {
    
    var NaviRight:UIButton?
    var dataArray:NSMutableArray = NSMutableArray.init()
    var code:String?
    var isRefresh:Bool = false
    
    var mj_head:MJRefreshNormalHeader = MJRefreshNormalHeader()
    var mj_foot:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter()
    var autoFooter:MJRefreshAutoStateFooter = MJRefreshAutoStateFooter()
    
    var mj_footer:MJRefreshAutoStateFooter = MJRefreshAutoStateFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        
        let leftButton = UIButton(frame:CGRect.init(x: 0, y: 0, width: 80, height: 40))
        leftButton.setImage(UIImage.init(named: "naviBack"), for: UIControlState.normal)
        leftButton.isSelected = true
        leftButton.imageEdgeInsets.left = -75
        leftButton.addTarget(self, action: #selector(pressNaviLeft), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftButton)
//        self.navigationItem.leftBarButtonItem = leftItem
        let negativeSpace:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = -10
        
        self.navigationItem.leftBarButtonItems = [negativeSpace, leftItem];
        
        
        let rightButton = UIButton(frame:CGRect.init(x: 0, y: 0, width: 60, height: 40))
        rightButton.setTitle("", for: UIControlState.normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        rightButton.contentHorizontalAlignment = .right
        rightButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightButton.addTarget(self, action: #selector(pressNaviRight), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightButton)
//        self.navigationItem.rightBarButtonItem = rightItem
        self.NaviRight = rightButton
        self.NaviRight?.isHidden = true
        
        let negativeSpace1:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace1.width = -10
        
        self.navigationItem.rightBarButtonItems = [negativeSpace1, rightItem];

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
      
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        self.tableView.backgroundColor = Color_VcBack
        self.tableView.register(UINib.init(nibName: "BaseTableViewCell", bundle: nil), forCellReuseIdentifier: "BaseTableViewCell")
        
        
    }
    
    func setRefresh() -> Void {
        self.mj_head.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = self.mj_head
        
        self.mj_foot.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView.mj_footer = self.mj_foot
    }

    @objc func headerRefresh() -> Void {
        print("上拉刷新")
    }
    @objc func footerRefresh() -> Void {
        print("上拉刷新")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @objc func pressNaviLeft() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func pressNaviRight() -> Void {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell") as! BaseTableViewCell
        cell = (Bundle.main.loadNibNamed("BaseTableViewCell", owner: self, options: nil)?.first as? BaseTableViewCell)!
        return cell
        
    }

    
    //MARK: - Header AND Footer
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        return footView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}
