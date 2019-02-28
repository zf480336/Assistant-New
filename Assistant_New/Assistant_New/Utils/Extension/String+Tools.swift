//
//  String+Tools.swift
//  Assistant
//
//  Created by lxy on 2019/1/15.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

extension String {
    
    //MARK: - 毫秒转字符串
    
    static func timeStampToString(timeStamp: Double) -> String {
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
//        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        dfmatter.dateFormat="yyyy-MM-dd"
        return dfmatter.string(from: date as Date)
    }

    
}
