//
//  UIView+Factory.h
//  tuotianClient
//
//  Created by alankong on 15/7/24.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Factory)

// 生成控件
- (UILabel*)newLabel;
- (UIButton*)newButton;
- (UIButton*)newButtonWithTitle:(NSString*)title;
- (UIImageView*)newImageView;
- (UITextField*)newTextField:(NSString*)placeholder;

// 导航按钮
- (UIButton*)newNavButton:(NSString*)title;

- (UIView*)customContentView;
- (void)addSubview:(UIView *)view toRootView:(BOOL)rootView;

@end
