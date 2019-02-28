//
//  AlreadyViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class AlreadyViewModel: BaseViewModel{

    var taskDetailModel:TaskDetailModel?
    var orderdetailListModel:OrderContainerListModel?
    var linaNameModel:ContainerOperationModel?
     
    //MARK: - 获取我的任务列表数据
    func getRunningOrderContainer(dic:NSMutableDictionary,curtenIndex:Int) -> Void {
      
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: ContainerOperationList, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取列表数据失败")
                self.resultArrayBlock!([],false)
                return;
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let resultModel = AlreadyListModel.deserialize(from: baseModel?.result, designatedPath: "data")
            if resultModel?.containerOperationList == nil {
                self.dataArray = []
                self.resultArrayBlock!([],false)

            }else{
                let array:Array = (resultModel?.containerOperationList)!
                self.dataArray = array
                self.resultArrayBlock!(array,false)
            }
        }
    }
    
  
    //获取我的任务详情
    func getRunningDetailTask(dic:NSMutableDictionary,wayBillStatus:String) -> Void {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: TaskDetails, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取列表详情数据失败")
                return;
            }
            let result = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: result, designatedPath: "response")
            let resultModel = TaskDetailModel.deserialize(from: baseModel?.result, designatedPath: "data")
            self.taskDetailModel = resultModel
            //            self.resultArrayBlock!([],false)
            if wayBillStatus == "3" {
                self.params.setValue("1", forKey: "status")
                self.params.setValue(self.taskDetailModel?.taskDetailsask?.orderId, forKey: "orderId")
                self.setRequestDic()
                self.getOrderContainerList(dic: self.data, curtenIndex: 0)
            }else{
                self.params.setValue(self.taskDetailModel?.taskDetailsask?.waybillId, forKey: "waybillId")
                self.setRequestDic()
                self.getOrderContainerOperation(dic: self.data, curtenIndex: 0)
            }
        }
    }
    
    //MARK: - 获取箱子列表
    func getOrderContainerList(dic:NSMutableDictionary,curtenIndex:Int) -> Void {
  
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: OrderContainerListWithWaybillId, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取箱子列表数据失败")
                self.resultArrayBlock!([],false)
                return;
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let resultModel = OrderContainerListModel.deserialize(from: baseModel?.result, designatedPath: "data")
            self.orderdetailListModel = resultModel
            let array:Array = (resultModel?.containerList)!
            self.dataArray = array
            self.resultArrayBlock!(array,false)
        }
    }
    
    //MARK: - 根据运单id查询已办信息
    func getOrderContainerOperation(dic:NSMutableDictionary,curtenIndex:Int) -> Void {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: ContainerOperation, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取运单id查询已办信息失败")
                self.resultArrayBlock!([],false)
                return;
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let resultModel = ContainerOperationModel.deserialize(from: baseModel?.result, designatedPath: "data")
            self.linaNameModel = resultModel
//            self.params.setValue("1", forKey: "status")
            self.params.setValue(self.taskDetailModel?.taskDetailsask?.orderId, forKey: "orderId")
            self.setRequestDic()
            self.getOrderContainerList(dic: self.data, curtenIndex: 0)
        }
    }
}
