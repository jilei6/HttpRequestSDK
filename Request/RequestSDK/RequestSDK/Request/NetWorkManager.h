//
//  NetWorkManager.h
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//


#import "DRAFNetworking.h"
/**定义请求类型的枚举*/

typedef NS_ENUM(NSUInteger,HttpRequestType)
{
    
    HttpRequestTypeGet = 0,
    HttpRequestTypePost
    
};


/**定义请求成功的block*/
typedef void(^requestSuccess)(NSURLSessionDataTask *  task, NSDictionary *  object);

/**定义请求失败的block*/
typedef void(^requestFailure)(NSURLSessionDataTask *  task, NSError *  error);

/**定义上传进度block*/
typedef void(^uploadProgress)(float progress);

/**定义下载进度block*/
typedef void(^downloadProgress)(float progress);


@interface NetWorkManager : DRAFHTTPSessionManager


@property (nonatomic, strong) DRAFHTTPRequestSerializer <DRAFURLRequestSerialization> * requestSerializer;
    
    /**
     *  单例方法
     *
     *  @return 实例对象
     */
+(instancetype)shareManager;
    
    
    /**
     *  网络请求带缓存POST的实例方法
     *
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param responseCache 缓存数据
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     */
+(void)postWithCache:(NSString *)urlString
       WithParaments:(NSDictionary *)paraments
   WithResponseCache:(void (^)(id responseObject))responseCache
    withSuccessBlock:(requestSuccess)successBlock
    withFailureBlock:(requestFailure)failureBlock;
    
    
    
    /**
     *  网络请求不带缓存POST的实例方法
     
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     */
+(void)postNoCache  :(NSString*)urlString
       WithParaments:(NSDictionary*)paraments
    withSuccessBlock:(requestSuccess)successBlock
    withFailureBlock:(requestFailure)failureBlock;
    
    
    
    
    /**
     *  网络请求不带缓存POST的实例方法
     *
     
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     
     */
+(void)getNoCache :(NSString*)urlString
     WithParaments:(NSDictionary*)paraments
  withSuccessBlock:(requestSuccess)successBlock
  withFailureBlock:(requestFailure)failureBlock;
    
    
    
    
    
    /**
     *  网络请求带缓存GET的实例方法
     *
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param responseCache 缓存数据
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     
     */
+(void)getWithCache :(NSString*)urlString
       WithParaments:(NSDictionary*)paraments
   WithResponseCache:(void (^)(id responseObject))responseCache
    withSuccessBlock:(requestSuccess)successBlock
    withFailureBlock:(requestFailure)failureBlock;
    
    
    
    
    /**
     *  上传图片
     *
     *  @param operations   上传图片预留参数---视具体情况而定 可移除
     *  @param imageArray   上传的图片数组
     *  @parm width      图片要被压缩到的宽度
     *  @param urlString    上传的url
     *  @param successBlock 上传成功的回调
     *  @param failureBlock 上传失败的回调
     *  @param progress     上传进度
     */
    
+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress;
    
    
    
    
    
    
    /**
     *  取消所有的网络请求
     */
    
    
+(void)cancelAllRequest;
    /**
     *  取消指定的url请求
     *
     *  @param requestType 该请求的请求类型
     *  @param string      该请求的url
     */
    
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;
    
    
    /** 网络状态的Block*/
    //+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus;
    @end
