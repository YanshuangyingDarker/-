//
//  UIHelper.h
//  XUIKit
//
//  Created by Xaviar on 15/12/4.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

extern NSString * _Nonnull const XHRequestErrorDomain;

@interface XHUIHelper : NSObject

NS_ASSUME_NONNULL_BEGIN

+ ( UIBarButtonItem *)navBackButtonWithImage:( NSString *)image target:( id)target action:( SEL)action;
+ ( UIBarButtonItem *)navBarButtonWithTitle:( NSString *)title target:( id)target action:( SEL)action;
+ ( UIBarButtonItem *)navBarLeftButtonWithTitle:( NSString *)title target:( id)target action:( SEL)action;
+ ( UIBarButtonItem *)navBarButtonWithImage:( UIImage *)image target:( id)target action:( SEL)action;
+ ( UIBarButtonItem *)navBarButtonWithImageName:( NSString *)imageName target:( id)target action:( SEL)action;
+ ( UIBarButtonItem *)navBarButtonLeftWithImage:( UIImage *)image target:( id)target action:( SEL)action;;
+ ( UIBarButtonItem *)navBarButtonWithTitle:( NSString *)title color:( UIColor*)color target:( id)target action:( SEL)action;
+ ( UIBarButtonItem *)navBarButtonWithTitle:( NSString *)title imageName:( NSString *)imageName target:( id)target action:( SEL)action;


+ (BOOL)showError:(nullable NSError*)error withView:( UIView*)view;
+ ( MBProgressHUD*)showAutoHideHUDforView:( UIView*)view title:(nullable NSString*)title;
+ ( MBProgressHUD*)showAutoHideHUDforView:( UIView*)view title:(nullable NSString*)title subTitle:(nullable NSString*)subTitle;
+ ( MBProgressHUD*)showAutoHideHUDforView:( UIView*)view title:(nullable NSString*)title completeBlock:(nullable void (^)(void))completion;
+ ( MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(nullable NSString*)title subTitle:(nullable NSString*)subTitle completeBlock:(nullable void (^)(void))completion;
+ (MBProgressHUD*)showMBProgressHUDAddedTo:(UIView*)view animated:(BOOL)animated;
+ (MBProgressHUD*)showHUDAddedTo:(UIView*)view animated:(BOOL)animated;
+ (void)hideAllMBProgressHUDsForView:(UIView*)view animated:(BOOL)animated;
+ (void)hideAllHUDsForView:(UIView*)view animated:(BOOL)animated;

+ (UIView *)sepreateLineWithY:(CGFloat) y;

+ (NSString *)errorDescription:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
