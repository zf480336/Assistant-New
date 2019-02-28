//
//  UserViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/6.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit


class UserViewModel: BaseViewModel {

    var userInfoModel:UserInfo?
    var handleModel:handleEstabModel?
    
//    public func getLogin(dic:NSMutableDictionary) -> Void {
//        printLog(message: dic)
//
//        //第一层表达式是字典的
//        let dic:NSDictionary = ["id":"1","name":"zhaofa","age":"22","info":[["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"]]]
//        let dic1:NSDictionary = ["info":[["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"]]]
//
//
////
////        let JsonStr = dicValueString(dic as! [String : Any])
////
////        let basemodel = BaseModel.deserialize(from: JsonStr)
////        let base1 = Infomation.deserialize(from: dic1)
////
////        //这个写法是直接获取某个节点下对应的JSON数据用来转模型
////        let info = BaseModel.deserialize(from: JsonStr, designatedPath: "info")
////        let info1 = Infomation.deserialize(from: dic1, designatedPath: "info")
//
//
//
//        //第一层表达式是数组的
//        let Array1:NSArray = [["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"],["Classes":"399","school":"怀仁一中"]]
//        let info = [Infomation].deserialize(from: Array1)
//
//    }
    //MARK: - 获取用户信息
     public func getUserInfo(dic:NSMutableDictionary) -> Void  {
    
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: GetUserInfo, parameters: dic) { (responseData:Any?)  in
            
            
            
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            printLog(message: baseModel?.message)
            let UserInfoModel = UserInfo.deserialize(from: baseModel?.result, designatedPath: "data")
            self.userInfoModel = UserInfoModel
            //---------------------------------------------存储模型 --------------------------------------------------
            let userr:User = (UserInfoModel?.userInfo)!
            MyConfig.shareConfig().user = userr
            MyConfig.shareConfig().entrepotName = UserInfoModel?.entrepot?.entrepotName
            MyConfig.shareConfig().entrepot_id = UserInfoModel?.entrepot?.entrepot_id
            self.resultArrayBlock!([],true)
        }
    }
    
    //MARK: - 获取用户所有网点
    public func getUserEntrepots(dic:NSMutableDictionary) -> Void  {

            SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: UserEntrepots, parameters: dic) { (responseData:Any?)  in
                let dic = responseData as! NSDictionary
                //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
                let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
                let userEntrepotsModel = UserEntrepotsModel.deserialize(from: baseModel?.result, designatedPath: "data")
                let array:Array = (userEntrepotsModel?.userEntrepots)!
                self.dataArray = array
                self.resultArrayBlock!(array,false)
            }
    }
    
    
    //MARK: - 获取发运网点列表
    public func getEntrepotList(dic:NSMutableDictionary) -> Void  {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: EntrepotList, parameters: dic) { (responseData:Any?)  in
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let handModel = handleEstabModel.deserialize(from: baseModel?.result, designatedPath: "data")
            if handModel?.entrepotList == nil {
                return
            }
            let array:Array = (handModel?.entrepotList)!
            self.dataArray = array
            self.handleModel = handModel
            self.resultArrayBlock!(array,false)
        }
    }

    //MARK: - 更换网点
    public func getChangeUserEntrepots(dic:NSMutableDictionary) -> Void  {

        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: ChangeUserEntrepots, parameters: dic) { (responseData:Any?)  in
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
//            let userEntrepotsModel = UserEntrepotsModel.deserialize(from: baseModel?.result, designatedPath: "data")
//            let array:Array = (userEntrepotsModel?.userEntrepots)!
//            self.dataArray = array
            if baseModel?.status == SUCCESSSTATUS {
                 self.resultArrayBlock!([],true)
            }else{
                self.resultArrayBlock!([],false)
            }
        }
    }
    
    //MARK: -  更换个人手机号
    public func getChangeUserPhone(dic:NSMutableDictionary) -> Void  {
        
        SessionManager.shareManager(ret: false,isShowProgress: false).asyncRequest(methodType: .POST, urlString: ChangeUserPhone, parameters: dic) { (responseData:Any?)  in
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
           
            if baseModel?.status == SUCCESSSTATUS {
                self.resultArrayBlock!([],true)
            }else{
                self.resultArrayBlock!([],false)
            }
        }
    }
    
    //MARK: -  更换头像
    public func getChangeUserHeadPt(dic:NSMutableDictionary,image:UIImage) -> Void  {
        
//        SessionManager.shareManager(ret: false,isShowProgress: false).asyncRequest(methodType: .POST, urlString: ChangeUserHeader, parameters: dic) { (responseData:Any?)  in
//            let dic = responseData as! NSDictionary
//            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
//            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
//
//            if baseModel?.status == SUCCESSSTATUS {
//                self.resultArrayBlock!([],true)
//            }else{
//                self.resultArrayBlock!([],false)
//            }
//        }
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequestWithImage(urlString: ChangeUserHeader, parameters: dic, img: image) { (responseData:Any?) in
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            
            if baseModel?.status == SUCCESSSTATUS {
                self.resultArrayBlock!([],true)
            }else{
                self.resultArrayBlock!([],false)
            }
        }
    }
    
}
