//
//  XHLoginInUser.h
//  XHKitDemo
//
//  Created by Xaviar on 15/12/14.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHModelProtocol

@required
//to identifier a unique model
@property (nonatomic, strong, readonly) NSString *uid;

@end


@protocol OCModelMappable

+ (instancetype)modelWithJSON:(id)json;

@end
