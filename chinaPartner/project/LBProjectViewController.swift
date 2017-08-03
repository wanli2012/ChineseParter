//
//  LBProjectViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBProjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
        加载界面()
        
    }

    func 加载界面() -> Void {
        
        VCManager.title_font = UIFont.systemFont(ofSize: 15)
        VCManager.sliderWidthType = .ButtonWidth
        VCManager.title_array = subviewTitles
        setConstraint()
        
    }
    
    fileprivate func setConstraint(){
        
        pageMagager.view.snp.makeConstraints { (make) in
            make.top.equalTo(VCManager.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-49)
        }
    }
    
    lazy var subviewTitles:[String] = {
        
        let array = ["已投放", "被驳回","未投放","审核中","被冻结","已过期"]
        return array
        
    }()
    
    lazy var VCManager:VCManagerView = {
        
        let manager = VCManagerView(frame:CGRect.init(x: 0, y: 64, width: kScreenW, height: 44))
        manager.delegate = self
        self.view.addSubview(manager)
        
        return manager
        
    }()
    lazy var pageMagager:PageManagerVC = {
       
        let manager = PageManagerVC.init(superController: self, childControllerS:self.vcArr)
        manager.delegate = self
        self.view.addSubview(manager.view)
        return manager
        
    }()
    
    lazy var vcArr:[UIViewController] = {
        
        var array:NSMutableArray = []
        for i in 0..<6 {
             let vc = LBProjectShowListViewController()
            vc.type = i+1
            array.add(vc)
        }
        return array as! [UIViewController]
        
    }()
 
    @IBAction func addProject(_ sender: UIButton) {
        
        self.hidesBottomBarWhenPushed = true
        let vc = LBAddNewProjectViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
   

}

extension LBProjectViewController:VCManagerDelegate,PageManagerVC_Delegate{
    
    
    func VCManagerDidSelected(_ VCManager: VCManagerView, index: NSInteger, title: String) {
        
        pageMagager.setCurrentVCWithIndex(index)
    }
    func PageManagerDidFinishSelectedVC(indexOfVC: NSInteger) {
        VCManager.reloadSelectedBT(at: indexOfVC)
    }
    
}


    

