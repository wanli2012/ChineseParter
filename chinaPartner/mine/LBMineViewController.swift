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
    static var headerImageHeight : CGFloat = 340 * autoSizeScaleX //头部视图高度
    lazy var titleArr:Array = {["我的订单","我的项目","推荐","做达人  享特权","会员俱乐部"]}()
    lazy var imageArr:Array = {["订单","我的项目","推荐","特权","会员"]}()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green;
        
        let nib = UINib(nibName: "LBMineListTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableview.register(nib, forCellReuseIdentifier: "LBMineListTableViewCell")

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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断是否改变
        if (scrollView.contentOffset.y < -LBMineViewController.headerImageHeight) {
            var rect:CGRect = self.HeaderV.frame;
            //我们只需要改变图片的y值和高度即可
            rect.origin.y = scrollView.contentOffset.y;
            rect.size.height =  -scrollView.contentOffset.y ;
            self.HeaderV.frame = rect;
            
        }
       
    }


}

//tableView 代理方法
extension LBMineViewController:UITableViewDelegate,UITableViewDataSource{
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titleArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            var cell:LBMineListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBMineListTableViewCell", for: indexPath) as! LBMineListTableViewCell
            
            if cell.isEqual(nil){
                
                cell = LBMineListTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LBMineListTableViewCell")
            }
        
           cell.VIPLb.text = titleArr[indexPath.row] as String
           cell.imageV.image = UIImage(named:self.imageArr[indexPath.row] )
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       
        return 60
    }
    
    
}
