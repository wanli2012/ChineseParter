//
//  GLHomeLiveChooseController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/3/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBusiness_ChooseController.h"

@interface GLBusiness_ChooseController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GLBusiness_ChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma UITableViewDelegate UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.dataSource[indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    cell.selectionStyle = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    self.block(cell.textLabel.text,indexPath.row);
    
}

@end
