//
//  LBEnterpriseHeaderView.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBEnterpriseHeaderView: UIView {
    
    @IBOutlet weak var search: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var basesearchV: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.search.layer.borderWidth = 1
        self.search.layer.borderColor = UIColor.darkText.cgColor
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect) {
     
        调用初始化方法()
        scrollView.contentSize = CGSize(width: ScreenW * 2, height: self.scrollView.frame.size.height)
        pageView.numberOfPages = 2;
        pageView.currentPage = 0;
        pageView?.hidesForSinglePage = true
        //设置显示颜色
        pageView?.currentPageIndicatorTintColor = UIColor.red
        //设置页背景指示颜色
        pageView?.pageIndicatorTintColor = UIColor.groupTableViewBackground
        scrollView.delegate = self;
        //添加事件
        pageView?.addTarget(self, action: #selector(LBEnterpriseHeaderView.pageControlChanged), for: UIControlEvents.valueChanged)
    }
    
    
    func 调用初始化方法() -> Void {
        /** 
         * index 获取索引  i  获取元素
         */
        let itemW:CGFloat = 50.0 * autoSizeScaleX //每个分类的宽度
        let itemH:CGFloat = 80.0  //每个分类的高度
        let num:CGFloat = 4 //每行展示多少个分类
        let padding_x:CGFloat = 20 //第一个距离边界多少px
        let item_dis:CGFloat = CGFloat(ScreenW - padding_x * 2 - 4 * itemW)
        let item_one:CGFloat = item_dis / (num - 1)  //分类之间的距离
        
        for i in self.arr.enumerated() {

            //print(i.offset) 获取索引
            //print(i.element) 获取元素
            
            let   classfiyV:LBServiceClassify =  (Bundle.main.loadNibNamed("LBServiceClassify", owner: nil, options: nil)?.first as? LBServiceClassify)!
            classfiyV.imageV.image = UIImage(named:self.imagarr[i.offset] as! String)
            classfiyV.titleLb.text = self.arr[i.offset] as? String
            classfiyV.titleLb.font = UIFont.systemFont(ofSize: 12 * autoSizeScaleX)
            classfiyV.backgroundColor = UIColor.clear
            let a = i.offset / Int(num) //强制转化成int类型
            let b = i.offset % Int(num) //强制转化成int类型
            let c = Int(ScreenW) * (i.offset / 8) //分页
            
            classfiyV.frame = CGRect(x:  CGFloat(c) + 20 + (itemW + item_one) * CGFloat(b), y: 20 + (10 + itemH) * CGFloat(a % 2), width: itemW , height: itemH)

           self.scrollView.addSubview(classfiyV)
           
        }
        
    }
    
    
    //pageControl的触发事件
    func pageControlChanged(pageControl:UIPageControl) {
        let page = pageControl.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(page) * ScreenW, y: 0), animated: true)
        //        var frame = tmpSV!.frame
        //        frame.origin.x = width * CGFloat(page)
        //        tmpSV!.scrollRectToVisible(frame, animated: true)
    }
    
    lazy var arr: Array <Any> = {
               var temporaryPlayers = Array<Any>()
                     temporaryPlayers = ["餐饮加盟","建材加盟","美容保健","网络服务","数码电子","生活服务","家具环保","服务加盟","餐饮加盟","建材加盟","美容保健","网络服务","数码电子","生活服务","家具环保","服务加盟"]
              return temporaryPlayers
    }()
    
    lazy var imagarr: Array <Any> = {
        var temporaryPlayers = Array<Any>()
        temporaryPlayers = ["餐饮","建材加盟","美容","网络","电子","生活","家具","服务加盟","餐饮","建材加盟","美容","网络","电子","生活","家具","服务加盟"]
        return temporaryPlayers
    }()
    
}

extension LBEnterpriseHeaderView:UIScrollViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x / ScreenW
        pageView!.currentPage = Int(offset)
        
    }

}






