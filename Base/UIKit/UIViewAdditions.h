//
//  UIViewAdditions.h
//  TapKit
//
//  Created by Wu Kevin on 5/13/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (TapKit)

///-------------------------------
/// Metric properties
///-------------------------------

@property (nonatomic, assign) CGFloat leftX;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat rightX;

@property (nonatomic, assign) CGFloat topY;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat bottomY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;


///-------------------------------
/// Image content
///-------------------------------

- (UIImage *)imageRep;


///-------------------------------
/// Placing
///-------------------------------

- (void)occupySuperview;
- (void)moveToCenterOfSuperview;
- (void)moveToVerticalCenterOfSuperview;
- (void)moveToHorizontalCenterOfSuperview;


///-------------------------------
/// Finding views
///-------------------------------

- (NSArray *)superviewArray;
- (NSArray *)subviewArrayWithClass:(Class)cls;
- (UIView *)descendantOrSelfWithClass:(Class)cls;
- (UIView *)ancestorOrSelfWithClass:(Class)cls;


///-------------------------------
/// Hierarchy
///-------------------------------

- (UIView *)rootView;
- (void)bringToFront;
- (void)sendToBack;
- (BOOL)isInFront;
- (BOOL)isAtBack;


///-------------------------------
/// Debug
///-------------------------------

- (void)showBorderWithRedColor;
- (void)showBorderWithGreenColor;
- (void)showBorderWithBlueColor;
- (void)showBorderWithBrownColor;
- (void)showBorderWithPurpleColor;

+ (void)showBorder:(UIView *)view level:(NSInteger)level;
+ (void)dumpView:(UIView *)view level:(NSInteger)level;

@end
