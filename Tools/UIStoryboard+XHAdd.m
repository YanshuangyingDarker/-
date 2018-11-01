//
//  UIStoryboard+XHAdd.m
//  VCCenter
//
//  Created by xnxin on 2017/3/8.
//  Copyright © 2017年 VCCenter. All rights reserved.
//

#import "UIStoryboard+XHAdd.h"

@implementation UIStoryboard (XHAdd)

- (UIViewController *)controller:(Class)cls {
    return [self instantiateViewControllerWithIdentifier:NSStringFromClass(cls)];
}

@end
