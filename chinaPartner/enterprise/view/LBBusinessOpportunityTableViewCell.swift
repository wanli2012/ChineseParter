//
//  LBBusinessOpportunityTableViewCell.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBBusinessOpportunityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moreBt: UIButton!
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    
    var _dataArr:NSArray?
    var dataArr:NSArray?{
        get{
            //返回成员变量
            return _dataArr;
        }
        set{
            //使用 _成员变量 记录值
            _dataArr = newValue;
             for i in _dataArr!.enumerated() {
               let view:UIView = self.viewWithTag(10 + 4*i.offset)!
                view.isHidden = false
                let imag:UIImageView = view.viewWithTag(11 + 4*i.offset) as! UIImageView
                let label:UILabel = view.viewWithTag(12 + 4*i.offset) as! UILabel
                let label2:UILabel = view.viewWithTag(13 + 4*i.offset) as! UILabel
                imag.sd_setImage(with: URL(string: (_dataArr![i.offset] as! Dictionary<String, Any>)["picture"]! as! String)!, placeholderImage: UIImage(named: ""))
                label.text = (_dataArr![i.offset] as! Dictionary<String, Any>)["title"]! as? String
                label2.text = "¥" + ((_dataArr![i.offset] as! Dictionary<String, Any>)["money"]! as? String)!
            }
        }
    
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        moreBt.horizontalCenterTitleAndImageRight(5);
        self.viewOne.layer.borderWidth = 0.8
        self.viewOne.layer.borderColor = defineRGB(r: 229, g: 229, b: 229, a: 1).cgColor
        self.viewTwo.layer.borderWidth = 0.8
        self.viewTwo.layer.borderColor = defineRGB(r: 229, g: 229, b: 229, a: 1).cgColor
        self.viewThree.layer.borderWidth = 0.8
        self.viewThree.layer.borderColor = defineRGB(r: 229, g: 229, b: 229, a: 1).cgColor
        
        
        
    }
    //查看更多
    @IBAction func clickMorebt(_ sender: Any) {
        
        
    }
    
    
    
   
}
