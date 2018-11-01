//
//  NSDictionary+XHBundle.m
//  XHKit
//
//  Created by Xaviar on 15/12/8.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import "NSBundle+XHBundle.h"
#import "XHKitMacro.h"

XHSYNTH_DUMMY_CLASS(NSBundleXHBundle)

@implementation NSBundle (XHBundle)

+ (NSArray *)preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

@end
