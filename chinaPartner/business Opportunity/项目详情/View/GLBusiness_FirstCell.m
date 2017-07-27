//
//  GLBusiness_FirstCell.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBusiness_FirstCell.h"

@implementation GLBusiness_FirstCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (IBAction)btnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(switchView:)]) {
        [self.delegate switchView:sender.tag];
    }
    
    if (sender.tag == 20) {//需求
        [UIView animateWithDuration:0.3 animations:^{
            
            self.indicateView.x = 0;
        }];
    }else if(sender.tag == 21){//介绍
        [UIView animateWithDuration:0.3 animations:^{

            self.indicateView.x = kSCREEN_WIDTH / 3;
        }];
    }else if (sender.tag == 22){//资质
        [UIView animateWithDuration:0.3 animations:^{

            self.indicateView.x = kSCREEN_WIDTH / 3 * 2;
        }];
    }
    
}


@end
