//
//  LBAddrecomdManChooseAreaViewController.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBAddrecomdManChooseAreaViewController : UIViewController

@property (nonatomic , copy)void(^returnreslut)(NSString* selectIndex);
@property (nonatomic, strong)NSString *titlestr;
@property (nonatomic, strong)NSDictionary *provinceArr;
@property (nonatomic, strong)NSArray *cityArr;
@property (nonatomic, strong)NSMutableArray *countryArr;
@end
