//
//  handleEstabModel.swift
//  Assistant
//
//  Created by lxy on 2018/12/28.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class handleEstabModel: BaseModel {
    var entrepotList:[entrepoModel]?
}

class entrepoModel: BaseModel {
    var name:String?
    var id:String?
    var address:String?
}
