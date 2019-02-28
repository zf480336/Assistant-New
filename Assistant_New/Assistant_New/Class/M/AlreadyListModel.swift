//
//  AlreadyListModel.swift
//  Assistant
//
//  Created by lxy on 2019/1/3.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

class AlreadyListModel: BaseModel {
    var containerOperationList:[alreadyModel]?
    
}

class alreadyModel: BaseModel {
    var id:String?
    var goods_name:String?
    var startEntrepotName:String?
    var endEntrepotName:String?
    var order_id:String?
    var waybill_id:String?
    
    var end_entrepot:String?
    var create_user:String?
    var create_time:String?
    var start_entrepot:String?
    var trans_number:String?
    var line_name:String?
    var update_time:String? //抵达时间
    
}

class ContainerOperationModel: BaseModel {
    var containerOperation:alreadyModel?
    
}

