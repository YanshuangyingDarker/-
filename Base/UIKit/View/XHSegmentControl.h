//
//  XHSegmentControl.h
//  BCManagerProject
//
//  Created by Xaviar on 2016/9/27.
//  Copyright © 2016年 RogerLauren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHSegmentControlDelegate;

#import <UIKit/UIKit.h>

@protocol XHSegmentControlDelegate;
@interface XHSegmentControl : UIView
{
    UIImage *_indicatorImage;
    UIImageView *_indicatorView;
    UIImageView *_backgroundView;
    CGFloat _segItemWidth;
    NSMutableArray *_itemArray;
}

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) UIImage *indicatorImage;
@property (nonatomic, weak) id<XHSegmentControlDelegate> delegate;

- (void)setBackgroundImage:(UIImage *)image;
- (void)reloadData;
- (void)selectIndex:(NSUInteger)index notify:(BOOL)notify animated:(BOOL)animated;
@end



@protocol XHSegmentControlDelegate <NSObject>

@required
- (NSUInteger)numberOfSections:(XHSegmentControl *)segControl;
- (UIButton *)segmentControl:(XHSegmentControl *)segControl viewForSection:(NSUInteger)section;

@optional
- (void)segmentControl:(XHSegmentControl *)segControl selectedAtSection:(NSUInteger)section;
- (BOOL)segmentControl:(XHSegmentControl *)segControl willSelectAtSection:(NSUInteger)section;

@end
