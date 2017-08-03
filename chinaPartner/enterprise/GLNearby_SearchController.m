//
//  GLNearby_SearchController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/5/22.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLNearby_SearchController.h"

@interface GLNearby_SearchController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    LoadWaitView *_loadV;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

//@property (nonatomic,strong)NSMutableArray *models;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)NodataView *nodataV;

@property (nonatomic, strong)NSMutableArray *nearModels;

@end

static NSString *ID = @"LBProjectExchangeTableViewCell";
@implementation GLNearby_SearchController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.searchView.layer.cornerRadius = 5.f;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [LBCustomGifHeader customRefreshHeaderBlock:^{
         [weakSelf updateData:YES];
    }];
    self.tableView.mj_footer = [LBCustomGifHeader customRefreshFooterBlock:^{
         [weakSelf updateData:NO];
    }];
//    [self updateData:YES];
    
}

- (void)updateData:(BOOL)status {
    if (status) {
        
        self.page = 1;
        [self.nearModels removeAllObjects];
        
    }else{
        _page ++;
        
    }
    
    if (self.searchTF.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入搜索关键字"];
        [LBCustomGifHeader endRefresh:self.tableView];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"page"] = [NSString stringWithFormat:@"%zd",_page];
    dict[@"content"] = self.searchTF.text;
    [MBProgressHUD showActivityMessageInView:nil];
    [NetworkManager requestPOSTWithURLStr:@"Shopone/search_index" paramDic:dict finish:^(id responseObject) {
        [LBCustomGifHeader endRefresh:self.tableView];
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue]==1) {
            [self.nearModels addObjectsFromArray:responseObject[@"data"]];
        }else{
            [MBProgressHUD showErrorMessage:responseObject[@"message"]];

        }
        [self.tableView reloadData];
    } enError:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [LBCustomGifHeader endRefresh:self.tableView];
        [MBProgressHUD showErrorMessage:@"请求失败"];
        [self.tableView reloadData];
    }];
    
}

-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114-49);
    }
    return _nodataV;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.searchTF becomeFirstResponder];
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.searchTF resignFirstResponder];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

- (IBAction)cancel:(id)sender {

    [self.navigationController popViewControllerAnimated:NO];
}

#pragma UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    [self updateData:YES];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self updateData:YES];
    return YES;
}
#pragma UITableviewDelegate UITableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.nearModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBProjectExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = 0;
    cell.dataDic = self.nearModels[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma 懒加载
- (NSMutableArray *)nearModels{
    if (!_nearModels) {
        _nearModels = [NSMutableArray array];
    }
    return _nearModels;
}
@end
