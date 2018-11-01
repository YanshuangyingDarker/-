//
//  XHSegmentControl.m
//  BCManagerProject
//
//  Created by Xaviar on 2016/9/27.
//  Copyright © 2016年 RogerLauren. All rights reserved.
//

#import "XHSegmentControl.h"
#import "UIViewAdditions.h"

@interface XHSegmentControl()

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat startX;

@end

@implementation XHSegmentControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _backgroundView = [[UIImageView alloc] initWithImage:nil];
        _backgroundView.frame = self.bounds;
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];
    }
    return self;
}

- (void)reloadData
{
    if (!self.delegate) {
        return;
    }
    
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    
    NSUInteger sectionNum = [self.delegate numberOfSections:self];
    if (sectionNum <= 0) {
        return;
    }
    
    _segItemWidth = self.width / sectionNum;
    
    [_itemArray removeAllObjects];
    for (int i = 0; i < sectionNum; i++) {
        UIButton *button = [self.delegate segmentControl:self viewForSection:i];
        if (button){
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(segButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_itemArray addObject:button];
        }
        else{
            
        }
    }
    
    [self setNeedsLayout];
}

- (void)segButtonClicked:(UIButton *)sender
{
    NSUInteger index = sender.tag;
    [self selectIndex:index notify:YES animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in _backgroundView.subviews) {
        [view removeFromSuperview];
    }
    
    if (_indicatorImage) {
        _indicatorView = [[UIImageView alloc] initWithImage:_indicatorImage];
        [_backgroundView addSubview:_indicatorView];
        _indicatorView.bottomY = self.height;
        _indicatorView.width = _segItemWidth;
    }
    else {
        _indicatorView = nil;
    }
    
    CGFloat startX = 0;
    
    NSUInteger index = 0;
    for (UIButton *item in _itemArray) {
        item.frame = CGRectMake(startX + _segItemWidth*index, 0, _segItemWidth, self.height - 3.0);
        [_backgroundView addSubview:item];
        
        if (_selectedIndex == index) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
        index ++;
    }
    [self bringSubviewToFront:_indicatorView];
    [self selectIndex:_selectedIndex notify:NO animated:NO];
}

- (void)selectIndex:(NSUInteger)index notify:(BOOL)notify animated:(BOOL)animated
{
    if (index >= _itemArray.count) {
        return;
    }
    
    if (notify) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:willSelectAtSection:)]) {
            BOOL flag = [self.delegate segmentControl:self willSelectAtSection:index];
            if (!flag) {
                return;
            }
        }
    }
    
    for (int i = 0; i < _itemArray.count; i++) {
        UIButton *item = [_itemArray objectAtIndex:i];
        if (i == index) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
    }
    
    if (_indicatorView) {
        CGFloat x = _segItemWidth * index;
        if (animated) {
            [UIView animateWithDuration:0.1f animations:^{
                _indicatorView.leftX = x;
            }];
        }
        else {
            _indicatorView.leftX = x;
        }
    }
    
    if (index != _selectedIndex) {
        _selectedIndex = index;
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:selectedAtSection:)]) {
            [self.delegate segmentControl:self selectedAtSection:index];
        }
    }
}

- (void)setDelegate:(id<XHSegmentControlDelegate>)delegate
{
    _delegate = delegate;
    [self reloadData];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self selectIndex:selectedIndex notify:YES animated:YES];
}

- (void)setBackgroundImage:(UIImage *)image
{
    _backgroundView.image = image;
}



@end
