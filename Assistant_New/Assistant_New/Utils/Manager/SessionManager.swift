//
//  SessionManager.swift
//  Assistant
//
//  Created by lxy on 2018/12/6.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPRequestType:Int {
    case GET = 0
    case POST
}

class SessionManager: AFHTTPSessionManager {

    var isShowProgress:Bool?
    var message:String?
    var baseDic:NSMutableDictionary = NSMutableDictionary()
    
    
    static let _sessionManager = SessionManager.init(baseURL:URL.init(string: BaseUrl), sessionConfiguration: URLSessionConfiguration.default)
    static func shareManager(ret:Bool, isShowProgress:Bool) -> SessionManager {
         _sessionManager.responseSerializer.acceptableContentTypes = (NSSet.init(objects: "application/json", "text/json", "text/javascript","text/html","text/plain","image/jpg") as! Set<String>)
        _sessionManager.isShowProgress = isShowProgress
        if ret {
            _sessionManager.requestSerializer = AFJSONRequestSerializer()
            _sessionManager.responseSerializer = AFJSONResponseSerializer()
        }
        _sessionManager.requestSerializer.timeoutInterval = 100.0

        return _sessionManager
    }
}

extension SessionManager{
    
    //MARK: - 网络请求
    func asyncRequest(methodType : HTTPRequestType, urlString : String, parameters : Any?,finishCallBack:@escaping(_ result : Any?)->()) {
        
        print("入参报文" + urlString)
        let parameter:NSDictionary = parameters as! NSDictionary
        
        printLog(message: parameter)
        
        
//        let successCallBack = {(task:URLSessionDataTask,responseData:Any) in finishCallBack(responseData, nil!) }
//        let failureCallBack = {(task:URLSessionDataTask?,error:Error) in finishCallBack(task,error)}
//        post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        
        
        if self.isShowProgress! {
            MBProgressHUD.showActivityMessage(inWindow: message)
        }
        
        switch methodType {
            
        case .GET:
            get(urlString, parameters: parameters, progress: nil, success: { (task :URLSessionDataTask, responseData : Any) in
                 finishCallBack(responseData)
            }) { (task : URLSessionDataTask?, error :Error) in
                print(self.errorMessage(error: error))
            }
            
            break
            
        case .POST:
            
            post(urlString, parameters: parameters, progress: nil, success: { (task:URLSessionDataTask, responseData:Any?) in
                
                MBProgressHUD.hide()
                if responseData == nil {
                    MBProgressHUD.showTipMessage(inWindow:"请求数据失败", timer: 1)
                    return
                }
                let dic:NSDictionary = responseData as! NSDictionary
                print("出参报文")
                print(dic)
                finishCallBack(dic)
                
            }) { (task:URLSessionDataTask?, error:Error) in
                
                MBProgressHUD.hide()
                MBProgressHUD.showTipMessage(inWindow: self.errorMessage(error: error), timer: 1)
                finishCallBack(nil)
                
            }

            break
        }
    }
    
    //MARK: - 头像上传
    
    func asyncRequestWithImage(urlString : String, parameters : Any?, img:UIImage, finishCallBack:@escaping(_ result : Any?)->()) {
        
        print("请求接口" + urlString)
        let parameter:NSDictionary = parameters as! NSDictionary
        
        printLog(message: parameter)
        
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            formatter.timeZone = NSTimeZone.system
            let fileName:String = "\(formatter.string(from: NSDate.init() as Date)).jpg"
            let imageData = UIImageJPEGRepresentation(img, 0.1)
            formData.appendPart(withFileData: imageData!, name: "avatorImage", fileName: fileName, mimeType: "image/jpg")
           
        }, progress: nil, success: { (task :URLSessionDataTask, responseData : Any) in
            
            MBProgressHUD.hide()
            let dic:NSDictionary = responseData as! NSDictionary
            finishCallBack(dic)
            
        }) {(task : URLSessionDataTask?, error :Error) in
            MBProgressHUD.hide()
            MBProgressHUD.showTipMessage(inWindow: self.errorMessage(error: error), timer: 1)
            finishCallBack(nil)
        }
        
    }
    
    //MARK: - 箱子输入上传
    func asyncRequestWithGoodsImages(urlString : String, parameters :Any?,imageArray:Array<Any>,finishCallBack:@escaping(_ result : Any?)->()) {
        
        print("请求接口" + urlString)
        let parameter:NSDictionary = parameters as! NSDictionary
        
        printLog(message: parameter)
        
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
            for (index ,value) in imageArray.enumerated(){
                let img:UIImage = value as! UIImage
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                formatter.timeZone = NSTimeZone.system
                let fileName:String = "\(formatter.string(from: NSDate.init() as Date)).jpg"
                let imageData = UIImageJPEGRepresentation(img, 0.1)
                let inde_x = index+1
                let filename:String = "goods\(inde_x)"
    
                formData.appendPart(withFileData: imageData!, name: filename, fileName: fileName, mimeType: "image/jpg")
            }
            
        }, progress: nil, success: { (task :URLSessionDataTask, responseData : Any) in
            
            MBProgressHUD.hide()
            let dic:NSDictionary = responseData as! NSDictionary
            finishCallBack(dic)
            
        }) {(task : URLSessionDataTask?, error :Error) in
            
            MBProgressHUD.hide()
            MBProgressHUD.showTipMessage(inWindow: self.errorMessage(error: error), timer: 1)
            finishCallBack(nil)
            
        }
        
    }
    
    
    private func errorMessage(error:Error) -> String {
        let code = (error as NSError).code
        var msg:String = (error as NSError).localizedDescription// 本地回复建议
        if code == -1011 || code == -1008 {
            msg = "服务器错误"
        }else if code == -1201 || code == -1015 || code == -1016 {
            msg = "服务器返回异常"
        }else if code == -1001 || code == -2000 {
            msg = "当前网络不佳，请稍后重试"
        }else if code == -1009 || code == -1003 || code == -1004 {
            msg = "网络未连接，请检查网络"
        }else if code == -1 {
            msg = "访问失败"
        }else if code == 3840 {
            msg = "返回数据不是json结构";
        }
        return msg
    }
}
