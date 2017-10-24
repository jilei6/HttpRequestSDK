//
//  NetWorkManager.m
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "NetWorkManager.h"

#import "NetWorkManager.h"
#import "RequestHPNetWorkCache.h"
#import "UIImage+compressIMG.h"

static BOOL _isNetwork;
@implementation NetWorkManager
@dynamic requestSerializer;
    
    
#pragma mark - shareManager
    /**
     *  获得全局唯一的网络请求实例单例方法
     *
     *  @return 网络请求类的实例
     */
    
+(instancetype)shareManager
    {
        
        static NetWorkManager * manager = nil;
        
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            
            manager = [[self alloc] initWithBaseURL:nil];
            manager.securityPolicy = [DRAFSecurityPolicy policyWithPinningMode:DRAFSSLPinningModeNone];

            
        });
        
        return manager;
    }
    
    
#pragma mark - 重写initWithBaseURL
    /**
     *
     *
     *  @param url baseUrl
     *
     *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
     */
    
-(instancetype)initWithBaseURL:(NSURL *)url
    {
        
        if (self = [super initWithBaseURL:url]) {
            
            
            
            //#warning 可根据具体情况进行设置
            
            //NSAssert(url,@"您需要为您的请求设置baseUrl");
            
            /**设置请求超时时间*/
            
            self.requestSerializer.timeoutInterval = 3;
            
            /**设置相应的缓存策略*/
            
            self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            
            
            /**分别设置请求以及相应的序列化器*/
            self.requestSerializer = [DRAFHTTPRequestSerializer serializer];
            
            DRAFJSONResponseSerializer * response = [DRAFJSONResponseSerializer serializer];
            
            response.removesKeysWithNullValues = YES;
            
            self.responseSerializer = response;
            
            /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
            
           // [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            
            //#warning 此处做为测试 可根据自己应用设置相应的值
            
            /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
            
            [self.requestSerializer setValue:@"" forHTTPHeaderField:@"tooken"];
            
            
            
            /**设置接受的类型*/
            [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
            
        }
        
        return self;
    }
    
    
#pragma mark - 网络请求的类方法---get/post
    
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
    withFailureBlock:(requestFailure)failureBlock
    {
        
        //读取缓存
        responseCache ? responseCache([RequestHPNetWorkCache httpCacheForURL:urlString parameters:paraments]) : nil;
        
        [self requestWithType:HttpRequestTypePost withUrlString:urlString withParaments:paraments withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
            
            successBlock(task,object);
            
        } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            failureBlock(task,error);
            
        } progress:^(float progress) {
            
            
        }];
        
    }
    
    
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
    withFailureBlock:(requestFailure)failureBlock
    {
        
        //读取缓存
        responseCache ? responseCache([RequestHPNetWorkCache httpCacheForURL:urlString parameters:paraments]) : nil;
        
        [self requestWithType:HttpRequestTypeGet withUrlString:urlString withParaments:paraments withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
            
            successBlock(task,object);
            
        } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            failureBlock(task,error);
            
        } progress:^(float progress) {
            
            
        }];
        
    }
    
    
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
    withFailureBlock:(requestFailure)failureBlock
    
    {
        [self requestWithType:HttpRequestTypePost withUrlString:urlString withParaments:paraments withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
            
            successBlock(task,object);
            
        } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            failureBlock(task,error);
            
        } progress:^(float progress) {
            
            
        }];
        
    }
    
    /**
     *  网络请求不带缓存GET的实例方法
     *
     
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     
     */
+(void)getNoCache :(NSString*)urlString
     WithParaments:(NSDictionary*)paraments
  withSuccessBlock:(requestSuccess)successBlock
  withFailureBlock:(requestFailure)failureBlock
    {
        [self requestWithType:HttpRequestTypeGet withUrlString:urlString withParaments:paraments withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
            
            successBlock(task,object);
            
        } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            failureBlock(task,error);
            
        } progress:^(float progress) {
            
            
        }];
    }
    /**
     *  网络请求的实例方法
     *
     *  @param type         get / post
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     *  @param progress 进度
     */
    
