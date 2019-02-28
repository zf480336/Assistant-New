//
//  MyConfig.swift
//  Assistant
//
//  Created by lxy on 2018/12/10.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class MyConfig: NSObject {

    var user:User?{
        set{
            if user == nil {
                printLog(message: "没插入有效的User对象")
                assert(true, "没插入有效的User对象")
            }
            
            if newValue != nil {
                let users:User = newValue!
                
                let data:Data = NSKeyedArchiver.archivedData(withRootObject: users)
                UserDefaults.standard.set(data, forKey: UserKey)
                UserDefaults.standard.synchronize()
            }else{
                UserDefaults.standard.removeObject(forKey: UserKey)
            }
        }
        get{
            let data = UserDefaults.standard.value(forKey: UserKey) as? Data
            if data == nil {
                return User.init()
            }else{
                let user = NSKeyedUnarchiver.unarchiveObject(with: data!) as? User
                return user
            }
        }
    }
    
    var entrepotName:String?{
        set{
            if newValue != nil {
                let entrepot:String = newValue!
                UserDefaults.standard.set(entrepot, forKey: EntrepotKey)
                UserDefaults.standard.synchronize()
            }else{
                UserDefaults.standard.removeObject(forKey: EntrepotKey)
            }
        }
        get{
            let entrepot = UserDefaults.standard.value(forKey: EntrepotKey)
            if entrepot == nil {
                return nil
            }else{
                return (entrepot as! String)
            }
            
        }
    }
    var entrepot_id:String?{
        set{
            if newValue != nil {
                let entrepot_id:String = newValue!
                UserDefaults.standard.set(entrepot_id, forKey: EntrepotIDKey)
                UserDefaults.standard.synchronize()
            }else{
                UserDefaults.standard.removeObject(forKey: EntrepotIDKey)
            }
        }
        get{
            let entrepot_id = UserDefaults.standard.value(forKey: EntrepotIDKey)
            if entrepot_id == nil {
                return ""
            }else{
                return (entrepot_id as! String)
            }
        }
    }
    
    
    static let _config = MyConfig.init()
    
    static func shareConfig() -> MyConfig {
        return _config
    }
}
