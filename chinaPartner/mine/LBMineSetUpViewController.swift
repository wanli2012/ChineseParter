

//
//  LBMineSetUpViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBMineSetUpViewController: UIViewController {

    @IBOutlet weak var msgNoticeImage: UIImageView!
    @IBOutlet weak var sizeLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "设置"
         self.navigationController?.navigationBar.isHidden = false

    }

    @IBAction func 消息提示设置(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func 分享设置(_ sender: UITapGestureRecognizer) {
    }
    @IBAction func 清除缓存(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func 修改密码(_ sender: Any) {
    }
    
    @IBAction func 关于我们(_ sender: Any) {
    }
    

}
