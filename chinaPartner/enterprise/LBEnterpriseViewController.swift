//
//  LBEnterpriseViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBEnterpriseViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var baseSearchV: UIView!
    var page = 1
    var dataArr:NSMutableArray = []
    var upDownBool:Bool=false
    var longitude:CGFloat=0
    var latitude:CGFloat=0
    var rePDataArr:NSMutableArray = [] //推荐项目列表
    var comPDataArr:NSMutableArray = [] //交流项目列表
    var geocoder = CLGeocoder()//反地理编码
    @IBOutlet weak var placelb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.view.backgroundColor = UIColor.white;
        let nib = UINib(nibName: "LBBusinessOpportunityTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib, forCellReuseIdentifier: "LBBusinessOpportunityTableViewCell")
        let nib1 = UINib(nibName: "LBVariousActivitiesTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib1, forCellReuseIdentifier: "LBVariousActivitiesTableViewCell")
        let nib2 = UINib(nibName: "LBProjectExchangeTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib2, forCellReuseIdentifier: "LBProjectExchangeTableViewCell")
        let nib3 = UINib(nibName: "LBCheckMoreTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib3, forCellReuseIdentifier: "LBCheckMoreTableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false;
        
        tableview.mj_header = LBCustomGifHeader.customRefreshHeaderBlock({
//             let delay = DispatchWallTime.now() + DispatchTimeInterval.seconds(1);
//            DispatchQueue.main.asyncAfter(wallDeadline: delay, execute: {
//                LBCustomGifHeader.endRefresh(self.tableview)
//            })
            
            self.首页行业分类()
            self.locManager.startUpdatingLocation();//开始定位
            
        })
        
//        tableview.mj_footer = LBCustomGifHeader.customRefreshFooterBlock({ 
//            let delay = DispatchWallTime.now() + DispatchTimeInterval.seconds(1);
//            DispatchQueue.main.asyncAfter(wallDeadline: delay, execute: {
//                LBCustomGifHeader.endRefresh(self.tableview)
//            })
//        })
        
        if CLLocationManager.locationServicesEnabled() {
            self.locManager.startUpdatingLocation();//开始定位
        }else{
            MBProgressHUD .showInfoMessage("请检查网络或打开定位");
            return
        }
        
           首页行业分类()
        
//        let  loadview = LoadWaitView.addloadview(self.view.frame, tagert: self.view)
//        let delay = DispatchWallTime.now() + DispatchTimeInterval.seconds(1);
//        DispatchQueue.main.asyncAfter(wallDeadline: delay, execute: {
//            loadview?.removeloadview()
//        })
        //MBProgressHUD.showActivityMessage(inView: nil)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.searchView.layer.borderWidth = 1
        self.searchView.layer.borderColor = UIColor.darkText.cgColor
        self.placelb.mas_makeConstraints { (make:MASConstraintMaker?) in
             make?.width.greaterThanOrEqualTo()(30)
             make?.width.lessThanOrEqualTo()(80)
        }
        
    }
    
     lazy var HeaderV:LBEnterpriseHeaderView={

        var myView:LBEnterpriseHeaderView = (Bundle.main.loadNibNamed("LBEnterpriseHeaderView", owner: nil, options: nil)?.first as? LBEnterpriseHeaderView)!
        myView.frame = CGRect(x: 0, y: 0, width: ScreenW , height: 285 * autoSizeScaleX )
        myView.autoresizingMask = []
        var tap = UITapGestureRecognizer.init(target: self, action: #selector(LBEnterpriseViewController.跳转搜索二))
        myView.search.addGestureRecognizer(tap)
        myView.delegete = self as! LBEnterpriseHeaderViewdelegete
        return myView
        
    }()
    
     lazy var locManager:CLLocationManager={
        
         var  locManager = CLLocationManager();//[[CLLocationManager alloc] init];
                locManager.delegate = self;
                locManager.desiredAccuracy = kCLLocationAccuracyBest;
                locManager.distanceFilter = 5.0;
                //设置定位权限 仅ios8有意义
               locManager.requestWhenInUseAuthorization();// 前台定位
        
        return locManager
        
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y <= 0) {
            self.baseSearchV.isHidden = true
            self.HeaderV.basesearchV.isHidden = false;
        }else{
            self.baseSearchV.isHidden = false
            self.HeaderV.basesearchV.isHidden = true;
            //self.baseSearchV.alpha = scrollView.contentOffset.y/64
        }
        
    }
    
    func 首页行业分类() -> Void {
        
                NetworkManager.requestPOST(withURLStr: "Shopone/info", paramDic: ["uid":UserModel.defaultUser().uid,"token":UserModel.defaultUser().token] as [AnyHashable : Any], finish: { (obj:Any?) in
                    let dic:NSDictionary=obj as! NSDictionary
                   LBCustomGifHeader.endRefresh(self.tableview)
                    if (dic["code"] as! Int)==1{
                        self.HeaderV.arr = dic["data"]  as!  Array<Any>
                       self.tableview.tableHeaderView = self.HeaderV
                    }else{
                        
                    }
                    
                }) { (error:Error?) in
                        LBCustomGifHeader.endRefresh(self.tableview)
                }
        
    }
    
    func 获取项目列表数据() -> Void {
        
        NetworkManager.requestPOST(withURLStr: "Shopone/GetItemData", paramDic: ["uid":UserModel.defaultUser().uid,"token":UserModel.defaultUser().token,"lat":NSNumber(value:Float(self.latitude)),"lng":NSNumber(value:Float(self.longitude))] as [AnyHashable : Any], finish: { (obj:Any?) in
            LBCustomGifHeader.endRefresh(self.tableview)
            let dic:NSDictionary=obj as! NSDictionary
            if (dic["code"] as! Int)==1{
                self.rePDataArr.removeAllObjects()
                self.comPDataArr.removeAllObjects()
                self.rePDataArr.addObjects(from: (dic["data"] as! Dictionary)["item_date_one"]!)
                self.comPDataArr.addObjects(from: (dic["data"] as! Dictionary)["item_date_two"]!)
                self.tableview.reloadData()
            }else{
                
            }
            
        }) { (error:Error?) in
            LBCustomGifHeader.endRefresh(self.tableview)
        }

    }
    
    @IBAction func 跳转搜索(_ sender: UITapGestureRecognizer) {
        self.hidesBottomBarWhenPushed = true
        let vc = GLNearby_SearchController()
        self.navigationController?.pushViewController(vc, animated:false)
        self.hidesBottomBarWhenPushed = false
        
    }
    
    func 跳转搜索二() -> Void {
        self.hidesBottomBarWhenPushed = true
        let vc = GLNearby_SearchController()
        self.navigationController?.pushViewController(vc, animated:false)
        self.hidesBottomBarWhenPushed = false

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    

}

    extension LBEnterpriseViewController:UITableViewDelegate,UITableViewDataSource{
        
        private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 3 + self.comPDataArr.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
            if indexPath.row == 0 {
                var cell:LBBusinessOpportunityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBBusinessOpportunityTableViewCell", for: indexPath) as! LBBusinessOpportunityTableViewCell
                
                if cell.isEqual(nil){
                    cell = LBBusinessOpportunityTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBBusinessOpportunityTableViewCell")
                }
                cell.dataArr = self.rePDataArr
                return cell
                
            }else if indexPath.row == 1{
                var cell:LBVariousActivitiesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBVariousActivitiesTableViewCell", for: indexPath) as! LBVariousActivitiesTableViewCell
                
                if cell.isEqual(nil){
                    
                    cell = LBVariousActivitiesTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBVariousActivitiesTableViewCell")
                }
                
                return cell
            }else if indexPath.row == 2{
                var cell:LBCheckMoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBCheckMoreTableViewCell", for: indexPath) as! LBCheckMoreTableViewCell
                
                if cell.isEqual(nil){
                    
                    cell = LBCheckMoreTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBCheckMoreTableViewCell")
                }
            
                return cell
                
            }else{
            
                var cell:LBProjectExchangeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBProjectExchangeTableViewCell", for: indexPath) as! LBProjectExchangeTableViewCell
                
                if cell.isEqual(nil){
                    
                    cell = LBProjectExchangeTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBProjectExchangeTableViewCell")
                }
                
                cell.dataDic = self.comPDataArr[indexPath.row - 3] as? NSDictionary
                
                return cell
            }
           
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            if indexPath.row == 0 {
                 return 210 * autoSizeScaleX
            }else if indexPath.row == 1{
              return 100
            }else if indexPath.row == 2{
                return 44
            }
            return 120
        }
    }

extension LBEnterpriseViewController:CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations[0]
        
        self.longitude = CGFloat(newLocation.coordinate.longitude)
        self.latitude = CGFloat(newLocation.coordinate.latitude)
        self.geocoder.reverseGeocodeLocation(newLocation) { (placemark:[CLPlacemark]?, error:Error?) in
            if (error != nil) || placemark?.count == 0{
               MBProgressHUD.showWarnMessage("找不到该地方")
                return
            }
            
            let placem:CLPlacemark = (placemark?.first)!
            self.placelb.text = placem.thoroughfare
            self.HeaderV.placelb.text = placem.thoroughfare
            
        }
        self.locManager.stopUpdatingLocation()
        
        获取项目列表数据()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        
    }
    
}

extension LBEnterpriseViewController:LBEnterpriseHeaderViewdelegete{

    func 点击首页分类(index: NSInteger) {
        self.hidesBottomBarWhenPushed = true
        let vc = GLBusiness_PreferredController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }

}
