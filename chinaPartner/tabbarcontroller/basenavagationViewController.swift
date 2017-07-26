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
            NSFontAttributeName: UIFont.systemFont(ofSize: 17)
            
            ]}()
        
        self.navigationBar.tintColor = UIColor(red: 58/255.0, green: 58/255.0, blue: 58/255.0, alpha: 1)
        self.navigationBar.isHidden = true;
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        //let item = UIBarButtonItem.appearance()
        
        //let dic = NSMutableDictionary()
        //dic[NSFontAttributeName] = UIFont.systemFont(ofSize: 15)
        //dic[NSForegroundColorAttributeName] = UIColor.red;
        //item.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 15),NSForegroundColorAttributeName:UIColor.red], for: UIControlState.normal)
        
    }

}
