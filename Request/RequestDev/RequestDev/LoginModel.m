//
//  LoginModel.m
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "LoginModel.h"
#import <CommonCrypto/CommonDigest.h>
@implementation LoginModel

-(NSString *)getUrl
{
    return @"http://xxx.com/api/test/date_list";
}

-(void)parse:(id)obj
{
    [super parse:obj];
    
    if (obj && [obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dic =obj;
        NSLog(@"dic-11-%@",dic);

        
        
    }
}
- (void)setPassword:(NSString *)password
{
    [self.args setObject:password forKey:@"password"];
}

- (void)setAccount:(NSString *)account
{
    [self.args setObject:account forKey:@"account"];
    
}
- (void)setAppId:(NSString *)appId
{
    [self.args setObject:appId forKey:@"appId"];
    
}

- (void)setSecret:(NSString *)secret
{
    [self.args setObject:secret forKey:@"secret"];
    
}
- (void)setTime:(NSString *)time
{
    [self.args setObject:time forKey:@"time"];
    
}
- (void)setSign:(NSString *)sign
{
    [self.args setObject:sign forKey:@"sign"];
    
}

+(void)Login
{
    LoginModel * login=[[LoginModel alloc]init];
    login.showWaiting=NO;
    login.requesturl = @"http://xxx.com/api/test/date_list";
//    login.account = @"1851624xxxx";
//    login.password = @"123456";
//    login.appId = @"3";
//    //login.secret = @"ddddddd";
//    login.time = @"1497246449";
//    
//    
//    login.status = @"msg";
//    login.code = @"code";
//    login.codeNumber = 0;
//    NSMutableDictionary* dicT = [NSMutableDictionary dictionaryWithDictionary:[login getArgs]];
//    NSString* data = [self converseToJson:dicT];
//    NSString* sign = [self getMd5_32Bit_String:data];
//    login.sign = sign;
    
    
    NSMutableDictionary * parms=[NSMutableDictionary dictionaryWithDictionary:[login getArgs]];
    [parms addEntriesFromDictionary:@{@"idfa":@"xxxxxxx",@"version":@"1.0",@"platform":@"ios",@"uid":[NSNumber numberWithInt:1000]}];
    [login.args addEntriesFromDictionary:parms];
    
    [RequestTool requestPost:login whenSuccess:^(NSURLSessionDataTask *task, RequestHYModel *m, id res)
    {
        NSLog(@"---000-----%@",res);
        NSLog(@"%@",login.msg);
        
    } whenFailure:^(NSError *err, RequestHYModel *m, id res) 
    {
        
        NSLog(@"--111----%@",err);
    }];
}

//32位MD5加密方式
+ (NSString*)getMd5_32Bit_String:(NSString*)srcString
{
    const char* cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
+ (NSString*)converseToJson:(NSDictionary*)dic
{
    
    NSString*str_dic = nil;
    NSArray *array_key =[dic allKeys];
    for (int m = 0; m<array_key.count; m++)
    {
        NSString *key_str =array_key[m];
        NSString *str = [NSString stringWithFormat:@"%@=%@",key_str,[[dic objectForKey:key_str] description]];
        if (m==0)
        {
            str_dic = str;
        }else
        {
            str_dic = [NSString stringWithFormat:@"%@&%@",str_dic,str];
        }
        
    }
    
    return str_dic;
    
}


@end
