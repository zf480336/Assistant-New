//
//  WayBilldetailModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/11.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class WayBilldetailModel: BaseModel {
 
    var companyName:String?
    var consignor_user_id:String?
    var delivery_type_code:String?
    var endEntrePortName:String?
    var endRegionName:String?
    var end_address:String?
    var end_contacts:String?
    var end_contacts_phone:String?
    var end_entrepot_id:String?
    var end_region_code:String?
    var estimate_arrival_time:String?
    var estimate_departure_time:String?
    var goodsName:String?
    var goods_alias:String?
    var goods_code:String?
    var id:String?
    var orderCode:String?
    var parentCode:String?
    var parentEndAddress:String?
    var parentStartAddress:String?
    var startEntrePortName:String?
    var startRegionName:String?
    var start_address:String?
    var start_contacts:String?
    var start_contacts_phone:String?
    var start_entrepot_id:String?
    var start_region_code:String?
    var statusName:String?
    var trans_id:String?
    var trans_type_code:String?
    var waybillCode:String?
    var waybillGroupId:String?
    var waybillId:String?
    var waybillStatus:String?
    var parentSubmitTime:String?
    var container_number:String?
    var ParentBusinessTypeCode:String?
    var containerTypeName:String?
    var carrierWaybillId:String?
    var orderId:String?
    var orderStartContacts:String?
    var orderStartPone:String?
    var orderEndContacts:String?
    var orderEndPhone:String?

}



class TaskDetailModel: BaseModel {
    var taskDetailsask:WayBilldetailModel?
    
}
