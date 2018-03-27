//
//  AppView.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "AppView.h"
#import "AppContentView.h"

@implementation AppView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.customContentView = [[AppContentView alloc] initWithFrame:frame];
        [super addSubview:self.customContentView];
    }
    
    return self;
}

- (void)addNavBarView:(UIView *)view
{
    [super addSubview:view];
}

- (void)addSubview:(UIView *)view
{
    [self addSubview:view toRootView:NO];
}

- (void)addSubview:(UIView *)view toRootView:(BOOL)rootView
{
    if (rootView) {
        [super addSubview:view];
    } else {
        if (self.customContentView) {
            [self.customContentView addSubview:view];
        } else {
            [super addSubview:view];
        }
    }
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    if (self.customContentView) {
        [self.customContentView insertSubview:view atIndex:index];
    } else {
        [super insertSubview:view atIndex:index];
    }
}

- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    if (self.customContentView) {
        [self.customContentView insertSubview:view belowSubview:siblingSubview];
    } else {
        [super insertSubview:view belowSubview:siblingSubview];
    }
}

- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    if (self.customContentView) {
        [self.customContentView insertSubview:view aboveSubview:siblingSubview];
    } else {
        [super insertSubview:view aboveSubview:siblingSubview];
    }
}

- (void)bringSubviewToFront:(UIView *)view
{
    if (self.customContentView) {
        [self.customContentView bringSubviewToFront:view];
    } else {
        [super bringSubviewToFront:view];
    }
}

- (void)sendSubviewToBack:(UIView *)view
{
    if (self.customContentView) {
        [self.customContentView sendSubviewToBack:view];
    } else {
        [super sendSubviewToBack:view];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [self.customContentView setBackgroundColor:backgroundColor];
}

- (void)layoutSubview:(float)navBarHeight
{
    if (self.customContentView) {
        self.customContentView.frame = CGRectMake(0, navBarHeight, self.width, self.height-navBarHeight);
    }
}

@end
