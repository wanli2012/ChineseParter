//
//  CALayer+Layercolor.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "CALayer+Layercolor.h"

@implementation CALayer (Layercolor)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
