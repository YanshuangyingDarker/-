//
//  XHRequestManager.m
//  XUIKit
//
//  Created by Xaviar on 15/12/1.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHRequestManager.h"
#import "XHKitMacro.h"
#import <objc/message.h>
#import <AFNetworking/AFHTTPSessionManager.h>
//#import "WebApi.h"
//#import "AppDelegate.h"
#import "NSDictionaryAdditions.h"
#import "XHUIHelper.h"

#if __has_include("AFNetworking.framework")
#import <AFNetworking/AFNetworking.h>
#else
#import <AFNetworking/AFNetworking.h>

#endif

#define TIME_OUT 30

NSString *_Nonnull const XHRequestErrorDomain = @"XHRquestErrorDomain";

typedef NS_ENUM(NSInteger,XHNetWorkOperateMode) {
    XHNetWorkOperateModeGET = 1,
    XHNetWorkOperateModePOST,
    XHNetWorkOperateModePUT,
    XHNetWorkOperateModeDELETE
};

@interface XHRequestManager()
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (readwrite, nonatomic, strong) NSURLSessionConfiguration *configuration;
@end

@implementation XHRequestManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static XHRequestManager *manager;
    dispatch_once(&onceToken, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
        manager = [[XHRequestManager alloc]initWithBaseURL:nil];
#pragma clang diagnostic pop
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSString *)URL {
    self = [super init];
    if (!self) return nil;
    
    _baseURL = [NSURL URLWithString:URL];
    
    _manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:self.configuration];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                          @"application/json",
                                                          @"text/html",
                                                          @"text/plain",
                                                          @"text/javascript",
                                                          nil];
    
    return self;
}

+ (BOOL)_checkNetworkStatus {
    
    __block BOOL isNetworkUse = YES;
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
            XHLog(@"网络异常,请检查网络是否可用！");
        }
    }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
}


- (AFHTTPSessionManager *)sessionManager {
    return _manager;
}
#pragma mark -
#pragma mark Private Method

- (NSURLSessionDataTask *)_requestWithURL:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler mode:(XHNetWorkOperateMode)mode {
    NSParameterAssert(url);
    if (params) NSAssert([params isKindOfClass:[NSDictionary class]],@"params is not a dictionary ");
    
//    if (![[self class] _checkNetworkStatus]) {
//        if (failureHandler) failureHandler([NSError errorWithDomain:XHRquestErrorDomain
//                                                               code:XHRquestError
//                                                           userInfo:@{ NSLocalizedDescriptionKey : @"没有网络连接" }]);
//        return nil;
//    }
    SEL sel;
    switch (mode) {
        case XHNetWorkOperateModeGET: {
            sel = @selector(GET:parameters:success:failure:);
            break;
        }
        case XHNetWorkOperateModePOST: {
            sel = @selector(POST:parameters:success:failure:);
            break;
        }
        case XHNetWorkOperateModePUT: {
            sel = @selector(PUT:parameters:success:failure:);
            break;
        }
        case XHNetWorkOperateModeDELETE: {
            sel = @selector(DELETE:parameters:success:failure:);
            break;
        }
    }


//    UserModel *user = UserModel.login;
//    if (user) {
//        [_manager.requestSerializer setValue:user.token forHTTPHeaderField:@"token"];
//        NSLog(@"-----token---%@",user.token);
//    }
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *dataTask = ((NSURLSessionDataTask* (*)(id, SEL, NSString *, NSDictionary *, id, id)) objc_msgSend)(_manager,sel,url,params,
                 ^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                     
                     application.networkActivityIndicatorVisible = NO;
                     
                     NSInteger status = [[responseObject objectOrNilForKey:@"status"] integerValue];
                     
                     if (status == 0) {
                         if (successHandler) {
                             successHandler(responseObject);
                         }
                     } else {
                         
                         NSString *msg = [responseObject objectOrNilForKey:@"message"];
                         NSError *error = [NSError errorWithDomain:XHRequestErrorDomain
                                                              code:status
                                                          userInfo:@{NSLocalizedDescriptionKey:msg ?: @"服务器错误"}];
                         if (failureHandler) {
                             failureHandler(error);
                         }
                     }
                 },^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                     if (error.code == kCFURLErrorCancelled) {
                         XHLog(@"cannel request %s,on website:%@",__TIME__,[error.userInfo objectForKey:@"NSErrorFailingURLKey"]);
                     }
                     else if (failureHandler) {
                         failureHandler(error);
                     }
                     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 });
    return dataTask;
}

