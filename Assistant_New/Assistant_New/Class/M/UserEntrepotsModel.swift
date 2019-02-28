//
//  UserEntrepotsModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/12.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class UserEntrepotsModel: BaseModel {
    
    var userEntrepots:[entrepotsModel]?
    
}

class entrepotsModel: BaseModel {
    var address:String?
    var entrepot_id:String?
    var entrepot_name:String?
    var entrepotName:String?
    
    var id:String?
    var organization_entrepot_id:String?
    var region_code:String?
    var region_name:String?
    var user_id:String?
    var isWorkEntrepot:String?
    var isSelect:Bool? = false
//    {
////        set{
////
////        }
//        get{
//            if (self.work_entrepot == "1") {
//                return true
//            }else{
//                return false
//            }
//        }
//    }
    
}
