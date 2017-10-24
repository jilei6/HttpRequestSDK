//
//  HYModel.m
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "RequestHYModel.h"



@implementation RequestHYModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _args = [NSMutableDictionary dictionary];
        _showWaiting=YES;//显示菊花转
        _isReturnModel=YES; //返回实体类
        _code=@"code";
        _status=@"status";
        _server_time=@"server_time";
        _requesturl=@"";
        _codeNumber=1000;
    }
    return self;
}

- (NSString*)getUrl
{
    return @"";
}

- (NSMutableDictionary*)getArgs
{
    return _args;
}

- (void)parse:(id)obj
{
    
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic =obj;
        NSLog(@"dic--%@",dic);
        self.msg=[self safeObjectForKey:self.status withData:dic];
        
        self.msgCode = [self safeIntForKey:self.code withData:dic];
        NSString *servertime=[self safeObjectForKey:self.server_time withData:dic];
        self.servertime=[servertime description];
       
      
    }
}


-(NSString*)safeObjectForKey:(NSString*)key withData:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic=data;
        if ([dic.allKeys containsObject:key])
        {
            return  [[dic objectForKey:key] description];
        }
    }
    
        return @"";
    
}

-(int )safeIntForKey:(NSString*)key withData:(id)data
{
    NSString *numberStr=[self safeObjectForKey:key withData:data] ;
    
    if ([numberStr length]>0)
    {
        return [numberStr intValue];
    }else
        return 0;
    ;
}
- (BOOL)notEmpty:(NSString*)str
{
    if ([str isEqualToString:@""])
        return NO;
    if (str.length != 0) {
        return [str stringByReplacingOccurrencesOfString:@" " withString:@""].length != 0;
    }
    return str.length != 0;
}

@end
