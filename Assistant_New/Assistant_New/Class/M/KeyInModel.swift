//
//  KeyInModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/19.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class KeyInModel: BaseModel {
    
   
    var containerCode:String? //集装箱号
    var rentCompany:String? //租用公司
    var tel:String? //联系电话
    var useDate:String? //用箱时间
    var backDate:String? //还箱日期
    var loadDate:String? //装载时间
    var seal_code:String? //是封号
    var tarpaulin_number:String?  //彭不好
    var net_weight:String? //净重
    var gross_weight:String? //毛重
    var unitNumber:String? //件数
    
     var orderID:String? //订单ID
    
    var goodName:String? //名称
    var goodInName:String? //录入名称
    var tj:String? //体积
    var sfsj:String? //石峰时间
     var netWork:String? //网点
    var netWorkid:String? //网点
    
    var imageUrl1:String?
    var imageUrl2:String?
    var imageUrl3:String?
    var image1:UIImage? //
    var image2:UIImage? //网点
    var image3:UIImage? //网点
   
    var orderContainerId:String?//编辑时候传
    
    var photo1:String?;
    var photo2:String?;
    var photo3:String?;

}
