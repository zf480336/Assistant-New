//
//  Const.swift
//  Assistant
//
//  Created by lxy on 2018/11/27.
//  Copyright © 2018年 lxy. All rights reserved.
//
//
import Foundation

//MARK: - 测试环境 --- Url相关
//let BaseUrl = "http://192.168.1.128:8340"
//let BaseUrl = "http://192.168.1.127:8340"
let BaseUrl = "http://192.168.1.60:8340"
let BaseImageUrl = "http://192.168.1.220:8888/"
//60测试

//正式地址

let LoginUrl = "/logistics/user/login/v1" //登录

let DoSign = "/logistics/user/doSign/v1" //用户签到
let GetSignInfo = "/logistics/user/getSignInfo/v1" //获取签到信息
let Home_waybill = "/logistics/waybill/getRunningTask/v1"  //任务列表
let GetUserInfo = "/logistics/user/getUserInfo/v1"  //用户信息
let TaskDetails = "/logistics/waybill/getTaskDetails/v1" //任务详情/user/getUserEntrepots/v1
let UserEntrepots = "/logistics/user/getUserEntrepots/v1" //获取用户所有网点
let ChangeUserEntrepots = "/logistics/user/changeUserEntrepots/v1" //更换用户网点
let ChangeUserPhone = "/logistics/user/changeUserEntrepots/v1" //更换用户手机号
let ChangeUserHeader = "/logistics/user/changeAvatar/v1" //更换头像

//货品管理
let OrderContainer = "/logistics/order/getRunningOrderContainer/v1" //首页货品管理
let OrderContainerDetails = "/logistics/order/getRunningContainerDetails/v1" //首页货品管理详情
let OrderContainerList = "/logistics/waybill/getOrderContainerList/v1" //获取箱子列表
let Order_ContainerList = "/logistics/order/getOrderContainerList/v1" //获取箱子列表
let OrderContainerListWithWaybillId = "/logistics/order/getContainerListWithWaybillId/v1" //获取箱子列表及运单绑定情况
let OrderContainerDetail = "/logistics/waybill/getWaybillDetailsByCode/v1" //获取箱子详情
let GetGoods = "/logistics/goods/getGoods/v1" //获取搜索货品名称
let CollectionContainer = "/logistics/order/collectionContainer/v1" //箱子录入保存接口
let ContainerOperationList = "/logistics/waybill/getContainerOperationList/v1" //已办列表查询

let EntrepotList = "/logistics/entreepot/getEntrepotList/v1" //获取发运网点列表
let BindContainer = "/logistics/waybill/bindContainer/v1" //确认发运
let UnLoadWaybillListByOrderCode = "/logistics/waybill/getUnLoadWaybillListByOrderCode/v1" //获取未绑定的运单号

let ReceiveWaybill = "/logistics/waybill/receiveWaybill/v1" //办理收货
let FinishWaybill = "/logistics/waybill/finishWaybill/v1" //办理交付

let ContainerOperation = "/logistics/waybill/getContainerOperation/v1" //根据运单id查询已办列表
//MARK: - 文件路径
let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
let filePath = docPath.appendingPathComponent("history.archive")


//MARK: - 字符串相关

let TOKEN = "token" //用户token
let UserKey = "UserKey"  //UserDefalut存储用户模型的Key
let EntrepotKey = "EntrepotKey" //网点
let EntrepotIDKey = "EntrepotIDKey" //网点ID
//MARK: - 固定数值相关
let SUCCESSSTATUS = "10000"
let pageNum = "20"


//MARK: - 布局相关
let SCREEN_W = (Int)(UIScreen.main.bounds.size.width)
let SCREEN_H = (Int)(UIScreen.main.bounds.size.height)

let NavHeaderHeight = (Int)((SCREEN_H == 812)||(SCREEN_H == 896) ?88:64)
let TabFooterHeight = (Int)(SCREEN_H == 812 ?78:44)
let TabIphone_X = (Int)(SCREEN_H == 812 ?34:0)

func IPHONE_X() -> Bool {
    if (SCREEN_H == 812) {
        return true
    }
    return false
}

func IPHONE_XS_MAX() -> Bool {
    if (SCREEN_H == 896) {
        return true
    }
    return false
}

//MARK: - 系统相关
let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""

let Color_VcBack = HexColor.getHex(hexString: "#F8F8F8", alpha: 1)


//MARK: - 格式化打印
func printLog<T>(message: T,file: String = #file,method: String = #function,line: Int = #line)
{
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    
}

