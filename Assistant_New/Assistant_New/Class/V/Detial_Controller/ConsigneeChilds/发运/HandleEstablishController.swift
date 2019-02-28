//
//  HandleEstablishController.swift
//  Assistant
//
//  Created by lxy on 2018/12/28.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class HandleEstablishController: UserEstablishController {

    var selectBlock:((_ handModel:entrepoModel) ->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViewModel() -> Void {
        self.userViewModel = UserViewModel.init()
        self.userViewModel?.setRequestDic()
        self.userViewModel?.getEntrepotList(dic: self.userViewModel!.data)
        self.userViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:EntrepotsCell = tableView.dequeueReusableCell(withIdentifier: "EntrepotsCell") as! EntrepotsCell
        cell = Bundle.main.loadNibNamed("EntrepotsCell", owner: self, options: nil)?.first as! EntrepotsCell
        
        let model:entrepoModel = self.userViewModel?.dataArray[indexPath.row] as! entrepoModel
        cell.handleModel = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let model:entrepoModel = self.userViewModel?.dataArray[indexPath.row] as! entrepoModel
        if (self.selectBlock != nil) {
            self.selectBlock!(model)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
