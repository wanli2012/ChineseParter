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
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

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
//登录
- (IBAction)login:(id)sender {
    
}


//注册 和 忘记密码
- (IBAction)registerAndForgetPwd:(UIButton *)sender {
    
    GLRegisterController *registerVC = [[GLRegisterController alloc] init];
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    if (sender == self.registerBtn) {//注册
        
        registerVC.type = 1;
        animation.type = @"rippleEffect";
        animation.subtype = kCATransitionFromLeft;
        animation.duration = 1.0;
        
    }else if (sender == self.forgetBtn){//忘记密码
        
        registerVC.type = 2;
        animation.type = @"oglFlip";
        animation.subtype = kCATransitionFromLeft;
        animation.duration = 0.5;
    }
    
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:registerVC animated:NO completion:nil];
}


@end
