//
//  GLRegisterController.m
//  chinaPartner
//
//  Created by 龚磊 on 2017/7/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLRegisterController.h"

@interface GLRegisterController ()<UITextFieldDelegate>

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
    
    if (self.phoneTextF.text.length <=0 ) {
        [MBProgressHUD showWarnMessage:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTextF.text]) {
            [MBProgressHUD showErrorMessage:@"手机号格式不对"];
            return;
        }
    }
    
    [predicateModel startTime:self.getCodeBtn];//获取倒计时
    [NetworkManager requestPOSTWithURLStr:@"User/PartneVerificationCode" paramDic:@{@"phone":self.phoneTextF.text} finish:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==1) {
            
        }else{
            
        }
    } enError:^(NSError *error) {
        
    }];
    
}
//注册或找回密码
- (IBAction)register:(id)sender {
    
    if (self.phoneTextF.text.length <=0 ) {
        [MBProgressHUD showWarnMessage:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTextF.text]) {
            [MBProgressHUD showErrorMessage:@"手机号格式不对"];
            return;
        }
    }
    
    if (self.codeTextF.text.length <= 0) {
        [MBProgressHUD showWarnMessage:@"请输入验证码"];
        return;
    }
    
    if (self.passWordTextF.text.length <= 0) {
        [MBProgressHUD showWarnMessage:@"密码不能为空"];
        return;
    }
    if (self.passWordTextF.text.length < 6 || self.passWordTextF.text.length > 16) {
        [MBProgressHUD showWarnMessage:@"请输入6-16位密码"];
        return;
    }
    
    if (![predicateModel checkPassWord:self.passWordTextF.text]) {
        
        [MBProgressHUD showErrorMessage:@"密请输入正确的密码格式"];
        return;
    }
    
    if (self.ensurePwdTextF.text.length <= 0) {
        [MBProgressHUD showWarnMessage:@"请输入确认密码"];
        return;
    }
    
    if (![self.passWordTextF.text isEqualToString:self.ensurePwdTextF.text]) {
        [MBProgressHUD showErrorMessage:@"两次输入的密码不一致"];
        return;
    }
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    [NetworkManager requestPOSTWithURLStr:@"User/chPartneVerification" paramDic:@{@"phone":self.phoneTextF.text,@"verification":self.codeTextF.text} finish:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==1) {
            if(self.type == 1){
                
                [self registerAccount];//注册
                
            }else if(self.type == 2){
                
                [self ModifyPassword];//修改密码
                
            }
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:responseObject[@"message"]];
        }
    } enError:^(NSError *error) {
         [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:@"网络请求失败"];
    }];
    
}

-(void)ModifyPassword{
    
    //替换字符串中的空格
    self.passWordTextF.text = [self.passWordTextF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.ensurePwdTextF.text = [self.ensurePwdTextF.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *encryptsecret = [RSAEncryptor encryptString:self.passWordTextF.text publicKey:public_RSA];
    NSString *encryptsecretSure = [RSAEncryptor encryptString:self.ensurePwdTextF.text publicKey:public_RSA];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"type"] =  @"2";
    dic[@"phone"] =  self.phoneTextF.text;
    dic[@"password"] =  encryptsecret;
    dic[@"ConfirmPwd"] =  encryptsecretSure;
    dic[@"verification"] =  self.codeTextF.text;
//    dic[@"uid"] = @"639";
//    dic[@"token"] = @"T96D4K";
    
    [NetworkManager requestPOSTWithURLStr:@"User/PartnerCryptogram" paramDic:dic finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue]==1) {
            [MBProgressHUD showErrorMessage:responseObject[@"message"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self login:nil];
            });
        }else{
            [MBProgressHUD showErrorMessage:responseObject[@"message"]];
        }
    } enError:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:@"网络请求失败"];
        
    }];
    
    
}



-(void)registerAccount{

    NSString *encryptsecret = [RSAEncryptor encryptString:self.passWordTextF.text publicKey:public_RSA];
    [NetworkManager requestPOSTWithURLStr:@"User/PartnerRegister" paramDic:@{@"userphone":self.phoneTextF.text ,@"password":encryptsecret,@"verification":self.codeTextF.text} finish:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue]==1) {
            [MBProgressHUD showErrorMessage:responseObject[@"message"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login:nil];
            });
        }else{
            [MBProgressHUD showErrorMessage:responseObject[@"message"]];
        }
    } enError:^(NSError *error) {
        [MBProgressHUD hideHUD];
         [MBProgressHUD showErrorMessage:@"网络请求失败"];
        
    }];

}

//去登录
- (IBAction)login:(id)sender {
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    if (self.type == 1) {//注册
        
        animation.type = @"rippleEffect";
        animation.subtype = kCATransitionFromLeft;
        animation.duration = 1.0;
        
    }else if(self.type == 2){//忘记密码
        
        animation.type = @"oglFlip";
        animation.subtype = kCATransitionFromRight;
        animation.duration = 0.5;
    }
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.passWordTextF && [string isEqualToString:@"\n"]) {
        [self.ensurePwdTextF becomeFirstResponder];
        return NO;
        
    }else if (textField == self.ensurePwdTextF && [string isEqualToString:@"\n"]){
        
        [self.view endEditing:YES];
        return NO;
    }
    
        
    return YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

@end
