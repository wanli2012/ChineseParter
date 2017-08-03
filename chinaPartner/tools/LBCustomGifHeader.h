//
//  LBCustomGifHeader.h
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface LBCustomGifHeader : MJRefreshGifHeader
{
    NSMutableArray *_imageArr;
}
+(MJRefreshGifHeader*)customRefreshHeaderBlock:(void(^)())Block;

+(void)endRefresh:(UITableView*)tableview;

+(MJRefreshBackNormalFooter*)customRefreshFooterBlock:(void(^)())Block;

@end
