//
//  GLBusiness_HomeController.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBusiness_PreferredController.h"
#import "GLBusiness_DetailCell.h"
#import "GLBusiness_ChooseController.h"

@interface GLBusiness_PreferredController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *classifyBtn;//分类按钮
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;//距离按钮
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;//排序按钮
@property (weak, nonatomic) IBOutlet UIView *topView;


@property (nonatomic, strong)UIView  *maskV;//遮罩
@property (nonatomic, strong)GLBusiness_ChooseController *chooseVC;//选择控制器
@property (nonatomic, strong)GLBusiness_ChooseController *chooseVC2;//选择控制器

@end

@implementation GLBusiness_PreferredController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = @"全部企业";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLBusiness_DetailCell" bundle:nil] forCellReuseIdentifier:@"GLBusiness_DetailCell"];
    
    [self.classifyBtn setTitle:@"分类" forState:UIControlStateNormal];
    [self.classifyBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
    
    [self.distanceBtn setTitle:@"距离" forState:UIControlStateNormal];
    [self.distanceBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];

    [self.sortBtn setTitle:@"排序" forState:UIControlStateNormal];
    [self.sortBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];

    [self refreshTheTopBtn];
    
}

//刷新图文位置  (顶部按钮)
- (void)refreshTheTopBtn {
    
    [self setTopButton:self.classifyBtn];
    [self setTopButton:self.distanceBtn];
    [self setTopButton:self.sortBtn];
}

- (void)setTopButton:(UIButton *)btn {
    
    CGFloat imageWidth = btn.imageView.bounds.size.width;
    CGFloat labelWidth = btn.titleLabel.bounds.size.width;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.topView convertRect:self.topView.bounds toView:window];

    //    _chooseVC.view.frame = CGRectZero;
    
    self.chooseVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, 0);
    self.chooseVC.view.backgroundColor = [UIColor whiteColor];
//    self.chooseVC.view.layer.cornerRadius = 4;
//    self.chooseVC.view.layer.masksToBounds = YES;
    
    
    
   self.maskV.frame = CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, SCREEN_HEIGHT);

    self.maskV.alpha = 0;
    
    [self.view addSubview:self.maskV];
    [self.maskV addSubview:self.chooseVC.view];
    
}

//头部三个按钮的点击事件
- (IBAction)choose:(UIButton *)sender {
    
    if (_maskV.alpha == 0) {
        sender.selected = NO;
    }
    
    _maskV.alpha = 1;

    
    [self.distanceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.classifyBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.sortBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.distanceBtn.selected = NO;
    self.classifyBtn.selected = NO;
    self.sortBtn.selected = NO;
    sender.selected = YES;
    
    self.distanceBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.classifyBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.sortBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    
     __weak __typeof(self)weakSelf = self;
    
    switch (sender.tag) {
        case 10://分类
        {
            _chooseVC.dataSource = @[@"全部",@"美食",@"傻逼",@"吕兵那个傻逼",@"全部",@"美食",@"傻逼",@"吕兵那个傻逼",@"全部",@"美食",@"傻逼",@"吕兵那个傻逼"];
            _chooseVC.view.width = kSCREEN_WIDTH / 2;
            _chooseVC.block = ^(NSString *value,NSInteger index){

                //二级选项
                weakSelf.chooseVC2.view.frame = CGRectMake(kSCREEN_WIDTH / 2 ,0, SCREEN_WIDTH/2, 0);
                [weakSelf.maskV addSubview:weakSelf.chooseVC2.view];

                NSArray *arr = @[@"哈哈0",@"哈哈1",@"哈哈2",@"哈哈3"];
                NSArray *arr2 = @[@"dd",@"dds",@"lll",@"ppp"];
                
                if (index % 2 == 1) {
                    
                    weakSelf.chooseVC2.dataSource = arr;
                }else{
                    weakSelf.chooseVC2.dataSource = arr2;

                }
                weakSelf.chooseVC2.block = ^(NSString *value,NSInteger index){
                    [weakSelf.classifyBtn setTitle:value forState:UIControlStateNormal];
                    [weakSelf refreshTheTopBtn];
                    
                    [weakSelf dismiss];
                };
                
                [UIView animateWithDuration:0.3 animations:^{
                    if (weakSelf.chooseVC2.dataSource.count < 8) {
                        weakSelf.chooseVC2.view.height = _chooseVC2.dataSource.count * 44;
                    }else{
                        weakSelf.chooseVC2.view.height = SCREEN_HEIGHT * 0.5;
                    }
                    
                }];
                
                [weakSelf.chooseVC2.tableView reloadData];
            };

        }
            break;
        case 11://距离
        {
            _chooseVC.dataSource = @[@"全城",@"10km",@"3km",@"1km"];
            _chooseVC.view.width = kSCREEN_WIDTH;
            _chooseVC2.view.height = 0;
            _chooseVC.block = ^(NSString *value,NSInteger index){
                [weakSelf.distanceBtn setTitle:value forState:UIControlStateNormal];
                [weakSelf refreshTheTopBtn];
           
                [weakSelf dismiss];
            };

        }
            break;
        case 12://排序
        {
            _chooseVC.dataSource = @[@"智能排序",@"好评优先",@"离我最近"];
            _chooseVC.view.width = kSCREEN_WIDTH;
            _chooseVC2.view.height = 0;
            _chooseVC.block = ^(NSString *value,NSInteger index){
                [weakSelf.sortBtn setTitle:value forState:UIControlStateNormal];
                [weakSelf refreshTheTopBtn];
                [weakSelf dismiss];
            };

        }
            break;
            
        default:
            break;
    }
    
    if (sender.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            if (_chooseVC.dataSource.count < 8) {
                _chooseVC.view.height = _chooseVC.dataSource.count * 44;
            }else{
                _chooseVC.view.height = SCREEN_HEIGHT * 0.5;
            }
            
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            
            _chooseVC.view.height = 0;
            
        } completion:^(BOOL finished) {
            
            _maskV.alpha = 0;
        }];
        
    }
    
    [_chooseVC.tableView reloadData];

    
}
//遮罩消失
- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.chooseVC.view.height = 0;
        self.chooseVC2.view.height = 0;
    } completion:^(BOOL finished) {
        _maskV.alpha = 0;
        
    }];
    [self.distanceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.classifyBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.sortBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    self.distanceBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.classifyBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.sortBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    
}

//解决手势与点击事件冲突 tableView不响应手势点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (touch.view.tag != 99){
        
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLBusiness_DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLBusiness_DetailCell"];
    cell.distanceLabel.hidden = NO;
    cell.dateLabel.hidden = NO;
    cell.selectionStyle = 0;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


#pragma mark Lazy

- (UIView  *)maskV{
    if (!_maskV) {
        _maskV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _maskV.backgroundColor = YYSRGBColor(0, 0, 0, 0.2);
        _maskV.tag = 99;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [_maskV addGestureRecognizer:tap];
    }
    return _maskV;
}
- (GLBusiness_ChooseController *)chooseVC{
    if (!_chooseVC) {
        _chooseVC = [[GLBusiness_ChooseController alloc] init];
        
    }
    return _chooseVC;
}
- (GLBusiness_ChooseController *)chooseVC2{
    if (!_chooseVC2) {
        _chooseVC2 = [[GLBusiness_ChooseController alloc] init];
        
    }
    return _chooseVC2;
}
@end
