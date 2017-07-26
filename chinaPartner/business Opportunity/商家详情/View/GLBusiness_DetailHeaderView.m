//
//  GLBusiness_DetailHeaderView.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBusiness_DetailHeaderView.h"

@interface GLBusiness_DetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;

@end

@implementation GLBusiness_DetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contactBtn.layer.borderWidth = 1;
    self.contactBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
}

@end
