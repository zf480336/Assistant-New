//
//  infomation.swift
//  Assistant
//
//  Created by lxy on 2018/12/7.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import HandyJSON
class Infomation: BaseModel {

    var Classes:String?
    var school:String?
    var info:[Infomation]? //这个是字典套数组的写法  infomation返回的是一个 infomation 对象的数组
    
}