+(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress
    {
        
        
        switch (type) {
            
            case HttpRequestTypeGet:
            {
                
                
                [[NetWorkManager shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                    progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    successBlock(task,responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    failureBlock(task,error);
                }];
                
                break;
            }
            
            case HttpRequestTypePost:
            
            {
                NSLog(@"URL-----%@",urlString);
                NSLog(@"paraments-----%@",paraments);
                
                [[NetWorkManager shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                    
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    successBlock(task,responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    failureBlock(task,error);
                    
                }];
            }
            
        }
        
    }
    
    
#pragma mark - 多图上传
    /**
     *  上传图片
     *
     *  @param operations   上传图片等预留参数---视具体情况而定 可移除
     *  @param imageArray   上传的图片数组
     *  @parm width      图片要被压缩到的宽度
     *  @param urlString    上传的url---请填写完整的url
     *  @param successBlock 上传成功的回调
     *  @param failureBlock 上传失败的回调
     *  @param progress     上传进度
     *
     */
+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress;
    {
        
        
        //1.创建管理者对象
        
        DRAFHTTPSessionManager *manager = [DRAFHTTPSessionManager manager];
        
        [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<DRAFMultipartFormData>  _Nonnull formData) {
            
            NSUInteger i = 0 ;
            
            /**出于性能考虑,将上传图片进行压缩*/
            for (UIImage * image in imageArray) {
                
                //image的分类方法
                UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
                
                NSData * imgData = UIImageJPEGRepresentation(resizedImage, .5);
                
                //拼接data
                [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
                
                i++;
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            
            successBlock(task,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(task,error);
            
        }];
    }
    
    
    
    
    
#pragma mark -  取消所有的网络请求
    
    /**
     *  取消所有的网络请求
     *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
     */
    
+(void)cancelAllRequest
    {
        
        [[NetWorkManager shareManager].operationQueue cancelAllOperations];
        
    }
    
    
    
#pragma mark -   取消指定的url请求/
    /**
     *  取消指定的url请求
     *
     *  @param requestType 该请求的请求类型
     *  @param string      该请求的完整url
     */
    
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
    {
        
        NSError * error;
        
        /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
        
        NSString * urlToPeCanced = [[[[NetWorkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
        
        
        for (NSOperation * operation in [NetWorkManager shareManager].operationQueue.operations) {
            
            //如果是请求队列
            if ([operation isKindOfClass:[NSURLSessionTask class]]) {
                
                //请求的类型匹配
                BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
                
                //请求的url匹配
                
                BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
                
                //两项都匹配的话  取消该请求
                if (hasMatchRequestType&&hasMatchRequestUrlString) {
                    
                    [operation cancel];
                    
                }
            }
            
        }
    }
    
    ///** 网络状态的Block*/
    //+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus
    //    {
    //        static dispatch_once_t onceToken;
    //        dispatch_once(&onceToken, ^{
    //            
    //            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    //             {
    //                 switch (status)
    //                 {
    //                     case AFNetworkReachabilityStatusUnknown:
    //                     networkStatus ? networkStatus(MFNetworkStatusUnknown) : nil;
    //                     _isNetwork = NO;
    //                     
    //                     break;
    //                     case AFNetworkReachabilityStatusNotReachable:
    //                     networkStatus ? networkStatus(MFNetworkStatusNotReachable) : nil;
    //                     _isNetwork = NO;
    //                     
    //                     break;
    //                     case AFNetworkReachabilityStatusReachableViaWWAN:
    //                     networkStatus ? networkStatus(MFNetworkStatusReachableViaWWAN) : nil;
    //                     _isNetwork = YES;
    //                     
    //                     break;
    //                     case AFNetworkReachabilityStatusReachableViaWiFi:
    //                     networkStatus ? networkStatus(MFNetworkStatusReachableViaWiFi) : nil;
    //                     _isNetwork = YES;
    //                     
    //                     break;
    //                 }
    //             }];
    //            
    //            [manager startMonitoring];
    //        });
    //    }
    
    
    
    
    
    
    
    
    
    @end
