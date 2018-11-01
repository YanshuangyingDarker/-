//
//  NSDictionary+XHBundle.h
//  XHKit
//
//  Created by Xaviar on 15/12/8.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSStringAddition.h"

@interface NSBundle (XHBundle)

/**
 An array of NSNumber objects, shows the best order for path scale search.
 e.g. iPhone3GS:@[@1,@2,@3] iPhone5:@[@2,@3,@1]  iPhone6 Plus:@[@3,@2,@1]
 */
+ (NSArray *)preferredScales;

@end
