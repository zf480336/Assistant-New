//
//  GetGoodViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/21.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class GoodKeyInViewModel: BaseViewModel {

    
    //获取货品名称
    func getGoodKeyInTask(dic:NSMutableDictionary,model:KeyInModel,isEdit:Bool) -> Void {
        
        let userId = MyConfig.shareConfig().user?.id
        
        if isEdit {
            self.params.setValue(model.orderContainerId, forKey: "orderContainerId")
        }
        
        self.params.setValue(model.netWorkid, forKey: "entrepotId") //收箱网点id
        self.params.setValue(userId, forKey: "userId")
        self.params.setValue(model.orderID, forKey: "orderId")
        self.params.setValue(model.containerCode, forKey: "containerCode")
        self.params.setValue(model.rentCompany, forKey: "rentCompany")
        self.params.setValue(model.tel, forKey: "tel")
        self.params.setValue(model.useDate, forKey: "useDate")
        self.params.setValue(model.backDate, forKey: "backDate")
        self.params.setValue(model.loadDate, forKey: "loadDate")
        self.params.setValue(model.seal_code, forKey: "seal_code")
        self.params.setValue(model.tarpaulin_number, forKey: "tarpaulin_number")
        self.params.setValue(model.net_weight, forKey: "net_weight")
        self.params.setValue(model.gross_weight, forKey: "gross_weight")
        self.params.setValue(model.unitNumber, forKey: "unitNumber")
        
        
        setRequestDic()
        
//        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: CollectionContainer, parameters: self.data) { (responseData:Any?)  in
//            if responseData == nil {
//                print("获取货品名称失败")
//                return;
//            }
//            let resultDic = responseData as! NSDictionary
//            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
//            let baseModel = BaseModel.deserialize(from: resultDic, designatedPath: "response")
////            let resultModel = GoodsModelData.deserialize(from: baseModel?.result, designatedPath: "data")
//            if baseModel?.status == SUCCESSSTATUS {
//                self.resultArrayBlock!([],true)
//            }else{
//                self.resultArrayBlock!([],false)
//            }
//        }
//
        var imageArray = Array<Any>.init()
        if model.image1 != nil {
            imageArray.append(model.image1!)
        }
        if model.image2 != nil {
            imageArray.append(model.image2!)
        }
        if model.image3 != nil {
            imageArray.append(model.image3!)
        }
//
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequestWithGoodsImages(urlString: CollectionContainer, parameters: self.data, imageArray: imageArray) { (responseData:Any?)  in
            if responseData == nil {
                print("保存失败")
                return;
            }
            let resultDic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: resultDic, designatedPath: "response")
            //            let resultModel = GoodsModelData.deserialize(from: baseModel?.result, designatedPath: "data")
            if baseModel?.status == SUCCESSSTATUS {
                self.resultArrayBlock!([],true)
            }else{
                self.resultArrayBlock!([],false)
            }

        }
    }
    
    
}
