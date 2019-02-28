//
//  WayBillModel.swift
//  Assistant
//
//  Created by lxy on 2019/1/2.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

class WayBillModel: BaseModel {
    
    var waybillList:[billModel]?
    
    
}

class billModel: BaseModel {
    
    var carrier_user_id:String?
    var trans_id:String?
    var vehicle_code:String?
    var driver_phone:String?
    var waybill_id:String?
    var driver_name:String?
    var trans_type_name:String?
    var waybill_code:String?
    var trans_type_code:String?
    var waybillCarrierId:String?
}
