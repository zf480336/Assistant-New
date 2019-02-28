//
//  UserEstablishController.swift
//  Assistant
//
//  Created by lxy on 2018/12/12.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class UserEstablishController: BaseTableViewController {

    var userViewModel:UserViewModel?
    var curModel:entrepotsModel?
    var isPresent:Bool? = false
    var isKeyInStatus:Bool? = false
    var enportSelectBlock:(()->())?
    var changeKeyInBlock:((_ selectModel:entrepotsModel)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "网点选择"
        self.NaviRight?.isHidden = false
        self.NaviRight?.setTitle("确定", for: UIControlState.normal)
        self.tableView.register(UINib.init(nibName: "EntrepotsCell", bundle: nil), forCellReuseIdentifier: "EntrepotsCell")
        setViewModel()
    }
    
    func setViewModel() -> Void {
        self.userViewModel = UserViewModel.init()
        let userid = MyConfig.shareConfig().user?.id
        let organization_id = MyConfig.shareConfig().user?.organization_id
        self.userViewModel?.headerDic.setValue(userid, forKey: "userId")
        self.userViewModel?.params.setValue(organization_id, forKey: "organization_id")
        self.userViewModel?.setRequestDic()
        self.userViewModel?.getUserEntrepots(dic: self.userViewModel!.data)
        self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
           
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.userViewModel?.dataArray.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:EntrepotsCell = tableView.dequeueReusableCell(withIdentifier: "EntrepotsCell") as! EntrepotsCell
        cell = Bundle.main.loadNibNamed("EntrepotsCell", owner: self, options: nil)?.first as! EntrepotsCell
        
        let model:entrepotsModel = self.userViewModel?.dataArray[indexPath.row] as! entrepotsModel
        if model.isWorkEntrepot == "1" {
            model.isSelect = true
            self.curModel = model
        }else{
            model.isSelect = false
        }
        cell.entreModel = self.userViewModel?.dataArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isPresent == true {
            let model:entrepotsModel = self.userViewModel?.dataArray[indexPath.row] as! entrepotsModel
            self.curModel = model
            getChange()
        }else{
            let model:entrepotsModel = self.userViewModel?.dataArray[indexPath.row] as! entrepotsModel
            if model.isSelect == self.curModel?.isSelect {
                return
            }else{
                self.curModel?.isWorkEntrepot = "0"
                model.isWorkEntrepot = "1"
                self.curModel = model
                self.tableView.reloadData()
            }
        }
    }
   
    override func pressNaviRight() {
        if self.curModel == nil {
            return;
        }
        if self.isKeyInStatus == true {
           
            self.changeKeyInBlock!(self.curModel!)
            self.navigationController?.popViewController(animated: true)
       
        }else{
           
            getChange()
        }
    }
 
    //更改网点
    func getChange() -> Void {
        self.userViewModel?.params.removeObject(forKey: "organization_id")
        self.userViewModel?.params.setValue(self.curModel?.organization_entrepot_id, forKey: "organizationEntrepotId")
        self.userViewModel?.setRequestDic()
        self.userViewModel?.getChangeUserEntrepots(dic: self.userViewModel!.data)
        self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            if isEnd {
                if self.isPresent == true {
                    self.dismiss(animated: true, completion: {
                        self.enportSelectBlock!()
                    })
                }else{
                     self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}
