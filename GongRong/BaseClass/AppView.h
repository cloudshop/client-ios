//
//  AppView.h
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppView : UIView

@property (nonatomic, strong) UIView* customContentView;

- (void)addNavBarView:(UIView *)view;

- (void)layoutSubview:(float)navBarHeight;

@end
