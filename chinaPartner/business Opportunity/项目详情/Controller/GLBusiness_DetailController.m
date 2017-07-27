//
//  GLBusiness_DetailController.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBusiness_DetailController.h"
#import "GLBusiness_DetailCell.h"
#import "GLBusiness_FirstCell.h"

//测试 后期请删除
#import "GLBusiness_PreferredController.h"
#import "GLLoginController.h"


@interface GLBusiness_DetailController ()<UITableViewDelegate,UITableViewDataSource,GLBusiness_FirstCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *navView;//自定义导航栏
@property (weak, nonatomic) IBOutlet UIButton *backBtn;//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;//收藏按钮
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//企业名称
@property (weak, nonatomic) IBOutlet UILabel *classifyLabel;//行业类型
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;//联系人名字
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;//联系电话
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;//联系企业按钮

@end

@implementation GLBusiness_DetailController

CGFloat kPIC_HEIGHT = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contactBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.contactBtn.layer.borderWidth = 1.f;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLBusiness_DetailCell" bundle:nil] forCellReuseIdentifier:@"GLBusiness_DetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLBusiness_FirstCell" bundle:nil] forCellReuseIdentifier:@"GLBusiness_FirstCell"];
    self.tableView.tableHeaderView.autoresizingMask = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kPIC_HEIGHT, 0, 0, 0);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -kPIC_HEIGHT, kSCREEN_WIDTH + 1, kPIC_HEIGHT)];
    imageView.layer.masksToBounds = YES;
    
    imageView.image = [UIImage imageNamed:@"测试图片"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = 101;
    
    [self.tableView addSubview:imageView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
}

//返回键点击事件
- (IBAction)back:(id)sender {
    
}

//收藏
- (IBAction)collectClick:(id)sender {
    
//    self.collectBtn.selected = !self.collectBtn.selected;
    self.hidesBottomBarWhenPushed = YES;
    GLLoginController *loginVC = [[GLLoginController alloc] init];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

//联系企业
- (IBAction)contactCompany:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLBusiness_PreferredController * preferVC = [[GLBusiness_PreferredController alloc] init];
    [self.navigationController pushViewController:preferVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark GLBusiness_FirstCellDelegate

- (void)switchView:(NSInteger)sender{
    
    switch (sender) {
        case 20:
        {
            NSLog(@"需求");
        }
            break;
        case 21:
        {
            NSLog(@"介绍");
        }
            break;
        case 22:
        {
            NSLog(@"资质");
        }
            break;
            
        default:
            break;
    }
}



#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        GLBusiness_FirstCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GLBusiness_FirstCell"];
        cell.selectionStyle = 0;
        cell.delegate = self;
        return cell;
        
    }else{
        
        GLBusiness_DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLBusiness_DetailCell"];
        cell.selectionStyle = 0;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 40;
    }else{
        
        return 110;
    }
}
//滚动代理事件 图片放大 以及 导航栏颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //图片放大
    CGPoint point = scrollView.contentOffset;
    if (point.y < - kPIC_HEIGHT) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }
    
    //导航栏颜色渐变
    UIColor *color=[UIColor whiteColor];
    CGFloat offset = scrollView.contentOffset.y + 20;
    if (offset < 0) {
        self.navView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha = 1-((64-offset)/64);
        self.navView.backgroundColor= [color colorWithAlphaComponent:alpha];
    }
    
}

@end
