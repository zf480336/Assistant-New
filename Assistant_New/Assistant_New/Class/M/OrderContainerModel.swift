//
//  OrderContainerModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/19.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class OrderContainerModel: BaseModel {

    var order:order_detailModel?
}


class OrderContainerListModel: BaseModel {
    
     var containerList:[OrderContainer_listModel]?
}

class OrderContainer_listModel: BaseModel,NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let model = OrderContainer_listModel.init()
        model.id = self.id
        model.container_code = self.container_code
        model.waybillCode = self.waybillCode
        model.order_id = self.order_id
        model.seal_code = self.seal_code
        model.receive_entrepot_id = self.receive_entrepot_id
        model.suttle = self.suttle
        model.sale_status = self.sale_status
        model.waybilId = self.waybilId
        model.tarpaulin_number = self.tarpaulin_number
        model.gross_weight = self.gross_weight
//        model.isSelect = self.isSelect
        model.unit_num = self.unit_num
//        model.car_no = self.car_no
        model.isLoad = self.isLoad
        return model
    }
    
    var id:String?
    var container_code:String?
    var waybillCode:String?
    var order_id:String?
    var seal_code:String?
    var receive_entrepot_id:String?//网点id
    var suttle:String?
    var sale_status:String?
    var waybilId:String?    //判断有没有绑定运单号
    var tarpaulin_number:String?
    var gross_weight:String?
    var unit_num:String?
    var isSelect:Bool = false
    var isLoad:Bool?
    var car_no:String?
    var image1_url:String?
    var image2_url:String?
    var image3_url:String?
    var billID:String?
    var billCode:String?
    var waybillCarrierId:String?
    var entrepotName:String?//网点
    
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    var goods1_url:String?
    var goods2_url:String?
    var goods3_url:String?
    
}

class order_detailModel: BaseModel {
    var parentEndRegionCode:String?
    var parentCode:String?
    var code:String?
    var consignor_user_id:String?
    var goodsName:String?
    var goods_alias:String?
    var parentEndAddress:String?
    var orderContainerNumber:String?
    var goods_code:String?
    var parentGoodsAlias:String?
    var parentStartRegionName:String?
    var estimate_finish_time:String?
    var parentEndRegionName:String?
    var startRegionName:String?
    var id:String?
    var parentGoodsName:String?
    var parentGoodsCode:String?
    var start_region_code:String?
    var parentEstimateFinishTime:String?
    var parentStartRegionCode:String?
    var estimate_departure_time:String?
    var parentEstimateDepartureTime:String?
    var consignorCompanyName:String?
    var endRegionName:String?
    var end_region_code:String?
    var container_number:String?
    var parentStartAddress:String?
    var business_type_code:String?
    var start_address:String?
    var end_address:String?
    var start_contacts:String?
    var start_contacts2:String?
    var start_phone:String?
    var start_phone2:String?
    var end_contacts:String?
    var end_contacts2:String?
    var end_phone:String?
    var end_phone2:String?
    var containerName:String?
    var parentSubmitTime:String?
    

}
