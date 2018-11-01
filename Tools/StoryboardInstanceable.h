//
//  StoryboardInstanceable.h
//  SSSAllRollAgency
//
//  Created by xnxin on 2017/3/16.
//  Copyright © 2017年 Darker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StoryboardInstanceable <NSObject>

+ (__kindof UIViewController*)storyboardInstance;

@end
