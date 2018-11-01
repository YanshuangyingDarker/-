//
//  APITool.m
//  VCCenter
//
//  Created by xnxin on 2017/3/10.
//  Copyright © 2017年 VCCenter. All rights reserved.
//

#import "APITool.h"
//#import "NetUrlTool.h"

@implementation APITool

//+ (NSString *)urlStr:(NSString *)path {
//    
//    return [self url:path].absoluteString;
//}
//
//+ (NSURL *)url:(NSString *)path {
//
//    return [NetUrlTool urlWithPath:path];
////
////#ifdef DEBUG
////    NSString *server = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverPerference"];
////    if (!server) {
////        server = @"http://192.168.0.254/ssstc";
////    }
////#else
////    NSString *server = @"";
////#endif
////    if (!path) {
////        return nil;
////    }
////    NSURL *baseURL = [NSURL URLWithString:@"ssstc"
////                            relativeToURL:[NSURL URLWithString:server]];
////    NSAssert(baseURL != nil, @"must have correct url");
////    return [baseURL URLByAppendingPathComponent:path];
//}
@end
