//
//  LoginModel.h
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

//#import "HYModel.h"
#import <RequestSDK/RequestTool.h>
#import <RequestSDK/RequestHYModel.h>
@interface LoginModel : RequestHYModel
@property (nonatomic ,strong) NSString *account;
@property (nonatomic ,strong) NSString *password;
@property (nonatomic ,strong) NSString *appId;
@property (nonatomic ,strong) NSString *secret;
@property (nonatomic ,strong) NSString *time;
@property (nonatomic ,strong) NSString *sign;
+(void)Login;
@end
