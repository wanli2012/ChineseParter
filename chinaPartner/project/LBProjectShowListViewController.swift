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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray;
        let nib = UINib(nibName: "LBProjectExchangeTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib, forCellReuseIdentifier: "LBProjectExchangeTableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false;
       
    }

}


extension LBProjectShowListViewController:UITableViewDelegate,UITableViewDataSource{
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:LBProjectExchangeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBProjectExchangeTableViewCell", for: indexPath) as! LBProjectExchangeTableViewCell
        
        if cell.isEqual(nil){
            
            cell = LBProjectExchangeTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBProjectExchangeTableViewCell")
        }
        
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
