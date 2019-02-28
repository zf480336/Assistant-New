//
//  GoodSearchController.swift
//  Assistant
//
//  Created by lxy on 2018/12/20.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit
import MJRefresh
class GoodSearchController: BaseViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
   
    var goodSearchViewModel:GoodSearchViewModel?
    var mj_footer:MJRefreshAutoStateFooter = MJRefreshAutoStateFooter()
    var goodNameBlock:((_ name:String)->())?

    lazy var search:UISearchBar = {
        let searchbar = UISearchBar.init(frame: CGRect.init(x: 15, y: 5, width: SCREEN_W-73, height: 30))
        searchbar.delegate = self
        searchbar.tintColor = HexColor.getHex(hexString: "#ECB64A", alpha: 1)
        searchbar.placeholder = "请输入关键字"
        let image:UIImage = UIImage.getWith(HexColor.getHex(hexString: "#f8f8f8f", alpha: 1), andSize: CGSize.init(width: SCREEN_W-70, height: 28)).createRadius(5) as! UIImage
        searchbar.setSearchFieldBackgroundImage(image, for: UIControlState.normal)
        let textField:UITextField = searchbar.value(forKey: "_searchField") as! UITextField
        textField.attributedPlaceholder = NSAttributedString.init(string:"请输入关键字", attributes: [kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize:14)])
        return searchbar
    }()
    
    lazy var searchHistory:UICollectionView = {
       
        let collecView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLeftAlignedLayout.init())
        collecView.delegate = self
        collecView.dataSource = self
        collecView.register(EntryCollectionCell.classForCoder(), forCellWithReuseIdentifier: "EntryCollectionCell")
        collecView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")
        collecView.backgroundColor = HexColor.getHex(hexString: "#ffffff", alpha: 1)
        
        return collecView
    }()
    
    lazy var searchHistoryData:NSMutableArray = {
        let array = NSMutableArray.init()
        return array
    }()
    
    lazy var tableView:UITableView = {
        let tab = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight), style: UITableViewStyle.plain)
        tab.delegate = self
        tab.dataSource = self
        tab.bounces = false
        tab.separatorStyle = UITableViewCellSeparatorStyle.none
        tab.rowHeight = UITableViewAutomaticDimension
        tab.estimatedRowHeight = 100.0
        tab.register(SearchResultCell.classForCoder(), forCellReuseIdentifier: "SearchResultCell")
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
        let contact = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSMutableArray
        if contact != nil {
            self.searchHistoryData = contact!
        }else{
            NSKeyedArchiver.archiveRootObject(self.searchHistoryData, toFile: filePath)
        }
    }
    
    func setViews() -> Void {
        self.view.backgroundColor = UIColor.white
        
        self.NaviRight?.isHidden = false
        self.NaviRight?.setTitle("取消", for: UIControlState.normal)
        
        self.searchHistory.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight)
        self.view.addSubview(self.searchHistory)
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - NavHeaderHeight)
        self.tableView.mj_footer = self.mj_footer
        self.view.addSubview(self.tableView)
        self.tableView.isHidden = true
        
        self.goodSearchViewModel = GoodSearchViewModel()
        self.goodSearchViewModel?.resultArrayBlock = {(array:Array,ret:Bool) in
            self.tableView.reloadData()
        }
    }
    
    func setViewModel() -> Void {
        self.goodSearchViewModel = GoodSearchViewModel.init()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(self.search)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldValueChanged(noti:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.search.removeFromSuperview()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
     //MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchHistoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:EntryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EntryCollectionCell", for: indexPath) as! EntryCollectionCell
        let content:NSString = self.searchHistoryData[indexPath.row] as! NSString
        let size:CGSize = content.size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16.0)])
        cell.textLabel.frame = CGRect.init(x: 0, y: 0, width:size.width+20, height: 35)
        cell.textLabel.text = content as String
        cell.bg.frame = cell.textLabel.frame
        cell.bg.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }
    
    //MARK: - 返回的item大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let content:NSString = self.searchHistoryData[indexPath.row] as! NSString
        let size:CGSize = content.size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16.0)])
        return  CGSize.init(width: size.width+20, height: 35)
    }
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 20
    }
    
    //MARK: - 设置每组Cell的边界
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 20, 10, 20)
    }
    
    //MARK: - 分组头高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{

        return CGSize(width: SCREEN_W, height: 44)
    }
  
    
    //MARK: - 设置分组头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
            if headerView.subviews.count == 0 {
                headerView.backgroundColor = HexColor.getHex(hexString: "#F8F8F8", alpha: 1)
                let titleLabel = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 151, height: 44))
                titleLabel.text = "历史记录"
                titleLabel.textColor = HexColor.getHex(hexString: "#999999", alpha: 1)
                titleLabel.font = UIFont.systemFont(ofSize: 14.0)
                headerView.addSubview(titleLabel)
                
                let button = UIButton.init(frame: CGRect.init(x: SCREEN_W - 80 , y: 0, width: 60, height: 44))
                button.setTitle("清除历史", for: UIControlState.normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
                button.setTitleColor(HexColor.getHex(hexString: "#999999", alpha: 1), for: UIControlState.normal)
                button.addTarget(self, action: #selector(pressClearBtn), for: UIControlEvents.touchUpInside)
                headerView.addSubview(button)
                
                let imageView = UIImageView.init(frame: CGRect.init(x: SCREEN_W - 94, y: 15, width: 13, height: 13))
                imageView.image = UIImage.init(named: "iconfont-shanchu")
                headerView.addSubview(imageView)
            }
            return headerView
        }else{
            return UICollectionReusableView.init()
        }
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.goodSearchViewModel?.goodsModelData?.goods?.count) != nil {
             return (self.goodSearchViewModel?.goodsModelData?.goods?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SearchResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        cell = (Bundle.main.loadNibNamed("SearchResultCell", owner: self, options: nil)?.first as? SearchResultCell)!
        cell.model = self.goodSearchViewModel?.goodsModelData?.goods?[indexPath.row]
        return cell
    }
    
    
    //MARK: - SearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    //MARK: - Action
    override func pressNaviRight() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - 搜索框输入变化的事件
    @objc fileprivate func textFieldValueChanged(noti:NSNotification) -> Void {
        let field = noti.object as! UITextField;
        if (field.markedTextRange != nil) {
            return
        }
        if (field.text?.count)! < 1 {
            self.searchHistory.isHidden = false
            self.tableView.isHidden = true
            return
        }

        self.goodSearchViewModel?.params.setValue(field.text, forKey: "keywords")
        self.goodSearchViewModel?.setRequestDic()
        self.goodSearchViewModel?.getSearchGoodsTask(dic: (self.goodSearchViewModel?.data)!)
        self.goodSearchViewModel?.resultArrayBlock = {(array:Array<Any>,isEnd:Bool) -> Void in
            self.searchHistory.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
            if array.count > 0 {
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.idle)
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.willRefresh)
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.refreshing)
                self.mj_footer.setTitle("数据全部加载完成", for: MJRefreshState.noMoreData)
            }else{
                self.mj_footer.setTitle("暂无相关数据", for: MJRefreshState.idle)
                self.mj_footer.setTitle("暂无相关数据", for: MJRefreshState.willRefresh)
                self.mj_footer.setTitle("暂无相关数据", for: MJRefreshState.refreshing)
                self.mj_footer.setTitle("暂无相关数据", for: MJRefreshState.noMoreData)
            }
        }
    }
    //MARK: - tableView  ACTION
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //FIXME:将选择项，存入文件
        let goodModel = self.goodSearchViewModel?.goodsModelData?.goods?[indexPath.row]
        let contact = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSMutableArray
        if contact?.count == 0 {
            contact?.add(goodModel?.name as Any)
        }else{
            for (_,value) in (contact?.enumerated())! {
                if goodModel?.name == (value as! String) {
                    contact?.remove(value)
                }
            }
            contact?.add(goodModel?.name as Any)
            let firstObject = contact?.firstObject
            let lastObject = contact?.lastObject
            contact?.replaceObject(at: 0, with: lastObject as Any)
            contact?.replaceObject(at: (contact?.count)!-1, with: firstObject as Any)
            if contact?.count == 21 {
                contact?.removeLastObject()
            }
        }
        NSKeyedArchiver.archiveRootObject(contact as Any, toFile: filePath)
        
        if (self.goodNameBlock != nil) {
            self.goodNameBlock!((goodModel?.name)!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - COll  ACTIon
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: - 先取后存
        let goodName:String = self.searchHistoryData[indexPath.row] as! String
        if (self.goodNameBlock != nil) {
            self.goodNameBlock!(goodName)
        }
        let firstObject = self.searchHistoryData.firstObject
        let lastObject = self.searchHistoryData.lastObject
        self.searchHistoryData.replaceObject(at: 0, with: lastObject as Any)
        self.searchHistoryData.replaceObject(at: self.searchHistoryData.count-1, with: firstObject as Any)
        NSKeyedArchiver.archiveRootObject(self.searchHistoryData as Any, toFile: filePath)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressClearBtn() -> Void {
         let contact = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSMutableArray
         contact?.removeAllObjects()
         self.searchHistoryData = contact!
         NSKeyedArchiver.archiveRootObject(contact as Any, toFile: filePath)
         self.searchHistory.reloadData()
    }

}
