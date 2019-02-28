//
//  Label.swift
//  Assistant
//
//  Created by lxy on 2018/12/3.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

extension UILabel {
    
    //MARK: - 改变行间距
    static func setParagraphWithLineHeight(lineHeight:Int,str:NSString,aligement:NSTextAlignment) -> NSAttributedString {
//        let str = "计划起运时间\n运力类型\n数量\n集装箱类型"
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        paraph.alignment = aligement
        paraph.lineBreakMode = NSLineBreakMode.byWordWrapping
        //将行间距设置为28
        paraph.lineSpacing = CGFloat(lineHeight)
        //样式属性集合
        let attributes = [kCTParagraphStyleAttributeName: paraph]

        
        var resultStr:NSAttributedString = NSAttributedString(string: str as String, attributes: attributes as [NSAttributedStringKey : Any])
//        let resultMuableStr:NSMutableAttributedString = NSMutableAttributedString.init(attributedString: resultStr)
//
//        let range:NSRange = (resultStr.string as NSString).range(of: "计划起运")
//        resultMuableStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
//        resultMuableStr.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 18.0), range: range)
//        resultStr = resultMuableStr
        return resultStr
    }
}
