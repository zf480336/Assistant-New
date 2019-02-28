//
//  LoginVM.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class LoginVM: BaseViewModel {

    public func LoginToAssistant(dic:NSMutableDictionary) -> Void {
        
        let manager = SessionManager.shareManager(ret: false, isShowProgress: true)
        manager.message = "登录中"
        manager.asyncRequest(methodType: .POST, urlString: LoginUrl, parameters: dic) { (responseData:Any?)  in
            
            if responseData == nil {
                return
            }
            
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let model = LoginModel.deserialize(from: baseModel?.result, designatedPath: "data")

            UserDefaults.standard.set(model?.token, forKey: TOKEN)
            UserDefaults.standard.synchronize()

            if baseModel?.status == SUCCESSSTATUS {
                
                let tabbar = BaseTabbarViewController()
                let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window?.rootViewController = tabbar
                appdelegate.window?.makeKeyAndVisible()
            }else{
                MBProgressHUD.showTipMessage(inWindow: "登录失败", timer: 1)
            }
        }
    }
    
//    func LoginToAssistant(dic:NSDictionary) -> Void {
//        self.dicHead = NSMutableDictionary.init()
//        self.dicHead?.setValue("user", forKey: "action")
//        self.dicHead?.setValue("login", forKey: "method")
//        self.dicHead?.setValue("dwdwadad", forKey: "clientld")
//        self.dicHead?.setValue("qqq", forKey: "device")
//        self.dicHead?.setValue("IOS", forKey: "platform")
//        self.dicHead?.setValue("0.0.0.1", forKey: "version")
//
//        self.dicHead?.setValue("0", forKey: "zip")
//        self.dicHead?.setValue("0", forKey: "encrpy")
//        self.dicHead?.setValue("", forKey: "userid")
//        self.dicHead?.setValue("", forKey: "token")
//
//
//        let params =  NSMutableDictionary()
//        params.setValue(self.user?.name, forKey: "username")
//        let pwdmd5:String  = MD5.string(withMd5: self.user?.pws)
//        params.setValue(MD5.string(withMd5: pwdmd5), forKey: "password")
//
//
//        let jsonData:Data = try! JSONSerialization.data(withJSONObject: params, options:.prettyPrinted)
//        let jsonStr = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
//
//         let dicc =  NSMutableDictionary()
//         dicc.setValue(jsonStr, forKey: "params")
//
//         let diccc =  NSMutableDictionary()
//         diccc.setValue(self.dicHead, forKey: "header")
//         diccc.setValue(dicc, forKey: "request")
//
//         let jsonData1:Data = try! JSONSerialization.data(withJSONObject: diccc, options:.prettyPrinted)
//        let jsonStr1 = NSString.init(data: jsonData1, encoding: String.Encoding.utf8.rawValue)
////        let dicc = @{@"header":self.dicHead,@"request",}
//        let dicccc =  NSMutableDictionary()
//        dicccc.setValue(jsonStr1, forKey: "data")
        
        
//        let dic = NSMutableDictionary.init()
//        dic.setValue("我是一一一一朵花", forKey: "name")
//        dic.setValue("15234913405", forKey: "phone")
//        dic.setValue("北京市京市朝阳区", forKey: "address")
//
//        let manager:AFHTTPSessionManager = AFHTTPSessionManager.init()
//        manager.requestSerializer = AFHTTPRequestSerializer.init()
//        manager.responseSerializer = AFHTTPResponseSerializer.init()
//        manager.requestSerializer.timeoutInterval = 4;
//
//        manager.post("http://localhost:8080/UserRest/addUser", parameters: dic, progress: nil, success: { (urlDatatask, AnyObject) in
//            print("1")
//            let data:Data = AnyObject as! Data
//            let jsonStr1 = NSString.init(data: data, encoding: String.Encoding.utf8.rawValue)
//            print("%@",jsonStr1)
//        }) { (urlDatatask, NSError) in
//            print(NSError)
//        }
    
//    }
 
 
}
