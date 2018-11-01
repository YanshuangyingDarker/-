//
//  NSNumber+Addition.h
//  XUIKit
//
//  Created by Xaviar on 15/11/24.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provide a method to parse `NSString` for `NSNumber`.
 */
@interface NSNumber (Addition)

/**
 Creates and returns an NSNumber object from a string.
 Valid format: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 
 @param string  The string described an number.
 
 @return an NSNumber when parse succeed, or nil if an error occurs.
 */
+ (NSNumber *)numberWithString:(NSString *)string;


@end
