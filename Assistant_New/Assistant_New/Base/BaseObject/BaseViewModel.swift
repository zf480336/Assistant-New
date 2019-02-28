//
//  BaseViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/6.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {

    let parameter:NSMutableDictionary = NSMutableDictionary.init()
    let headerDic:NSMutableDictionary = NSMutableDictionary.init()
    let request:NSMutableDictionary = NSMutableDictionary.init()
    let params:NSMutableDictionary = NSMutableDictionary.init()
    let data:NSMutableDictionary = NSMutableDictionary.init()
    var dataArray:Array<Any> = Array.init()
    var resultArrayBlock : ((_ resultData:Array<Any>,_ isEnd:Bool) -> Void)?
    var resultStringBlock : ((_ resultString:String) -> Void)?
    
    override init() {
        super.init()
        
        self.headerDic.setValue("", forKey: "userId")
        self.headerDic.setValue("", forKey: "clientid")
        self.headerDic.setValue("", forKey: "companyId")
        self.headerDic.setValue("", forKey: "device")
        self.headerDic.setValue("IOS", forKey: "platform")
        self.headerDic.setValue("0.0.0.1", forKey: "version")
        self.headerDic.setValue("", forKey: "token")
        self.headerDic.setValue("", forKey: "zip")
        self.headerDic.setValue("", forKey: "encrpy")
    }
}
extension BaseViewModel{
    
    //字典转Json字符串
    func dicValueString(_ dic:[String : Any]) -> String?{
        let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        let str = String(data: data, encoding: String.Encoding.utf8)
        return str
    }
    
    func setRequestDic() -> Void {
        let paramStr = dicValueString(self.params as! [String : Any])
        self.request.setValue(paramStr, forKey: "params")
        self.parameter.setValue(request, forKey: "request")
        self.parameter.setValue(headerDic, forKey: "header")
        let parameterStr = dicValueString(self.parameter as! [String : Any])
        self.data.setValue(parameterStr, forKey: "data")
    }
}
