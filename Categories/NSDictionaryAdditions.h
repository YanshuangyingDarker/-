//
//  NSDictionary+NSDictionaryAdditions.h
//  XHKit
//
//  Created by Xaviar on 15/12/7.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

///-------------------------------
/// Querying
///-------------------------------
- (BOOL)hasObjectEqualTo:(id)object;
- (BOOL)hasObjectIdenticalTo:(id)object;
- (BOOL)hasKeyEqualTo:(id)key;
- (BOOL)hasKeyIdenticalTo:(id)key;
- (id)objectOrNilForKey:(id)key;
- (id)objectOrSpaceStrForKey:(id)key;
- (id)objectOrZeroStrForKey:(id)key;
- (id)objectOrNullForKey:(id)key;


/*
 *把服务器返回的<null> 替换为“”
 *json表示获取到的带有NULL对象的json数据
 *NSDictionary *newDict = [NSDictionary changeType:json];
 */
+(id)changeType:(id)myObj;

@end


@interface NSMutableDictionary (Additions)
- (void)setObject:(id)object forKeyIfNotNil:(id)key;
- (void)removeObjectForKeyIfNotNil:(id)key;

@end
