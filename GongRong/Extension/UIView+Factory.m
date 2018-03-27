//
//  UIView+Factory.m
//  tuotianClient
//
//  Created by alankong on 15/7/24.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "UIView+Factory.h"
#import "AppView.h"

@implementation UIView (Factory)

- (UILabel*)newLabel
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = kAppColor5;
    label.backgroundColor = [UIColor clearColor];
    label.font = kAppFont3;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIButton*)newButton
{
    return [self newButtonWithTitle:nil];
}

- (UIButton*)newButtonWithTitle:(NSString*)title
{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:kAppColor8 forState:UIControlStateNormal];
    [button.titleLabel setFont:kAppBoldFont3];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    
//    [button setBackgroundImage:[UIImage imageFromColor:kAppColor3] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHex:kHexColor3 alpha:0.5]] forState:UIControlStateHighlighted];
    
    return button;
}

- (UIImageView*)newImageView
{
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.backgroundColor = [UIColor clearColor];
    imgView.layer.masksToBounds = YES;
    return imgView;
}

- (UITextField*)newTextField:(NSString*)placeholder
{
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.placeholder = placeholder;
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    textField.textColor = [UIColor blackColor];
    textField.font = kAppFont3;
    return textField;
}

- (UIButton*)newNavButton:(NSString*)title
{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20+(44-kNavButtonSize)/2, kNavButtonSize, kNavButtonSize)];
    button.layer.cornerRadius = kNavButtonSize/2;
    button.layer.masksToBounds = YES;
    
    [button setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHex:0xffffff alpha:0.5]] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = kAppFont4;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kAppColor1 forState:UIControlStateNormal];
    
    return button;
}

- (UIView*)customContentView
{
    return nil;
}

- (void)addSubview:(UIView *)view toRootView:(BOOL)rootView
{
    
}
@end
