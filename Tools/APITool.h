//
//  APITool.h
//  VCCenter
//
//  Created by xnxin on 2017/3/10.
//  Copyright © 2017年 VCCenter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APITool : NSObject


+ (nullable NSString *)urlStr:(NSString *)path;
+ (nullable NSURL *)url:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
