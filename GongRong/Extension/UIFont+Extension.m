//
//  UIFont+Extension.m
//  tuotianClient
//
//  Created by alankong on 15/7/21.
//  Copyright (c) 2015年 TuoTianSuDai. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

+ (UIFont *)appNormalFont:(CGFloat)size
{
    return [UIFont fontWithName:@"STHeitiTC-Light" size:size];
}

+ (UIFont *)appBoldFont:(CGFloat)size
{
    return [UIFont fontWithName:@"STHeitiTC-Medium" size:size];
}

@end
