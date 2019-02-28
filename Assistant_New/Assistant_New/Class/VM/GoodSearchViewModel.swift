//
//  GoodSearchViewModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/20.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class GoodSearchViewModel: BaseViewModel {
    
    var goodsModelData:GoodsModelData?
    //获取货品名称
    func getSearchGoodsTask(dic:NSMutableDictionary) -> Void {
        
        SessionManager.shareManager(ret: false, isShowProgress: false).asyncRequest(methodType: .POST, urlString: GetGoods, parameters: dic) { (responseData:Any?)  in
            if responseData == nil {
                print("获取货品名称失败")
                return;
            }
            let resultDic = responseData as! NSDictionary
            //MARK - 返回的responseData是一个字典，其中取response节点下的信息是message，result，status。这时候，取result下的data ,那么对应的模型里边为data下边的字段对应的数据类型转换即可
            let baseModel = BaseModel.deserialize(from: resultDic, designatedPath: "response")
            let resultModel = GoodsModelData.deserialize(from: baseModel?.result, designatedPath: "data")

            self.goodsModelData = resultModel
            self.resultArrayBlock!((resultModel?.goods)!,false)
        }
    }
    
}
