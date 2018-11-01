//
//  XHModel.m
//  XHKitDemo
//
//  Created by Xaviar on 2016/6/27.
//  Copyright © 2016年 Xaviar. All rights reserved.
//

#import "XHModel.h"
#import "XHClassInfo.h"


@interface XHModel (genericMapDic)

+ (NSDictionary*) mapDic;
+ (NSDictionary*) classDic;

@end

@implementation XHModel (genericMapDic)
+ (NSDictionary*) mapDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    XHClassInfo *classInfo = [XHClassInfo classInfoWithClass:[self class]];
    XHClassInfo *currentInfo = classInfo;
    while (currentInfo && currentInfo.cls != [NSObject class]) {
        for (XHClassPropertyInfo *info in currentInfo.propertyInfos.allValues) {
            NSString *name = info.name;
            NSString *mapName = nil;
            NSString *setter = NSStringFromSelector(info.setter);
            
            NSUInteger length = setter.length;
            if ([setter hasPrefix:@"_XH_"] && length > 5) {
                mapName = [setter substringWithRange:NSMakeRange(4, length - 5)];
            }
            
            if (mapName.length > 0) {
                mapDic[name] = mapName;
            }
        }
        currentInfo = currentInfo.superClassInfo;
    }
    mapDic[@"uid"] = @[@"id", @"ID", @"uid", @"orderId"];
    return mapDic;
}

+ (NSDictionary*) classDic {
    
    NSMutableDictionary *clsDic = [NSMutableDictionary dictionary];
    XHClassInfo *classInfo = [XHClassInfo classInfoWithClass:[self class]];
    XHClassInfo *currentInfo = classInfo;
    while (currentInfo && currentInfo.cls != [NSObject class]) {
        for (XHClassPropertyInfo *info in currentInfo.propertyInfos.allValues) {
            NSString *name = info.name;
            
            NSUInteger type = info.type & XHEncodingTypeMask;
            if (type == XHEncodingTypeObject) {
                
                if ([info.typeEncoding hasPrefix:@"@\"NSArray<"]){
                    // T@"NSArray<ClassName>"
                    const char *className = [[info.typeEncoding substringWithRange:NSMakeRange(10, info.typeEncoding.length-12)] cStringUsingEncoding:NSUTF8StringEncoding];
                    Class cls = objc_getClass(className);
                    if (cls != nil && [cls isSubclassOfClass:[XHModel class]])
                    {
                        clsDic[name] = cls;
                    }
                } else if ([info.typeEncoding hasPrefix:@"@\"NSMutableArray<"]) {
                    // T@"NSMutableArray<ClassName>"
                    const char *className = [[info.typeEncoding substringWithRange:NSMakeRange(17, info.typeEncoding.length-19)] cStringUsingEncoding:NSUTF8StringEncoding];
                    Class cls = objc_getClass(className);
                    if (cls != nil && [cls isSubclassOfClass:[XHModel class]])
                    {
                        clsDic[name] = cls;
                    }
                    
                }
            }
        }
        currentInfo = currentInfo.superClassInfo;
    }
    return clsDic;
}

@end
//
//@interface XHModel()
//
//@property (nonatomic, strong) NSString *uid;
//
//@end

@implementation XHModel

- (instancetype)initWithDictionary:(NSDictionary*) dic {
    
    return [self.class modelWithDictionary:dic];
}

- (instancetype)initWithJson:(id)json {
    return [self.class modelWithJSON:json];
}

- (instancetype)initWithUid:(NSString *)aUid {
    self = [super init];
    if (!self) {
        return nil;
    }
    _uid = aUid;
    return self;
}

- (void)updateWithDictionary:(NSDictionary*) dic {
    [self modelUpdateWithDictionary:dic];
}

- (void)updateWithJson:(id)json {
    [self modelUpdateWithJson:json];
}
#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

#pragma mark -
#pragma mark Copying Protocol

- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

#pragma mark -
#pragma mark NSObject Protocol

- (NSString *)description {
    return [self modelDescription];
}

- (NSUInteger)hash {
    return [self modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}

#pragma mark -
#pragma mark class Method

+ (NSDictionary*)modelContainerPropertyGenericClass {
    static CFMutableDictionaryRef classCache;
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        classCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(),
                                          0,
                                          &kCFTypeDictionaryKeyCallBacks,
                                          &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(lock);
    
    Class cls = [self class];
    
    NSDictionary *dic = CFDictionaryGetValue(classCache, (__bridge const void *)cls);
    if (!dic) {
        dic = [self classDic];
        if (dic) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(classCache, (__bridge const void *)(cls), (__bridge const void *)(dic));
            dispatch_semaphore_signal(lock);
        }
    }

    return dic;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    static CFMutableDictionaryRef mapperCache;
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        mapperCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(),
                                          0,
                                          &kCFTypeDictionaryKeyCallBacks,
                                          &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(lock);
    
    Class cls = [self class];
    
    NSDictionary *dic = CFDictionaryGetValue(mapperCache, (__bridge const void *)cls);
    if (!dic) {
        dic = [self mapDic];
        if (dic) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(mapperCache, (__bridge const void *)(cls), (__bridge const void *)(dic));
            dispatch_semaphore_signal(lock);
        }
    }

    if (!dic) {
        return [NSDictionary new];
    }
    return dic;
}
@end


