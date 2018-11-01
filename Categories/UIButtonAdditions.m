//
//  UIButtonAdditions.m
//  TapKit
//
//  Created by Wu Kevin on 4/28/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "UIButtonAdditions.h"

@implementation UIButton (TapKit)


#pragma mark - Presentations

- (NSString *)normalTitle
{
  return [self titleForState:UIControlStateNormal];
}
- (void)setNormalTitle:(NSString *)normalTitle
{
  [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (NSString *)highlightedTitle
{
  return [self titleForState:UIControlStateHighlighted];
}
- (void)setHighlightedTitle:(NSString *)highlightedTitle
{
  [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)disabledTitle
{
  return [self titleForState:UIControlStateDisabled];
}
- (void)setDisabledTitle:(NSString *)disabledTitle
{
  [self setTitle:disabledTitle forState:UIControlStateDisabled];
}

- (NSString *)selectedTitle
{
  return [self titleForState:UIControlStateSelected];
}
- (void)setSelectedTitle:(NSString *)selectedTitle
{
  [self setTitle:selectedTitle forState:UIControlStateSelected];
}


- (UIColor *)normalTitleColor
{
  return [self titleColorForState:UIControlStateNormal];
}
- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
  [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

- (UIColor *)highlightedTitleColor
{
  return [self titleColorForState:UIControlStateHighlighted];
}
- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
  [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)disabledTitleColor
{
  return [self titleColorForState:UIControlStateDisabled];
}
- (void)setDisabledTitleColor:(UIColor *)disabledTitleColor
{
  [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor *)selectedTitleColor
{
  return [self titleColorForState:UIControlStateSelected];
}
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
  [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}


- (UIColor *)normalTitleShadowColor
{
  return [self titleShadowColorForState:UIControlStateNormal];
}
- (void)setNormalTitleShadowColor:(UIColor *)normalTitleShadowColor
{
  [self setTitleShadowColor:normalTitleShadowColor forState:UIControlStateNormal];
}

- (UIColor *)highlightedTitleShadowColor
{
  return [self titleShadowColorForState:UIControlStateHighlighted];
}
- (void)setHighlightedTitleShadowColor:(UIColor *)highlightedTitleShadowColor
{
  [self setTitleShadowColor:highlightedTitleShadowColor forState:UIControlStateHighlighted];
}

- (UIColor *)disabledTitleShadowColor
{
  return [self titleShadowColorForState:UIControlStateDisabled];
}
- (void)setDisabledTitleShadowColor:(UIColor *)disabledTitleShadowColor
{
  [self setTitleShadowColor:disabledTitleShadowColor forState:UIControlStateDisabled];
}

- (UIColor *)selectedTitleShadowColor
{
  return [self titleShadowColorForState:UIControlStateSelected];
}
- (void)setSelectedTitleShadowColor:(UIColor *)selectedTitleShadowColor
{
  [self setTitleShadowColor:selectedTitleShadowColor forState:UIControlStateSelected];
}


- (UIImage *)normalImage
{
  return [self imageForState:UIControlStateNormal];
}
- (void)setNormalImage:(UIImage *)normalImage
{
  [self setImage:normalImage forState:UIControlStateNormal];
}

- (UIImage *)highlightedImage
{
  return [self imageForState:UIControlStateHighlighted];
}
- (void)setHighlightedImage:(UIImage *)highlightedImage
{
  [self setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)disabledImage
{
  return [self imageForState:UIControlStateDisabled];
}
- (void)setDisabledImage:(UIImage *)disabledImage
{
  [self setImage:disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)selectedImage
{
  return [self imageForState:UIControlStateSelected];
}
- (void)setSelectedImage:(UIImage *)selectedImage
{
  [self setImage:selectedImage forState:UIControlStateSelected];
}


- (UIImage *)normalBackgroundImage
{
  return [self backgroundImageForState:UIControlStateNormal];
}
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
{
  [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}

- (UIImage *)highlightedBackgroundImage
{
  return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void)setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
  [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)disabledBackgroundImage
{
  return [self backgroundImageForState:UIControlStateDisabled];
}
- (void)setDisabledBackgroundImage:(UIImage *)disabledBackgroundImage
{
  [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage *)selectedBackgroundImage
{
  return [self backgroundImageForState:UIControlStateSelected];
}
- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
  [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}


- (void) moveImageToRightSide {
    [self sizeToFit];
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat gapWidth = self.frame.size.width - titleWidth - imageWidth;
    self.titleEdgeInsets = UIEdgeInsetsMake(self.titleEdgeInsets.top,
                                            -imageWidth + self.titleEdgeInsets.left,
                                            self.titleEdgeInsets.bottom,
                                            imageWidth - self.titleEdgeInsets.right);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(self.imageEdgeInsets.top,
                                            titleWidth + self.imageEdgeInsets.left + gapWidth,
                                            self.imageEdgeInsets.bottom,
                                            -titleWidth + self.imageEdgeInsets.right - gapWidth);
}
@end
