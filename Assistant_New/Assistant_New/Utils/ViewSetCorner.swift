//
//  ViewSetCorner.swift
//  Assistant
//
//  Created by lxy on 2018/11/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class ViewSetCorner: NSObject {

    static func setCornerRadius(corner:Int,view:UIView) -> Void {
        
        //画圆 UIBezierPath配合CAShapeLayer使用
//        let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: corner, height: corner))
//        let maskLayer = CAShapeLayer.init()
//        maskLayer.frame = view.frame
//        maskLayer.path = maskPath.cgPath
//        view.layer.mask = maskLayer
        view.layer.cornerRadius = CGFloat(corner)
        view.layer.masksToBounds = true
    }
    
    static func setBorders(boardWidth:Int,view:UIView, color:UIColor) -> Void {
        view.layer.borderWidth = CGFloat(boardWidth)
        view.layer.borderColor = color.cgColor
    }
}
