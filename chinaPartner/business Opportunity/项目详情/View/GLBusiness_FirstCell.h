//
//  GLBusiness_FirstCell.h
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLBusiness_FirstCellDelegate <NSObject>

- (void)switchView:(NSInteger )sender;

@end

@interface GLBusiness_FirstCell : UITableViewCell

@property (nonatomic, weak)id <GLBusiness_FirstCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *needBtn;//需求
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;//介绍
@property (weak, nonatomic) IBOutlet UIButton *abilityBtn;//资质
@property (weak, nonatomic) IBOutlet UIView *indicateView;//指示view

@end
