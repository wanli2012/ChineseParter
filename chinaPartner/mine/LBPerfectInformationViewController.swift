//
//  LBPerfectInformationViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBPerfectInformationViewController: UIViewController {

    @IBOutlet weak var contentW: NSLayoutConstraint!
    @IBOutlet weak var contentH: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = " 完善信息"
         self.navigationController?.navigationBar.isHidden = false
        self.automaticallyAdjustsScrollViewInsets = false
    }

    @IBAction func 头像修改(_ sender: Any) {
    }
    @IBAction func 姓名修改(_ sender: Any) {
    }

    @IBAction func 公司修改(_ sender: Any) {
    }
    @IBAction func 职务修改(_ sender: Any) {
    }
    @IBAction func 电话修改(_ sender: Any) {
    }
    @IBAction func 导航修改(_ sender: Any) {
    }

    @IBAction func 二维码修改(_ sender: Any) {
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        contentH.constant = 570
        contentW.constant = ScreenW
    }

}
