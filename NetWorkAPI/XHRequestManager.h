//
//  XHRequestManager.h
//  XUIKit
//
//  Created by Xaviar on 15/12/1.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;

typedef void (^requestSuccessBlock)(id _Nonnull responseObj);
typedef void (^requestFailureBlock) (NSError * _Nonnull error);
typedef void (^responseBlock)(id _Nullable dataObj, NSError * _Nullable error);
typedef void (^progressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);

typedef NS_ENUM(NSInteger, XHRequestError){
    
    XHRequestErrorTokenError = -1,
    XHRequestErrorServerThrown = 2,
    XHRequestErrorDataEmpty = 4,
    XHRequestErrorFileNotExsist,
};

NS_ASSUME_NONNULL_BEGIN

@interface XHRequestManager : NSObject<NSURLSessionDelegate> {
    AFHTTPSessionManager *_manager;
}

///=============================================================================
/// @name Initializer
///=============================================================================
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (nullable instancetype)initWithBaseURL:(NSString*)URL;
+ (instancetype)manager;

@property(readonly) AFHTTPSessionManager *sessionManager;
/**
 The operation queue on which delegate callbacks are run.
 */
@property (readonly, nonatomic, strong) NSOperationQueue *operationQueue;

@property (readonly, nonatomic, strong) NSURLSessionConfiguration *configuration;

/**
 The timeout interval, in seconds, for created requests. The default timeout interval is 60 seconds.
 default is 10s
 @see NSMutableURLRequest -setTimeoutInterval:
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;


- (nullable NSURLSessionDataTask *)getRequest:(NSString *)url
                                       params:(nullable NSDictionary *)params
                                      success:(nullable requestSuccessBlock)successHandler
                                      failure:(nullable requestFailureBlock)failureHandler;

- (nullable NSURLSessionDataTask *)postWithURL:(NSString *)url;

- (nullable NSURLSessionDataTask *)postRequest:(NSString *)url
                                        params:(nullable NSDictionary *)params
                                       success:(nullable requestSuccessBlock)successHandler
                                       failure:(nullable requestFailureBlock)failureHandler;

- (nullable NSURLSessionDataTask *)putRequest:(NSString *)url
                                       params:(nullable NSDictionary *)params
                                      success:(nullable requestSuccessBlock)successHandler
                                      failure:(nullable requestFailureBlock)failureHandler;

- (nullable NSURLSessionDataTask *)deleteRequest:(NSString *)url
                                          params:(nullable NSDictionary *)params
                                         success:(nullable requestSuccessBlock)successHandler
                                         failure:(nullable requestFailureBlock)failureHandler;

- (nullable NSURLSessionDownloadTask *)downloadRequest:(NSString *)url
                                    successAndProgress:(nullable progressBlock)progressHandler
                                              complete:(nullable responseBlock)completionHandler;

- (nullable NSURLSessionDataTask *)updateRequest:(NSString *)url
                                          params:(nullable NSDictionary *)params
                                        filePath:(NSString *)filePath
                                         success:(nullable requestSuccessBlock)successHandler
                                         failure:(nullable requestFailureBlock)failureHandler;

- (nullable NSURLSessionDataTask *)updateRequest:(NSString *)url
                                          params:(NSDictionary *)params
                                        filePath:(NSString *)filePath
                              successAndProgress:(nullable progressBlock)progressHandler
                                        complete:(nullable responseBlock)completionHandler;

- (void)cancelRequest;

NS_ASSUME_NONNULL_END
@end
