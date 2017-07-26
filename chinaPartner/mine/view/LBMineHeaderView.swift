//
//  LBMineHeaderView.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBMineHeaderView: UIView {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var haadImage: UIImageView!
    @IBOutlet weak var baseView: UIView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.baseView.layer.cornerRadius = 5
        self.baseView.clipsToBounds = true
        
        self.haadImage.layer.cornerRadius = 40
        self.haadImage.clipsToBounds = true
        
//        let mask:UIBezierPath = UIBezierPath.init(roundedRect: self.baseView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii:CGSize(width: 5, height: 5))
//        let shape:CAShapeLayer = CAShapeLayer()
//             shape.fillColor = UIColor.red.cgColor
//            shape.path = mask.cgPath
//             shape.frame = self.baseView.bounds
//             baseView.layer.shadowColor = UIColor.orange.cgColor
//             baseView.layer.shadowOpacity = 0.5
//            baseView.layer.shadowOffset = CGSize(width: 5, height: 5)
//            baseView.layer.shadowRadius = 5
//            baseView.layer.addSublayer(shape)
        
   //         baseView.layer.mask = shape
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
    }

}
