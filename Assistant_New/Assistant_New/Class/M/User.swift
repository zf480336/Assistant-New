//
//  User.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import HandyJSON

class User: NSObject, NSCoding,HandyJSON {
    
    var id : String?
    var login_name : String?
    var organization_id : String?
    var organization_name : String?
    var phone : String?
    var sex : String?
    var userName : String?
    var userStatus : String?
    var userType : String?
    var user_code : String?
    var icon : String?
    var iii : String?
    
    
     func encode(with aCoder: NSCoder) {
        aCoder.encode(login_name, forKey: "login_name")
        aCoder.encode(organization_id, forKey: "organization_id")
        aCoder.encode(organization_name, forKey: "organization_name")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(userStatus, forKey: "userStatus")
        aCoder.encode(userType, forKey: "userType")
        aCoder.encode(user_code, forKey: "user_code")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(icon, forKey: "iii")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.login_name = (aDecoder.decodeObject(forKey: "login_name") as? String) ?? ""
        self.organization_id = (aDecoder.decodeObject(forKey: "organization_id") as? String) ?? ""
        self.organization_name = (aDecoder.decodeObject(forKey: "organization_name") as? String) ?? ""
        self.phone = (aDecoder.decodeObject(forKey: "phone") as? String) ?? ""
        self.sex = (aDecoder.decodeObject(forKey: "sex") as? String) ?? ""
        self.userName = (aDecoder.decodeObject(forKey: "userName") as? String) ?? ""
        self.userStatus = (aDecoder.decodeObject(forKey: "userStatus") as? String) ?? ""
        self.userType = (aDecoder.decodeObject(forKey: "userType") as? String) ?? ""
        self.user_code = (aDecoder.decodeObject(forKey: "user_code") as? String) ?? ""
        self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
       
        self.icon = (aDecoder.decodeObject(forKey: "icon") as? String) ?? ""
        self.iii = (aDecoder.decodeObject(forKey: "iii") as? String) ?? ""
    }
    
    required override init() {
        super.init()
        
    }
    
    public func mapping(mapper: HelpingMapper) {
        
//        mapper <<< self.ID <-- "id"
    }

}

class Entrepot: BaseModel {
    
    
    var entrepot_id : String?
    var address : String?
    var entrepotName : String?
    var user_id : String?
    var region_name : String?
    var region_code : String?
    var organization_entrepot_id: String?
    var type_code: String?
}

class UserInfo: BaseModel {
    
    var userInfo:User?
    var entrepot:Entrepot?
    
    
}
