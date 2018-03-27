//
//  AppContentView.m
//  tuotianClient
//
//  Created by alankong on 15/7/24.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "AppContentView.h"

@implementation AppContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([[self subviews] count] == 1) {
        UIView* subview = [[self subviews] firstObject];
        if ([subview isKindOfClass:[UIScrollView class]]) {
            subview.frame = self.bounds;//只有一个UIScrorllView类型的子view，设frame为contentView的bounds大小
        }
    }
}

@end
