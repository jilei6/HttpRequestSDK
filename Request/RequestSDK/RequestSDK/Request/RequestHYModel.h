//
//  HYModel.h
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import <Foundation/Foundation.h>
//@protocol NetObj <NSObject>
//
//@required
//- (NSString*)getUrl;
//- (NSMutableDictionary *)getArgs;
//- (void)parse:(NSObject*)obj;
//
//@end
//

@interface RequestHYModel : NSObject
//业务层定义的code值，因为不同业务定义的code是不一样的
@property (nonatomic, assign) int       codeNumber;
//从接口解析出来的code值 和定义的codeNumber进行判断
@property (nonatomic, assign) int       msgCode;
//从接口解析出来的msg值
@property (nonatomic, strong) NSString  *msg;
//从接口解析出来的servertime值
@property (nonatomic, strong) NSString  *servertime;
//业务层定义的code字段，可初始化init中重新定义字段值
@property (nonatomic, copy)   NSString  *code;
//业务层定义的status字段，可初始化init中重新定义字段值
@property (nonatomic, copy)   NSString  *status;
//业务层定义的server_time字段，可初始化init中重新定义字段值
@property (nonatomic, copy)   NSString  *server_time;
//是否显示菊花
@property (nonatomic, assign) BOOL      showWaiting;

@property (nonatomic, strong) NSMutableDictionary* args;
//是否显示错误信息
@property (nonatomic,assign)  BOOL      showNoErrormess;
//是否返回model
@property (nonatomic,assign)  BOOL       isReturnModel;

@property (nonatomic, strong) NSString  *requesturl;

- (NSMutableDictionary*)getArgs;

//子类需要重写以下方法
- (NSString*)getUrl;

- (void)parse:(id)obj;
- (BOOL)notEmpty:(NSString*)str;

@end
