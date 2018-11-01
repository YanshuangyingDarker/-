//
//  XHModel.h
//  XHKitDemo
//
//  Created by Xaviar on 2016/6/27.
//  Copyright © 2016年 Xaviar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHModel+JSON.h"
#import "XHModelProtocol.h"

#define XHProperty(Property, MapName)	\
@property (nonatomic, setter=_XH_##MapName:) Property

@interface XHModel : NSObject<NSCoding, NSCopying, NSMutableCopying, XHModel, OCModelMappable> {
//    NSString *_uid;
}

@property (nonatomic, strong) NSString *uid;


- (instancetype)initWithDictionary:(NSDictionary*)dic;
- (instancetype)initWithJson:(id)json;
- (instancetype)initWithUid:(NSString *)aUid;

- (void)updateWithDictionary:(NSDictionary*)dic;
- (void)updateWithJson:(id)json;

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper NS_REQUIRES_SUPER;
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass NS_REQUIRES_SUPER;

@end
