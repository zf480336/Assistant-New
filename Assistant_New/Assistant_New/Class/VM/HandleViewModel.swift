//
//  HandleViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/29.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class HandleViewModel: BaseViewModel {

    var hideArr:NSMutableArray?
    //MARK: - 办理发运
    public func getBindContainer(dic:NSMutableDictionary) -> Void  {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: BindContainer, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                return
            }
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
    
    //MARK: - 获取未绑定的运单号
    
    public func getBindContainerWayBill(dic:NSMutableDictionary) -> Void  {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: UnLoadWaybillListByOrderCode, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                return
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let result = WayBillModel.deserialize(from: baseModel?.result, designatedPath: "data")
            var array:Array = (result?.waybillList)!
            
            if self.hideArr?.count ?? 0 > 0{
                for (_ ,value) in (self.hideArr!.enumerated()){
                    let model_has:OrderContainer_listModel = value as! OrderContainer_listModel
                    for (index ,value) in (array.enumerated()){
                        let model:billModel = value
                        if model_has.waybillCarrierId == model.waybillCarrierId {
                            array.remove(at: index)
                        }
                    }
                }
            }
            
            self.dataArray = array
            if baseModel?.status == SUCCESSSTATUS {
                self.resultArrayBlock!(array,true)
            }else{
                self.resultArrayBlock!([],false)
            }
        }
    }
    
    //MARK: - 办理收货
    public func getReceiveWaybill(dic:NSMutableDictionary) -> Void  {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: ReceiveWaybill, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                return
            }
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
    
    //MARK: - 办理交付
    public func getFinishWaybill(dic:NSMutableDictionary) -> Void  {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: FinishWaybill, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                return
            }
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
    
}
