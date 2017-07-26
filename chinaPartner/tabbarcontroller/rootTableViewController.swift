//
//  rootTableViewController.swift
//  Three lane
//
//  Created by sm on 16/10/31.
//  Copyright © 2016年 sm. All rights reserved.
//

import UIKit


class rootTableViewController: UITabBarController,UITabBarControllerDelegate {
    var selectindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC  = LBEnterpriseViewController ()
        let navIndex=basenavagationViewController(rootViewController: firstVC);
        let item1 : UITabBarItem = UITabBarItem (title: "企业", image: UIImage(named: "企业"), selectedImage: UIImage(named: "企业选中"))
        firstVC.title="企业";
        item1.titlePositionAdjustment = UIOffsetMake(0, -2)
        //navIndex.tabBarItem.image=UIImage(named: "信封 (1).png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        //navIndex.tabBarItem.selectedImage=UIImage(named: "信封 (1).png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        navIndex.tabBarItem = item1
        
        let secondVC  = LBBusinessOpportunityViewController ()
        let navIndex1=basenavagationViewController(rootViewController: secondVC);
        let item2 : UITabBarItem = UITabBarItem (title: "商机", image: UIImage(named: "商机"), selectedImage: UIImage(named: "商机选中"))
        item2.titlePositionAdjustment = UIOffsetMake(0, -2)
        secondVC.title="商机"
        navIndex1.tabBarItem = item2
        
        let threeVC  = LBProjectViewController ()
        let navIndex2=basenavagationViewController(rootViewController: threeVC);
        let item3 : UITabBarItem = UITabBarItem (title: "项目", image: UIImage(named: "项目"), selectedImage: UIImage(named: "项目选中"))
        threeVC.title="项目"
        item3.titlePositionAdjustment = UIOffsetMake(0, -2)
        navIndex2.tabBarItem = item3
        
//        let fourVC  = LBCircleViewController ()
        let detailVC = GLBusiness_DetailController();
        let navIndex3=basenavagationViewController(rootViewController: detailVC);
        let item4 : UITabBarItem = UITabBarItem (title: "圈子", image: UIImage(named: "圈子"), selectedImage: UIImage(named: "圈子选中"))
        detailVC.title="圈子"
        navIndex3.tabBarItem = item4
        item4.titlePositionAdjustment = UIOffsetMake(0, -2)
        
        let fiveVC  = LBMineViewController ()
        let navIndex4=basenavagationViewController(rootViewController: fiveVC);
        let item5 : UITabBarItem = UITabBarItem (title: "我的", image: UIImage(named: "我的"), selectedImage: UIImage(named: "我的选中"))
        fiveVC.title="我的"
        navIndex4.tabBarItem = item5
        item5.titlePositionAdjustment = UIOffsetMake(0, -2)
        
        let tabArray = [navIndex,navIndex1,navIndex2,navIndex3,navIndex4]
        
        self.viewControllers = tabArray
        
        self.delegate=self
        
        //选中的颜色
        //self.tabBar.tintColor = UIColor.red
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)], for: UIControlState.normal)
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        self.selectindex = tabBarController.selectedIndex
        
        if tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 3 {
            
        }
        
        if tabBarController.selectedIndex == 1 || tabBarController.selectedIndex == 3{
            
        }
        
    }
    
   
}
