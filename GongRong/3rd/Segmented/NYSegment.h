//
//  NYSegment.h
//  WGSDK
//
//  Created by wihan on 14-11-3.
//  Copyright (c) 2014年 WeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSegment;

@interface NYSegment : UIView

@property (nonatomic) UILabel *titleLabel;

@property (nonatomic) UIView *lineView;

- (instancetype)initWithTitle:(NSString *)title;

@end

