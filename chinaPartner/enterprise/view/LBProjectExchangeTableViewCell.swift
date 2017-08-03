//
//  LBProjectExchangeTableViewCell.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBProjectExchangeTableViewCell: UITableViewCell {
  
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var _dataDic:NSDictionary?
    var dataDic:NSDictionary?{
        get{
            //返回成员变量
            return _dataDic;
        }
        set{
            //使用 _成员变量 记录值
            _dataDic = newValue
            self.img.sd_setImage(with: URL(string:_dataDic!["picture"] as! String), placeholderImage: UIImage(named:""))
           self.name.text = _dataDic!["title"] as? String
            self.info.text = _dataDic!["project_brief"] as? String
            self.money.text = "¥" + (_dataDic!["money"] as? String)!
            
            if _dataDic!["limit"] == nil {
                self.distance.isHidden = true
            }else{
                 self.distance.isHidden = false
                if (_dataDic!["limit"] as! Float) < 1000{
                    self.distance.text = String(format:"%.0f" + "m",(_dataDic!["limit"] as! Float))
                }else{
                    self.distance.text = String(format:"%.1f" + "km",(_dataDic!["limit"] as! Float)/1000)
                }
               
            }
            
            let time:String = formattime.formateTime(_dataDic!["addtime"] as? String)
            self.time.text = time
        
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
