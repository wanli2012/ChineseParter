//
//  GLRegisterController.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLRegisterController.h"

@interface GLRegisterController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextF;
@property (weak, nonatomic) IBOutlet UITextField *ensurePwdTextF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation GLRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgView.layer.cornerRadius = 8.f;
    self.getCodeBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.getCodeBtn.layer.borderWidth = 1;
    
    if(self.type == 1){
        [self.submitBtn setTitle:@"注  册" forState:UIControlStateNormal];
    }else if(self.type == 2){
        [self.submitBtn setTitle:@"提  交" forState:UIControlStateNormal];
    }
}
//获取验证码
- (IBAction)getCodeClick:(id)sender {
    
}
//注册或找回密码
- (IBAction)register:(id)sender {
    
    if(self.type == 1){
        NSLog(@"注册");
    }else if(self.type == 2){
        NSLog(@"忘记密码");
    }
    
}
//去登录
- (IBAction)login:(id)sender {
    
//    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