#pragma mark -
#pragma mark Setter&&Getter

- (NSURLSessionConfiguration *)configuration {
    if (!_configuration) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        _configuration.protocolClasses = @[[CustomURLProtocol class]];
        _configuration.allowsCellularAccess = YES;
        _configuration.timeoutIntervalForResource = TIME_OUT;
        _configuration.timeoutIntervalForResource = TIME_OUT * 3;

    }
    return _configuration;
}

#pragma mark -
#pragma mark Action
- (NSURLSessionDataTask *)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler
{
    
    return [self _requestWithURL:url
                          params:params
                         success:successHandler
                         failure:failureHandler
                            mode:XHNetWorkOperateModeGET];
    
}

- (NSURLSessionDataTask *)postWithURL:(NSString *)url {
    
    return [self postRequest:url
                      params:nil
                     success:nil
                     failure:nil];
}

- (NSURLSessionDataTask *)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler
{
    
    return [self _requestWithURL:url params:params success:successHandler failure:failureHandler mode:XHNetWorkOperateModePOST];
    
}


- (NSURLSessionDataTask *)putRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler
{
    
    return [self _requestWithURL:url params:params success:successHandler failure:failureHandler mode:XHNetWorkOperateModePUT];
    
}

- (NSURLSessionDataTask *)deleteRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler
{
    
    return [self _requestWithURL:url params:params success:successHandler failure:failureHandler mode:XHNetWorkOperateModeDELETE];
    
}

- (void)cancelRequest {
    [_manager.operationQueue cancelAllOperations];
}


- (NSURLSessionDownloadTask *)downloadRequest:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler
{
    
    NSParameterAssert(url);
    NSParameterAssert(completionHandler);
//    
//    if (![[self class] _checkNetworkStatus]) {
//        if (completionHandler) completionHandler(nil,[NSError errorWithDomain:XHRquestErrorDomain
//                                                                         code:XHRquestError
//                                                                     userInfo:@{@"errorInfo":@"NetWorking error"}]);
//        return nil;
//    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSProgress *kProgress = nil;
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:^(NSProgress *downloadProgress) {
                                                                         
                                                                     }
                                                                  destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
    {
        
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                    inDomain:NSUserDomainMask
                                                           appropriateForURL:nil
                                                                      create:NO
                                                                       error:nil];
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response,
                          NSURL * _Nullable filePath,
                          NSError * _Nullable error) {
        
        if (error) {
            XHLog(@"%s Download failed ,errorInfo:%@,date: %s, line:%d",__FUNCTION__,error,__DATE__,__LINE__);
        }
        if (completionHandler) completionHandler(response, error);
        
    }];
    
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session,
                                                NSURLSessionDownloadTask * _Nonnull downloadTask,
                                                int64_t bytesWritten,
                                                int64_t totalBytesWritten,
                                                int64_t totalBytesExpectedToWrite)
    {
        
        if (progressHandler) progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        
    }];
    [downloadTask resume];
    
    return downloadTask;
}


- (NSURLSessionDataTask *)updateRequest:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)filePath success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler
{
    NSParameterAssert(url);
    if (!url || url.length == 0) return nil;
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        if (failureHandler) failureHandler([NSError errorWithDomain:XHRequestErrorDomain
                                                               code:XHRequestErrorFileNotExsist
                                                           userInfo:@{NSLocalizedDescriptionKey:@"文件不存在"}]);
        XHLog(@"%s uploadfile failed, file not exsist,date: %s, line : %d",__FUNCTION__,__DATE__,__LINE__);
    }
    return nil;
}

- (NSURLSessionDataTask *)updateRequest:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)filePath successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler
{
    return nil;
}
@end
