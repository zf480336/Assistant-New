//
//  UserInfoHeadCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/10.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class UserInfoHeadCell: BaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewSetCorner.setCornerRadius(corner: Int(self.headImageView.bounds.size.width/2), view: self.headImageView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setHeadImageView() -> Void {
        
        guard let url = MyConfig.shareConfig().user?.icon else {
            printLog(message: "没有设置头像")
            return
        }
      
        let headString = NSString.init(format: "%@%@",BaseImageUrl,url)
        self.headImageView.setImageWith(URL.init(string: headString as String)!, placeholderImage: UIImage.init(named: "tempHead"))
    }

}
//group1/M00/00/37/wKgB3FwzBIeAR9MBAACp7GyuZDQ030.jpg
