//
//  basenavagationViewController.swift
//  Three lane
//
//  Created by sm on 16/11/9.
//  Copyright © 2016年 sm. All rights reserved.
//

import UIKit

class basenavagationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = {[
            
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: 16)
            
            ]}()
        
        self.navigationBar.tintColor = UIColor(red: 58/255.0, green: 58/255.0, blue: 58/255.0, alpha: 1)
        self.navigationBar.isHidden = true;
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.visibleViewController?.navigationItem.hidesBackButton = true;
        
        let item = UIBarButtonItem.init(customView: backBtoon)
        self.visibleViewController?.navigationItem.leftBarButtonItem = item
        
    }
    
    private lazy var backBtoon:UIButton={
        
        var button:UIButton = UIButton(type:.custom)
        button.frame = CGRect(x: 0, y: 0, width: 35 , height: 35 )
        button.setImage(UIImage(named:"标题栏返回键"), for: UIControlState.normal)
        button.imageEdgeInsets =  UIEdgeInsetsMake(6, -5, 4, 15)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action:#selector(basenavagationViewController.返回上一界面), for: UIControlEvents.touchUpInside)
        return button
        
    }()
    
    func 返回上一界面() -> Void {
        self.popViewController(animated: true)
    }
    

}
