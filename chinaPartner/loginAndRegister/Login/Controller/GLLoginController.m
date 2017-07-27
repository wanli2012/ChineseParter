//
//  GLLoginController.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLLoginController.h"
#import "GLRegisterController.h"

@interface GLLoginController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextF;

@end

@implementation GLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgView.layer.cornerRadius = 8.f;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}
//忘记密码
- (IBAction)forgetPassWord:(id)sender {
    GLRegisterController *registerVC = [[GLRegisterController alloc] init];
    registerVC.type = 2;
    [registerVC setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:registerVC animated:YES completion:nil];
}
//登录
- (IBAction)login:(id)sender {
}
//注册
- (IBAction)register:(id)sender {
    
    GLRegisterController *registerVC = [[GLRegisterController alloc] init];
    registerVC.type = 1;
    [registerVC setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:registerVC animated:YES completion:nil];
}


@end
