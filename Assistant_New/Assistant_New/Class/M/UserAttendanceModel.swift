//
//  UserAttendanceModel.swift
//  Assistant
//
//  Created by lxy on 2019/1/9.
//  Copyright © 2019年 lxy. All rights reserved.
//

import UIKit

class UserAttendanceModel: BaseModel {
    var userAttendance:AttendanceModel?
}

class AttendanceModel: BaseModel {
    var update_time:String?
    var update_user_id:String?
    var remark:String?
    var id:String?
    var create_time:String?
    var user_id:String?
    var lastUpdate:String?
    var attendance_status:String?
    
}
