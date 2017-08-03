//
//  LBCustomGifHeader.m
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBCustomGifHeader.h"

@implementation LBCustomGifHeader

+(MJRefreshGifHeader *)customRefreshHeaderBlock:(void (^)())Block{

    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [headerImages addObject:image];
    }
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
        Block();
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    [gifHeader setImages:@[headerImages[0]]forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    
    return gifHeader;
}

+(MJRefreshBackNormalFooter *)customRefreshFooterBlock:(void (^)())Block{

    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       Block();
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    }];
    
    return footer;

}

+(void)endRefresh:(UITableView *)tableview{

    [tableview.mj_header endRefreshing];
    [tableview.mj_footer endRefreshing];

}

@end
