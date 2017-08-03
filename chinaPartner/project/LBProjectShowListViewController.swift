//
//  LBProjectShowListViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBProjectShowListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
     var vcindex:Int = 0
     var dataArr:NSMutableArray = []
     var type:NSInteger = 1
     var page:NSInteger = 1
     var refreshStaues:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray;
        let nib = UINib(nibName: "LBProjectExchangeTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib, forCellReuseIdentifier: "LBProjectExchangeTableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false;
        
        请求数据列表()
        
        
        tableview.mj_header = LBCustomGifHeader.customRefreshHeaderBlock({
            self.下拉刷新()
        })
        
        tableview.mj_footer = LBCustomGifHeader.customRefreshFooterBlock({
            self.上拉刷新()
        })

       
    }
    
    
    func 下拉刷新()  {
        
        page = 1
        refreshStaues = true
        请求数据列表()
    }
    
    func 上拉刷新()  {
        page = 1 + page
        refreshStaues = true
        请求数据列表()
    }
    
    
    func 请求数据列表() {
        
        NetworkManager.requestPOST(withURLStr: "Merchantproject/ProjectList", paramDic: ["uid":UserModel.defaultUser().uid,"token":UserModel.defaultUser().token,"type":NSNumber(value:NSInteger(self.type))] as [AnyHashable : Any], finish: { (obj:Any?) in
            LBCustomGifHeader.endRefresh(self.tableview)
            let dic:NSDictionary=obj as! NSDictionary
            if (dic["code"] as! Int)==1{
                if self.refreshStaues == true{
                    self.dataArr.removeAllObjects()
                }
                self.dataArr.addObjects(from: dic["data"] as! [Any])
                self.tableview.reloadData()
            }else{
                
            }
            
        }) { (error:Error?) in
            LBCustomGifHeader.endRefresh(self.tableview)
        }
        
    }

}


extension LBProjectShowListViewController:UITableViewDelegate,UITableViewDataSource{
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:LBProjectExchangeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBProjectExchangeTableViewCell", for: indexPath) as! LBProjectExchangeTableViewCell
        
        if cell.isEqual(nil){
            
            cell = LBProjectExchangeTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBProjectExchangeTableViewCell")
        }
        
        cell.dataDic = self.dataArr[indexPath.row] as? NSDictionary
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 120
    }
}
