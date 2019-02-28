//
//  RunningOrders.swift
//  Assistant
//
//  Created by lxy on 2018/12/18.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class RunningOrders: BaseModel {
    var runningOrders : [runOrder]?
    
}

class runOrder: BaseModel {
    
    var code:String?
    var consignor_user_id:String?
    var container_number:String?
    var endRegionName:String?
    var end_region_code:String?
    var estimate_departure_time:String?
    var estimate_finish_time:String?
    var goodsName:String?
    var goods_alias:String?
    var goods_code:String?
    var id:String?
    var orderContainerNumber:String?
    var startRegionName:String?
    var start_region_code:String?
    var consignorCompanyName:String?
}
