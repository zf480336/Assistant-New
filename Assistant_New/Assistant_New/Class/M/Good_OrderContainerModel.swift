//
//  Good_OrderContainerModel.swift
//  Assistant
//
//  Created by lxy on 2019/1/7.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit


class Good_OrderContainerListModel: BaseModel {
    
    var containerList:[Good_OrderContainerModel]?
}

class Good_OrderContainerModel: BaseModel,NSCopying {

    
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
    var waybillCode:String?
    var order_id:String?
    
    var container_code:String?//集装箱号
    var receive_entrepot_id:String?//网点id
    var suttle:String? //净重
    var sale_status:String?
    var waybilId:String?    //判断有没有绑定运单号
    var entrepotName:String?//网点
    
    var gross_weight:String?//毛重
    var unit_num:String? //件数
    var isSelect:Bool = false
    var isLoad:Bool?
    var car_no:String?
    var image1_url:String?
    var image2_url:String?
    var image3_url:String?
    var billID:String?
    var billCode:String?
    var waybillCarrierId:String?
    var goods1_url:String?
    var goods2_url:String?
    var goods3_url:String?
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    
    var seal_code:String? //施封号
    var tarpaulin_number:String? //彭不好
    
}
