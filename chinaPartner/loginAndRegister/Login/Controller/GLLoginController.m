//
//  GLLoginController.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLLoginController.h"
#import "GLRegisterController.h"

@interface GLLoginController ()<UITextFieldDelegate>

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
    
    [self.view endEditing:YES];
    if (self.phoneTextF.text.length <=0 ) {
        [MBProgressHUD showWarnMessage:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTextF.text]) {
            [MBProgressHUD showErrorMessage:@"手机号格式不对"];
            return;
        }
    }
    
    if (self.passWordTextF.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入密码"];
        return;
    }
    
    NSString *encryptsecret = [RSAEncryptor encryptString:self.passWordTextF.text publicKey:public_RSA];
     [MBProgressHUD showActivityMessageInWindow:nil];
    [NetworkManager requestPOSTWithURLStr:@"User/PartnerLogin" paramDic:@{@"userphone":self.phoneTextF.text,@"password":encryptsecret} finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue]==1) {
            [UserModel defaultUser].address = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"address"]];
            [UserModel defaultUser].idcard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"idcard"]];
            [UserModel defaultUser].name = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            [UserModel defaultUser].phone = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"phone"]];
            [UserModel defaultUser].pic = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"pic"]];
            [UserModel defaultUser].token = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]];
            [UserModel defaultUser].truename = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"truename"]];
            [UserModel defaultUser].uid = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"uid"]];
            [UserModel defaultUser].version = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"version"]];
            [UserModel defaultUser].vsnAddress = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"vsnAddress"]];
            [UserModel defaultUser].vsnUpdateTime = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"vsnUpdateTime"]];
            [usermodelachivar achive];
            
              [MBProgressHUD showErrorMessage:responseObject[@"message"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            });
            
        }else{
             [MBProgressHUD showErrorMessage:responseObject[@"message"]];
        }
        
    } enError:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:@"网络请求失败"];
        
    }];

    
}
//退出登录
- (IBAction)ExitEvent:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.phoneTextF && [string isEqualToString:@"\n"]) {
        [self.passWordTextF becomeFirstResponder];
        return NO;
        
    }else if (textField == self.passWordTextF && [string isEqualToString:@"\n"]){
        
        [self.view endEditing:YES];
        return NO;
    }

    if (textField == self.phoneTextF ) {
        
        for(int i=0; i< [string length];i++){
            
            int a = [string characterAtIndex:i];
            
            if( a >= 0x4e00 && a <= 0x9fff)
                
                return NO;
        }
    }
    
    return YES;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}

@end
