//
//  NSArray+Order.h
//  CCTV
//
//  Created by Xaviar on 15/10/14.
//  Copyright © 2015年 pengjay.cn@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Order)

- (NSMutableArray*)OrderByPropertyName:(NSString* )propertyNames, ... NS_REQUIRES_NIL_TERMINATION;

@end
