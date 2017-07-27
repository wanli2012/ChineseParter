//
//  GLBusiness_DetailCell.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBusiness_DetailCell.h"

@interface GLBusiness_DetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;//图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名称
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;//描述
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格

@end

@implementation GLBusiness_DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //可以在这里适配字体大小
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.font = [UIFont systemFontOfSize:13];
    self.distanceLabel.font = [UIFont systemFontOfSize:11];
    self.dateLabel.font = [UIFont systemFontOfSize:11];
}



@end
