//
//  LBCheckMoreTableViewCell.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBCheckMoreTableViewCell: UITableViewCell {

    @IBOutlet weak var moreBt: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        moreBt.horizontalCenterTitleAndImageRight(5);
    }


    
}
