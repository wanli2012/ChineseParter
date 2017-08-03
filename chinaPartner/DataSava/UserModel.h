//
//  UserModel.h
//  813DeepBreathing
//
//  Created by rimi on 15/8/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>
@property (nonatomic, assign) BOOL needAutoLogin;

@property (nonatomic, assign)BOOL   loginstatus;//登陆状态

@property (nonatomic, copy)NSString  *address;//地址
@property (nonatomic, copy)NSString  *idcard;//身份证
@property (nonatomic, copy)NSString  *name;//用户ID
@property (nonatomic, copy)NSString  *phone;//用户电话
@property (nonatomic, copy)NSString  *pic;//用户头像
@property (nonatomic, copy)NSString  *token;//用户token
@property (nonatomic, copy)NSString  *truename;//用户真实姓名
@property (nonatomic, copy)NSString  *uid;//用户uid
@property (nonatomic, copy)NSString  *version;//版本
@property (nonatomic, copy)NSString  *vsnAddress;
@property (nonatomic, copy)NSString  *vsnUpdateTime;


+(UserModel*)defaultUser;

@end
