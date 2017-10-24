**基于AF3.0的一套网络请求框架，在基础请求逻辑层之外又做了一层解析和缓存处理，相对来说方便了使用。 先说一说为什么要基于AFNetworking再次开发，不仅因为直接调用其API也不太好，而且也无法做到整个项目的统一配置，最好的方式就是对网络层（AFNetworking）再封装一层，整个项目不允许直接使用 AFNetworking 的 API ，而是直接调用自己封装的网路层，这样网络请求需求都可以在这一层里配置好，使用者无须知道里面的代码逻辑，只管调用封装好的方法就可以实现对应需求。**

## 封装优势：

####  1. 降低项目中的耦合

####  2. 统一配置，方便后期维护。

## 必要步骤：

#### 目前因为SDK集成了一些第三方的库，所以必须导入以下库

####  pod 'AFNetworking', '~> 3.0.4'
####  pod 'YYCache', '~> 0.9.4'
####  pod 'SVProgressHUD', '~> 2.1.2'
####  pod 'YYModel'

## 使用方法：
#### 导入SDK文件
#### 创建自定义model并继承于HYModel

```
#import <RequestSDK/HYModel.h>
#import <RequestSDK/RequestTool.h>
@interface LoginModel : HYModel
+(void)Login;
@end
实现自定义方法：
-(NSString *)getUrl
{
return @“http://www.baidu/login";
}

-(void)parse:(id)obj
{
[super parse:obj];
}

+(void)Login
{
LoginModel * login=[[LoginModel alloc]init];
login.showWaiting=NO;
[RequestTool requestPost:login whenSuccess:^(HYModel *m, id res) {

NSLog(@"m--%@--res--%@",m,res);
} whenFailure:^(NSError *err) {
NSLog(@"err%@",err);
}];
}
```
