//
//  LBEssentialInformationViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBEssentialInformationViewController: UIViewController {

    @IBOutlet weak var contentW: NSLayoutConstraint!
    @IBOutlet weak var contentH: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "项目信息"
       self.automaticallyAdjustsScrollViewInsets = false
        
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.contentW.constant = ScreenW
        self.contentH.constant = 564;
    }

    

}
