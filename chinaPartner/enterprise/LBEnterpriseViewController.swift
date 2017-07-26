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
        
        self.tableview.tableHeaderView = self.HeaderV
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.searchView.layer.borderWidth = 1
        self.searchView.layer.borderColor = UIColor.darkText.cgColor
        
    }
    
    private lazy var HeaderV:LBEnterpriseHeaderView={

        var myView:LBEnterpriseHeaderView = (Bundle.main.loadNibNamed("LBEnterpriseHeaderView", owner: nil, options: nil)?.first as? LBEnterpriseHeaderView)!
        myView.frame = CGRect(x: 0, y: 0, width: ScreenW , height: 285 * autoSizeScaleX )
        myView.autoresizingMask = []
        
        return myView
        
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

}

    extension LBEnterpriseViewController:UITableViewDelegate,UITableViewDataSource{
        
        private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 10
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
            if indexPath.row == 0 {
                var cell:LBBusinessOpportunityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBBusinessOpportunityTableViewCell", for: indexPath) as! LBBusinessOpportunityTableViewCell
                
                if cell.isEqual(nil){
                    
                    cell = LBBusinessOpportunityTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBBusinessOpportunityTableViewCell")
                }
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
