//
//  GoodsViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/17.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class GoodsViewModel: BaseViewModel {

    var orderdetailModel:OrderContainerModel?
    var good_orderdetailListModel:Good_OrderContainerListModel?
    
    //MARK: - 获取我的任务列表数据
    func getRunningOrderContainer(dic:NSMutableDictionary,curtenIndex:Int) -> Void {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: OrderContainer, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取列表数据失败")
                self.resultArrayBlock!([],false)
                return;
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            
            if baseModel?.status == SUCCESSSTATUS {
                let resultModel = RunningOrders.deserialize(from: baseModel?.result, designatedPath: "data")
                
                let array:Array = (resultModel?.runningOrders)!
                self.dataArray = array
                self.resultArrayBlock!(array,false)
            }else{
                self.resultArrayBlock!([],false)
            }
        }
    }
    
    
    //MARK: - 获取箱子列表
    func getOrderContainerList(dic:NSMutableDictionary,curtenIndex:Int) -> Void {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: Order_ContainerList, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取箱子列表数据失败")
                self.resultArrayBlock!([],false)
                return;
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
            let resultModel = Good_OrderContainerListModel.deserialize(from: baseModel?.result, designatedPath: "data")
            self.good_orderdetailListModel = resultModel
            let array:Array = (resultModel?.containerList)!
            self.dataArray = array
            self.resultArrayBlock!(array,false)
        }
    }
    
    //MARK: - 货品管理获取箱子详情
    func getOrderContainerDetail(dic:NSMutableDictionary,curtenIndex:Int) -> Void {

        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: OrderContainerDetail, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取箱子详情失败")
//                self.resultArrayBlock!([],false)
                return;
            }
            let dic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: dic, designatedPath: "response")
//            let resultModel = OrderContainerListModel.deserialize(from: baseModel?.result, designatedPath: "data")
//            self.orderdetailListModel = resultModel
//            let array:Array = (resultModel?.orderContainerList)!
//            self.dataArray = array
//            self.resultArrayBlock!(array,false)
        }
    }
    
    //获取我的任务详情
    func getOrderContainerDetailTask(dic:NSMutableDictionary) -> Void {

        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: OrderContainerDetails, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取我的任务详情数据失败")
                return;
            }
            let resultDic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: resultDic, designatedPath: "response")
            let resultModel = OrderContainerModel.deserialize(from: baseModel?.result, designatedPath: "data")
            self.orderdetailModel = resultModel
//            self.resultArrayBlock!([],false)
            
            self.params.setValue(resultModel?.order?.code, forKey: "orderId")
            self.setRequestDic()
            self.getOrderContainerList(dic: dic, curtenIndex: 0)

        }
    }
}
