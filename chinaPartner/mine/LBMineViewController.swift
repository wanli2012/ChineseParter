//
//  LBMineViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBMineViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    static var headerImageHeight : CGFloat = 280 * autoSizeScaleX //头部视图高度
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green;
        self.tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "hh")

        self.tableview.contentInset=UIEdgeInsetsMake(LBMineViewController.headerImageHeight, 0, 0, 0);
        self.tableview.addSubview(self.HeaderV)
        self.automaticallyAdjustsScrollViewInsets = false;
        
    }

    private lazy var HeaderV:LBMineHeaderView={
        
        var myView:LBMineHeaderView = (Bundle.main.loadNibNamed("LBMineHeaderView", owner: nil, options: nil)?.first as? LBMineHeaderView)!
        myView.frame = CGRect(x: 0, y: -headerImageHeight, width: ScreenW , height: headerImageHeight)
        myView.autoresizingMask = []
        
        return myView
        
    }()


}

//tableView 代理方法
extension LBMineViewController:UITableViewDelegate,UITableViewDataSource{
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "hh", for: indexPath) 
            
            if cell.isEqual(nil){
                
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "hh")
            }
        cell.textLabel?.text = "啊哈哈"
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       
        return 44
    }
    
    
}
