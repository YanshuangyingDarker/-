//
//  NSArray+Order.m
//  CCTV
//
//  Created by Xaviar on 15/10/14.
//  Copyright © 2015年 pengjay.cn@gmail.com. All rights reserved.
//

#import "NSArray+Order.h"
#import "objc/runtime.h"
#import <Foundation/Foundation.h>

@implementation NSArray (Order)

- (NSMutableArray*)OrderByPropertyName:(NSString* )propertyNames, ... {
    
    if (self.count <= 1 || !self) {
        return [self mutableCopy];
    }
    
    id obj = self[0];
    
    NSMutableArray *descriptorArray = [NSMutableArray array];
    
    va_list args;
    va_start(args, propertyNames);
    NSString *propertyName = propertyNames;
    if (propertyName) {
        while (1) {
            if (propertyName == nil) {
                break;
            }
            
            if ([self isExistProperty:obj propertyName:propertyName]) {
                    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:propertyName ascending:YES];
                    [descriptorArray addObject:descriptor];
            }
            propertyName = va_arg(args, NSString *);
        }
    }
    va_end(args);
    
    return [[self sortedArrayUsingDescriptors:descriptorArray]mutableCopy];
}

- (BOOL)isExistProperty:(id)obj propertyName:(NSString*)propertyName{
    if ([obj superclass] == nil)
        return NO;
    BOOL res = NO;
    unsigned int count = 0;
    int i = 0;
    Ivar *members = class_copyIvarList([obj class], &count);
    for (; i < count; i++) {
        Ivar var = members[i];
        const char *memberName = ivar_getName(var);
        NSString *propertyName2 = [NSString stringWithFormat:@"_%@",propertyName];
        if ([@(memberName) isEqualToString:propertyName] ||
            [@(memberName) isEqualToString:propertyName2])
        {
            break;
        }
    }
    free(members);
    
    if (i < count) {
        res = YES;
    } else {
        res = [self isExistProperty:[obj superclass] propertyName:propertyName];
    }
    return res;
    
}
@end
