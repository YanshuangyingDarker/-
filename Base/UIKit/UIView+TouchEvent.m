//
//  UIView+TouchEvent.m
//  XHKitDemo
//
//  Created by Xaviar on 16/6/3.
//  Copyright © 2016年 Xaviar. All rights reserved.
//

#import "UIView+TouchEvent.h"
#import "XHKitMacro.h"
#import <objc/runtime.h>

static const char * UIView_acceptEventInterval = "UIView_acceptEventInterval";
static const char * UIView_acceptEventTime = "UIView_acceptEventTime";


@implementation UIView (TouchEvent)

//+ (void)load
//{
//    Method a = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
//    Method b = class_getInstanceMethod(self, @selector(_XH_pointInside:withEvent:));
//    method_exchangeImplementations(a, b);
//}

- (NSTimeInterval)XH_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIView_acceptEventInterval) doubleValue];
}

- (void)setXH_acceptEventInterval:(NSTimeInterval)XH_acceptEventInterval
{
    objc_setAssociatedObject(self, UIView_acceptEventInterval, @(XH_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)XH_acceptedEventTime {
    return [objc_getAssociatedObject(self, UIView_acceptEventTime) doubleValue];
}

- (void)setXH_acceptedEventTime:(NSTimeInterval)XH_acceptedEventTime {
    objc_setAssociatedObject(self, UIView_acceptEventTime, @(XH_acceptedEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)_XH_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event{
    if ([[NSDate date] timeIntervalSince1970] - self.XH_acceptedEventTime < self.XH_acceptEventInterval) return NO;
    
//    XHLog(@"click %@",self);
    if (self.XH_acceptEventInterval > 0)
    {
        self.XH_acceptedEventTime = NSDate.date.timeIntervalSince1970;
    }
    return [self _XH_pointInside:point withEvent:event];
}

@end
