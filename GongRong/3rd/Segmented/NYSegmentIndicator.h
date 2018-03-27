//
//  NYSegmentIndicator.h
//  WGSDK
//
//  Created by wihan on 14-11-3.
//  Copyright (c) 2014年 WeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYSegmentIndicator : UIView

@property (nonatomic) CGFloat cornerRadius;

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) UIColor *borderColor;

@property (nonatomic) BOOL drawsGradientBackground;
@property (nonatomic) UIColor *gradientTopColor;
@property (nonatomic) UIColor *gradientBottomColor;

@end
