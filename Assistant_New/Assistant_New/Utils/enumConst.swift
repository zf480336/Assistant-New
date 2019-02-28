//
//  enumConst.swift
//  Assistant
//
//  Created by lxy on 2018/12/5.
//  Copyright © 2018年 lxy. All rights reserved.
//

import Foundation

enum ModuleName {
    case M_TASK
    case M_GOOD
    case M_ALREAD
}

enum UserTypeCode:String {
    case 公路 = "ENTREPOT_TYPE_ROAD"
    case 海运 = "ENTREPOT_TYPE_SEA"
    case 铁路 = "ENTREPOT_TYPE_RAILWAY"
    case 暂无 = "ENTREPOT_TYPE_NONE"
}
enum Business_type_code:String {
    case 集装箱 = "BUSINESS_TYPE_CONTAINER"
    case 散堆装 = "BUSINESS_TYPE_BULK_STACK"
    case 液态 = "BUSINESS_TYPE_LIQUID"
    case 冷链 = "BUSINESS_TYPE_COLD_CHAIN"
    case 商品车 = "BUSINESS_TYPE_VECHICLE"
    case 大件物品 = "BUSINESS_TYPE_LARGE_SIZE"
    case 三农化肥 = "BUSINESS_TYPE_CHEMICAL"
    case 批量 = "BUSINESS_TYPE_BATCH"
    case 快速配送 = "BUSINESS_TYPE_MULTI_TRANSPORT"
    
}

//设置复用Cell显示
enum BetchCellSubViews {
    case Already_info
    case Already_CarInfo
    case BatchDetail_BillInfo
    case BatchDetail_containerInfo
    case BatchDetail_conferInfo
    case BatchDetail_goodInfo
}

//Label文字对齐方式
enum Direction {
    case left
    case right
}

enum MyTaskList:String{
    case MyTask_All = "0" //全部传["3","4","5"]
    case MyTask_Ship = "3" //待发运
    case MyTask_Accept = "4"//待收货
    case MyTask_Pay = "5"//待交付
}

enum MyGoodList:String{
    case Goods_All = "0" //全部
    case Goods_Wait = "1" //代收
    case Goods_Had = "2"//已收
}

enum ReceiveList {
    case 全部
    case 待收
    case 已收
}
enum AlreadyHandleList:String {
    case ALL = "" //全部
    case DELIVERED = "1" //在途
    case ARRIVE = "2" //已抵达
    case PAID = "3" //已交付
}
