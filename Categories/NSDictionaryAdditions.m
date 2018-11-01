//
//  NSDictionary+NSDictionaryAdditions.m
//  XHKit
//
//  Created by Xaviar on 15/12/7.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import "NSDictionaryAdditions.h"

@implementation NSDictionary (Additions)

#pragma mark - Querying

- (BOOL)hasObjectEqualTo:(id)object
{
    return ( [[self allValues] indexOfObject:object] != NSNotFound );
}

- (BOOL)hasObjectIdenticalTo:(id)object
{
    return ( [[self allValues] indexOfObjectIdenticalTo:object] != NSNotFound );
}

- (BOOL)hasKeyEqualTo:(id)key
{
    return ( [[self allKeys] indexOfObject:key] != NSNotFound );
}

- (BOOL)hasKeyIdenticalTo:(id)key
{
    return ( [[self allKeys] indexOfObjectIdenticalTo:key] != NSNotFound );
}

- (id)objectOrNilForKey:(id)key
{
    id object = [self objectForKey:key];
    if ( object != [NSNull null] ) {
        return object;
    }
    return nil;
}
- (id)objectOrSpaceStrForKey:(id)key
{
    id object = [self objectForKey:key];
    if ( object != [NSNull null]  && object != nil) {
        return object;
    }
    return @" ";
}

- (id)objectOrZeroStrForKey:(id)key
{
    id object = [self objectForKey:key];
    if ( object != [NSNull null]  && object != nil) {
        return object;
    }
    return @"0";
}

- (id)objectOrNullForKey:(id)key {
    return [self objectOrNilForKey:key] ?: @"null";
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSArray中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

//主要方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

@end


@implementation NSMutableDictionary (Additions)


#pragma mark - Adding and removing entries

- (void)setObject:(id)object forKeyIfNotNil:(id)key
{
    if ( object && key ) {
        [self setObject:object forKey:key];
    }
}

- (void)removeObjectForKeyIfNotNil:(id)key
{
    if ( key ) {
        [self removeObjectForKey:key];
    }
}
@end
