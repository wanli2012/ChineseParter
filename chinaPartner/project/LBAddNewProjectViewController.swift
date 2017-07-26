//
//  LBAddNewProjectViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBAddNewProjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新增项目"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        let item = UIBarButtonItem.init(customView: submitBtoon)
        self.navigationItem.rightBarButtonItem = item
    }
    
    
    @IBAction func 项目资质(_ sender: Any) {
        
        
    }
    
    @IBAction func 项目内容(_ sender: Any) {
        
        
    }

    @IBAction func 基本信息(_ sender: Any) {
        
        self.hidesBottomBarWhenPushed = true
        let vc = LBEssentialInformationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func 提交新增项目() -> Void{
        
        
    }
    
    private lazy var submitBtoon:UIButton={
        
        var button:UIButton = UIButton(type:.custom)
        button.frame = CGRect(x: 0, y: 0, width: 35 , height: 35 )
        button.setTitle("提交", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, -10)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action:#selector(LBAddNewProjectViewController.提交新增项目), for: UIControlEvents.touchUpInside)
        return button
        
    }()
    
   
 
}
