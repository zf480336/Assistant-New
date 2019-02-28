//
//  GoodsModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/21.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class GoodsModel: BaseModel {

    var code:String?
    var id:String?
    var insurance_fee_code:String?
    var name:String?

}
class GoodsModelData: BaseModel {
    
    var goods:[GoodsModel]?
}
