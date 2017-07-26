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
