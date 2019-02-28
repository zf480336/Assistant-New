//
//  BaseModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/3.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: HandyJSON {

    var message:String?
    var result:NSDictionary?
    var status:String?
//    var info:Infomation? //这个是字典套字典的写法

    required init() {
    }
    
    //属性名
//    public func mapping(mapper: HelpingMapper) {
//
//        mapper <<< self.ID <-- "id"
//    }
//
    
    
//    init(dic:[String:AnyObject]) {
//        super.init()
//        self.ID = dic["id"] as! String
//        getModel(dic: dic as NSDictionary)
//    }
//
//    func getModel(dic:NSDictionary) {
//
//        setValuesForKeys(dic as! [String : Any])
//    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        super.setValue(value, forKey: key)
//    }
    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//
//    }
}
