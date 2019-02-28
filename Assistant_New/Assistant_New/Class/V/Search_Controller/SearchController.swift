//
//  SearchController.swift
//  Assistant
//
//  Created by lxy on 2018/11/30.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class SearchController: BaseViewController,UISearchBarDelegate {

    var CodeStr:String?
    var status:String?
    
    var searchBlock:((_ code:String) -> ())?
    
    @IBOutlet weak var searchBar: UISearchBar!
    let curttenIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.text = "D2018121014074200000"
        self.searchBar.delegate = self
        self.searchBar.tintColor = HexColor.getHex(hexString: "#FFFFFF", alpha: 0.9)
        self.searchBar.setImage(UIImage.init(named: "searchBar_search"), for: UISearchBarIcon.search, state: UIControlState.normal)
        self.searchBar.setImage(UIImage.init(named: "searchBar_delete"), for: UISearchBarIcon.clear, state: UIControlState.normal)
        self.leftButton?.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.leftButton?.imageEdgeInsets.left = -12
        
        let titleArray = ["运单号","批次号","箱号","车底号"]
        
        let segment = UISegmentedControl.init(items: titleArray)
        segment.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W-100, height: 30)
        segment.tintColor = HexColor.getHex(hexString: "#FFFFFF", alpha: 0.38)
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.white], for: UIControlState.selected)
        segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.white], for: UIControlState.normal)
        segment.addTarget(self, action: #selector(pressSegment(sender:)), for: UIControlEvents.valueChanged)
        self.navigationItem.titleView = segment
        
        let textField:UITextField = self.searchBar.value(forKey: "_searchField") as! UITextField
        textField.attributedPlaceholder = NSAttributedString.init(string:"输入你需要的服务号", attributes: [kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize:15)])
        textField.backgroundColor = HexColor.getHex(hexString: "#5998cd", alpha: 1)
        textField.textColor = HexColor.getHex(hexString: "#FFFFFF", alpha: 0.81)
        textField.font = UIFont.systemFont(ofSize: 14)
        ViewSetCorner.setCornerRadius(corner: 16, view: textField)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        
    }
    
    
    
    //MARK: - Action
    @objc func pressSegment(sender:UISegmentedControl) -> Void {
        switch sender.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
        if (self.searchBlock != nil) {
            self.searchBlock!(searchBar.text!)
        }
        
    }
}
