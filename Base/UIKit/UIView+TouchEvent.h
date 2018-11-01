//
//  UIView+TouchEvent.h
//  XHKitDemo
//
//  Created by Xaviar on 16/6/3.
//  Copyright © 2016年 Xaviar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TouchEvent)

@property (nonatomic, assign) NSTimeInterval XH_acceptEventInterval;   // 可以用这个给重复点击加间隔
@property (nonatomic, assign) NSTimeInterval XH_acceptedEventTime;

@end
