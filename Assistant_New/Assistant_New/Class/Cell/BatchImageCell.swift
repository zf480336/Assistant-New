//
//  BatchImageCell.swift
//  Assistant
//
//  Created by lxy on 2018/12/27.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class BatchImageCell: UITableViewCell {

    var boxModel:Any?{
        set{
            let model = newValue as? OrderContainer_listModel
            if ((model?.goods1_url) != nil) {
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(model?.goods1_url)!)
                self.imageView1.setImageWith(URL.init(string: ImageString as String)!, placeholderImage: UIImage.init(named: "tempImage"))
            }
            if ((model?.goods2_url) != nil) {
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(model?.goods2_url)!)
                self.imageView2.setImageWith(URL.init(string: ImageString as String)!, placeholderImage: UIImage.init(named: "tempImage"))
            }
            if ((model?.goods3_url) != nil) {
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(model?.goods3_url)!)
                self.imageView3.setImageWith(URL.init(string: ImageString as String)!, placeholderImage: UIImage.init(named: "tempImage"))
                
            }
        }
        get{
            return nil
        }
    }
    
    var box_Model:Any?{
        set{
            let model = newValue as? Good_OrderContainerModel
            if ((model?.goods1_url) != nil) {
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(model?.goods1_url)!)
                self.imageView1.setImageWith(URL.init(string: ImageString as String)!, placeholderImage: UIImage.init(named: "tempImage"))
            }
            if ((model?.goods2_url) != nil) {
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(model?.goods2_url)!)
                self.imageView2.setImageWith(URL.init(string: ImageString as String)!, placeholderImage: UIImage.init(named: "tempImage"))
            }
            if ((model?.goods3_url) != nil) {
                let ImageString = NSString.init(format: "%@%@",BaseImageUrl,(model?.goods3_url)!)
                self.imageView3.setImageWith(URL.init(string: ImageString as String)!, placeholderImage: UIImage.init(named: "tempImage"))
            }
        }
        get{
            return nil
        }
    }
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
