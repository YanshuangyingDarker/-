//
//  UIHelper.m
//  XUIKit
//
//  Created by Xaviar on 15/12/4.
//  Copyright © 2015年 Xaviar. All rights reserved.
//

#import "XHUIHelper.h"
#import "XHRequestManager.h"
#import "XHKitMacro.h"
#import "UIViewAdditions.h"
#import "NSStringAddition.h"

@implementation XHUIHelper


#pragma mark - BarButtonItem

+ (UIBarButtonItem *)navBackButtonWithImage:(NSString *)image target:(id)target action:(SEL)action
{
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(0, 0, 21, 21);
    customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [customBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [self navBarButtonWithTitle:title color:[UIColor orangeColor] target:target action:action];
}

+ (UIBarButtonItem *)navBarLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:customBtn.titleLabel.font}];
    customBtn.frame = CGRectMake(0, 0, size.width+20, 29);
    [customBtn setTitle:title forState:UIControlStateNormal];
    [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [customBtn setTitleShadowColor:RGBA(0, 0, 0, 0.2) forState:UIControlStateNormal];
    customBtn.titleLabel.shadowOffset = CGSizeMake(1, 1);
    customBtn.titleLabel.shadowColor = RGBA(0, 0, 0, 0.2);
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarButtonWithTitle:(NSString *)title color:(UIColor*)color target:(id)target action:(SEL)action{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:customBtn.titleLabel.font}];
    customBtn.frame = CGRectMake(0, 0, size.width+20, 29);
    [customBtn setTitleColor:color forState:UIControlStateNormal];
    [customBtn setTitleColor:color forState:UIControlStateHighlighted];
    [customBtn setTitle:title forState:UIControlStateNormal];
    customBtn.titleLabel.shadowOffset = CGSizeMake(0, 0);
    customBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:image forState:UIControlStateNormal];
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    } else {
        customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4);
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *hImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_press"]];
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:image forState:UIControlStateNormal];
    [customBtn setImage:hImage forState:UIControlStateHighlighted];
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (UIBarButtonItem *)navBarButtonLeftWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:image forState:UIControlStateNormal];
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    customBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (nonnull UIBarButtonItem *)navBarButtonWithTitle:(nonnull NSString *)title imageName:(NSString *)imageName
                                            target:(nonnull id)target action:(nonnull SEL)action {
    
    UIButton *customBtn = [[UIButton alloc] init];
    [customBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (title) {
        [customBtn setTitle:title forState:UIControlStateNormal];
        customBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [customBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    ///FIXME: 宽度
    
    CGFloat width = [title sizeForFont:customBtn.titleLabel.font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByWordWrapping].width;
    customBtn.width = customBtn.currentImage.size.width + width + 15;
    customBtn.height = customBtn.currentImage.size.height;
    customBtn.contentEdgeInsets = UIEdgeInsetsMake(0, - 25, 0, 0);
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:customBtn];
}

#pragma mark - MBProgressHUD

+ (BOOL)showError:(NSError*)error withView:(UIView*)view {
    if (!error) return NO;
    
//    [QMUITips showError:[self errorDescription:error]
//                 inView:view hideAfterDelay:1.5];
    return YES;
}

+ (MBProgressHUD *)showAutoHideHUDforView:(UIView *)view title:(NSString *)title {
    return [self showAutoHideHUDforView:view title:nil subTitle:title];
}

+ (MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle {
    return [self showAutoHideHUDforView:view title:title subTitle:subTitle completeBlock:nil];
}

+ (MBProgressHUD *)showAutoHideHUDforView:(UIView *)view title:(NSString *)title completeBlock:(void (^)(void))completion {
    return [self showAutoHideHUDforView:view title:title subTitle:nil completeBlock:completion];
}

+ (MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle completeBlock:(void (^)(void))completion {
    if (!view) return nil;
    [self hideAllHUDsForView:view animated:NO];
    [self hideAllMBProgressHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (completion) {
        hud.completionBlock = completion;
    }
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    if (subTitle)
    {
        hud.detailsLabelText = subTitle;
    }
    
    [hud hide:YES afterDelay:2.0f];
    return hud;
}

+ (void)dealWithNetError:(NSError*)error withView:(UIView *)view
{
    NSString *title;
    switch (error.code) {
            
        default:
            title = @"网络错误，请重试";
            break;
    }
    [[self class] showAutoHideHUDforView:view title:title subTitle:nil];
    
}

+ (MBProgressHUD*)showMBProgressHUDAddedTo:(UIView*)view animated:(BOOL)animated {
    if (!view) {
        return nil;
    }
    [self hideAllMBProgressHUDsForView:view animated:NO];
    return [MBProgressHUD showHUDAddedTo:view animated:animated];
}

+ (void)hideAllMBProgressHUDsForView:(UIView*)view animated:(BOOL)animated {
    if (!view) {
        return;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}

+ (MBProgressHUD*)showHUDAddedTo:(UIView*)view animated:(BOOL)animated {
    return [self showMBProgressHUDAddedTo:view animated:animated];
}

+ (void)hideAllHUDsForView:(UIView*)view animated:(BOOL)animated {
    [self hideAllMBProgressHUDsForView:view animated:animated];
}

+ (UIView *)sepreateLineWithY:(CGFloat)y {
    
    //UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, y - SINGLE_LINE_ADJUST_OFFSET, Device_Width, SINGLE_LINE_WIDTH)];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, y , [UIScreen mainScreen].bounds.size.width, 0.5)];
    v.backgroundColor = [UIColor lightGrayColor];
    return v;
}

+ (NSString *)errorDescription:(NSError *)error {
    
    if ([error.domain isEqualToString:XHRequestErrorDomain]) {
        
        switch (error.code) {
            case XHRequestErrorTokenError:
                return @"token过期，请重新登录";
                break;
            case XHRequestErrorDataEmpty:
                return @"暂时没有数据";
            default:
                return error.userInfo[NSLocalizedDescriptionKey];
        }
    }
    
    
    ////AF 与NSURLSession错误
    switch (error.code) {
        case kCFURLErrorTimedOut:
            return @"链接超时";
            break;
        case kCFURLErrorUnsupportedURL:
            return @"URL链接错误";
            break;
        case kCFURLErrorCannotFindHost:
            return @"找不到主机";
            break;
        case kCFURLErrorCannotConnectToHost:
            return @"找不到主机";
            break;
        case kCFURLErrorNetworkConnectionLost:
            return @"网络似乎有点不好";
            break;
        case kCFURLErrorDNSLookupFailed:
            return @"DNS解析异常";
            break;
        case kCFURLErrorNotConnectedToInternet:
            return @"无法链接到网络";
            break;
        case kCFURLErrorBadServerResponse:
            return @"服务器异常";
            break;
        case kCFURLErrorDataNotAllowed:
            return @"参数异常";
            break;
        case kCFURLErrorInternationalRoamingOff:
            return @"没有开启网络链接";
        default:
            return error.userInfo[NSLocalizedDescriptionKey];
    }

}

@end
