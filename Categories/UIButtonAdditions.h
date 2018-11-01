//
//  UIButtonAdditions.h
//  TapKit
//
//  Created by Wu Kevin on 4/28/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (TapKit)

///-------------------------------
/// Presentations
///-------------------------------

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *highlightedTitle;
@property (nonatomic, copy) NSString *disabledTitle;
@property (nonatomic, copy) NSString *selectedTitle;

@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *highlightedTitleColor;
@property (nonatomic, strong) UIColor *disabledTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIColor *normalTitleShadowColor;
@property (nonatomic, strong) UIColor *highlightedTitleShadowColor;
@property (nonatomic, strong) UIColor *disabledTitleShadowColor;
@property (nonatomic, strong) UIColor *selectedTitleShadowColor;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, strong) UIImage *disabledImage;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *highlightedBackgroundImage;
@property (nonatomic, strong) UIImage *disabledBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;

- (void) moveImageToRightSide;
@end
