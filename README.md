>**概述**：基于AF3.0的一套网络请求框架,以制作SDK(framework)的模式开发。可以直接进入SDK文件夹打开项目文件直接编译生成framework文件。拖进项目中进行开发。如果对制作framework或该开发模式不清楚，可以参考这篇[文章][文章]。

**架构逻辑**：
在基础请求逻辑层之外又做了一层解析和缓存处理，相对来说方便了使用。 先说一说为什么要基于AFNetworking再次开发，不仅因为直接调用其API也不太好，而且也无法做到整个项目的统一配置，最好的方式就是对网络层（AFNetworking）再封装一层，整个项目不允许直接使用 AFNetworking 的 API ，而是直接调用自己封装的网路层，这样网络请求需求都可以在这一层里配置好，使用者无须知道里面的代码逻辑，只管调用封装好的方法就可以实现对应需求。

**说明**：
1.因为在架构的时候是基于SDK(framework)的模式来进行开发的 所以该案例下载下来看到的目录结构是这样的
![ico原来的样子](https://github.com/jilei6/HttpRequestSDK/blob/master/Request/1.png)    
Request/RequestDev目录就是你的项目目录 Request/RequestSDK就是该框架的源文件项目，你可以在RequestDev下的项目文件进行测试编译，在RequestSDK下的项目文件进行源码编译打包framework文件。


2.另外，因为在架构的时候是基于SDK的模式开发的，考虑到使用者的项目中可能都会Pod导入了AF、YYCache等第三方库，由此可能会出现重复导入而导致报错的问题，所以已经将使用到的第三方库进行了修改，如图所示，可放心使用。
![ico原来的样子](https://github.com/jilei6/HttpRequestSDK/blob/master/Request/2.png)


**架构优势**：
1.既可以编译framework直接使用，也可以将开源框架源文件拖入项目直接使用

2.降低项目中的耦合

3.统一配置，方便后期维护。


**使用方法**：
1.导入SDK文件
2.创建自定义model并继承于DRHYModel

```

@interface DRScheduleDateModel : DRHYModel
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *week;
@property(nonatomic,assign)NSInteger is_today;
@property (nonatomic,assign) BOOL selectrow;
@property(nonatomic,strong) NSArray *scheduleDatemodelArr;
@end
实现自定义方法：
@implementation DRScheduleDateModel
- (NSString *)getUrl{
//api_match_date_list 宏定义的API 类似这样http://xxx.com/api/test/date_list
return api_match_date_list;
}


- (void)parse:(id)obj{

[super parse:obj];

if ([obj[@"data"][@"list"] isKindOfClass:[NSArray class]])
{

NSArray *dicT = obj[@"data"][@"list"];
self.scheduleDatemodelArr = [DRScheduleDateModel scheudleDataArray:dicT];

}



}


+ (NSArray*)scheudleDataArray:(NSArray*)array{

NSMutableArray *arrayM = [NSMutableArray array];
for (NSDictionary* dict in array) {

DRScheduleDateModel *model = [[DRScheduleDateModel alloc] init];
model.date = [[dict[@"date"] description] EmptyCheckobjnil];
model.week = [[dict[@"week"] description] EmptyCheckobjnil];
model.is_today = [dict[@"is_today"] integerValue];

model.selectrow = model.is_today==1?YES:NO;



[arrayM addObject:model];
}
return  [arrayM copy];
}

@end
```
然后在外部创建该model并调用

```
-(DRScheduleDateModel *)scheduleDaterequest
{
if (!_scheduleDaterequest) {
_scheduleDaterequest=[[DRScheduleDateModel alloc]init];
}
return _scheduleDaterequest;
}
//调用 在这里可以自定义添加model属性，及在这里可以传参数
// self.scheduleDaterequest.date = self.date;
// self.scheduleDaterequest.week = self.week;
// self.scheduleDaterequest.selectrow = NO;
[DRRequest requestPost:self.scheduleDaterequest whenSuccess:^(DRHYModel *m, id res) {


} whenFailure:^(NSError *err) {

}];
```




[文章]:http://www.cocoachina.com/ios/20150127/11022.html
